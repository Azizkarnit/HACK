from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import JsonOutputParser
from core.config import settings
import logging
import json

logger = logging.getLogger(__name__)

class ParserService:
    def __init__(self):
        self.llm = None
        # Use GitHub Token if provided, otherwise fallback to OpenAI Key
        api_key = settings.github_token or settings.openai_api_key
        
        if api_key:
            self.llm = ChatOpenAI(
                api_key=api_key,
                base_url=settings.openai_api_base if settings.github_token else None,
                model="gpt-4o",
                temperature=0
            )

    async def parse_document(self, text: str, doc_type: str) -> dict:
        if not self.llm:
            logger.warning("OpenAI API Key not set. Returning mock parsed data.")
            return self._get_mock_data(doc_type)

        # Token protection: Truncate text to avoid context window overflow
        truncated_text = text[:15000] 

        prompt = ChatPromptTemplate.from_template(
            """
            Extract structured data from the following text based on the document type: {doc_type}.
            Return ONLY a valid JSON object.
            
            CRITICAL: All dates must be in YYYY-MM-DD format.
            CRITICAL: All monetary values must be numbers (no currency symbols).
            
            Text:
            {text}
            
            JSON Structure (Return ONLY valid JSON):
            - If student: {{ "student_id", "first_name", "last_name", "email", "major", "gpa", "attendance_rate", "dropout_risk" }}
            - If hr: {{ "employee_id", "full_name", "department", "role", "salary", "absenteeism_rate" }}
            - If finance: {{ "transaction_id", "date", "category", "amount", "budget_execution_rate" }}
            - If esg: {{ "energy_consumption", "carbon_footprint", "recycling_rate", "accessibility_score" }}
            - If research: {{ "publications_count", "active_projects", "funding_secured", "patents_filed" }}
            - If infra: {{ "classroom_occupancy", "it_equipment_status", "maintenance_required" }}
            """
        )

        chain = prompt | self.llm | JsonOutputParser()
        
        try:
            result = await chain.ainvoke({"text": truncated_text, "doc_type": doc_type})
            return result
        except Exception as e:
            logger.error(f"Parsing Error: {str(e)}")
            return self._get_mock_data(doc_type)

    def _get_mock_data(self, doc_type: str) -> dict:
        if doc_type == "student":
            return {
                "student_id": "STU123",
                "first_name": "John",
                "last_name": "Doe",
                "email": "john.doe@example.com",
                "major": "Computer Science",
                "gpa": 3.8,
                "attendance_rate": 0.95
            }
        elif doc_type == "hr":
            return {
                "employee_id": "EMP456",
                "full_name": "Jane Smith",
                "department": "Engineering",
                "role": "Senior Developer",
                "salary": 85000
            }
        else:
            return {
                "transaction_id": "TRX789",
                "date": "2024-04-25",
                "category": "Office Supplies",
                "amount": 250.0,
                "description": "New monitors"
            }

parser_service = ParserService()
