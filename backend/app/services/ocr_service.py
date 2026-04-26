import pytesseract
from PIL import Image
import io
from pdf2image import convert_from_bytes
import logging

logger = logging.getLogger(__name__)

class OCRService:
    @staticmethod
    def extract_text_from_image(image_bytes: bytes) -> str:
        try:
            image = Image.open(io.BytesIO(image_bytes))
            text = pytesseract.image_to_string(image)
            return text
        except Exception as e:
            logger.error(f"OCR Image Error: {str(e)}")
            raise e

    @staticmethod
    def extract_text_from_pdf(pdf_bytes: bytes) -> str:
        try:
            images = convert_from_bytes(pdf_bytes)
            full_text = ""
            for image in images:
                full_text += pytesseract.image_to_string(image) + "\n"
            return full_text
        except Exception as e:
            logger.error(f"OCR PDF Error: {str(e)}")
            raise e

ocr_service = OCRService()
