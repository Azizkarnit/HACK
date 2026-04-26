from fastapi import APIRouter, UploadFile, File, Form, HTTPException,Depends
from services.ocr_service import ocr_service
from services.parser_service import parser_service
from services.vector_service import vector_service
from schemas.data_ingestion import IngestionResponse
import logging
from api.deps import get_current_user

router = APIRouter()
logger = logging.getLogger(__name__)

import pandas as pd
import io

from utils.permissions import can_write

@router.post("/upload", response_model=IngestionResponse)
async def upload_document(
    file: UploadFile = File(...),
    doc_type: str = Form(...), # 'student', 'hr', 'finance', 'esg', 'research', 'infra'
    institution_id: str = Form("default"),
    user=Depends(get_current_user)
):
    if not can_write(user):
        raise HTTPException(status_code=403, detail="Insufficient permissions to upload documents")
    valid_types = ['student', 'hr', 'finance', 'esg', 'research', 'infra']
    if doc_type not in valid_types:
        raise HTTPException(status_code=400, detail=f"Invalid document type. Must be one of {valid_types}")

    try:
        contents = await file.read()
        filename = file.filename.lower()
        
        text = ""
        parsed_data = {}

        if filename.endswith(('.png', '.jpg', '.jpeg')):
            text = ocr_service.extract_text_from_image(contents)
            parsed_data = await parser_service.parse_document(text, doc_type)
        elif filename.endswith('.pdf'):
            text = ocr_service.extract_text_from_pdf(contents)
            parsed_data = await parser_service.parse_document(text, doc_type)
        elif filename.endswith(('.xlsx', '.xls', '.csv')):
            # Direct processing for structured files
            if filename.endswith('.csv'):
                df = pd.read_csv(io.BytesIO(contents))
            else:
                df = pd.read_excel(io.BytesIO(contents))
            
            # Safe conversion: avoid IndexError on empty files
            parsed_data = df.to_dict(orient='records')[0] if not df.empty else {}
            text = df.to_string() if not df.empty else "Empty document"
        else:
            raise HTTPException(status_code=400, detail="Unsupported file format")

        # Index in Vector DB for RAG
        await vector_service.add_document(
            text=text,
            metadata={
                "institution_id": institution_id,
                "document_type": doc_type,
                "filename": filename
            }
        )
        
        return IngestionResponse(
            status="success",
            document_type=doc_type,
            extracted_data=parsed_data,
            message="Document processed and indexed successfully"
        )

    except HTTPException as e:
        raise e
    except Exception as e:
        logger.error(f"Ingestion API Error: {str(e)}")
        raise HTTPException(status_code=500, detail=str(e))
