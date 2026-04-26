from langchain_openai import OpenAIEmbeddings
from langchain_chroma import Chroma
from core.config import settings
import logging
import os

logger = logging.getLogger(__name__)

class VectorService:
    def __init__(self):
        self.vector_db = None
        if settings.openai_api_key:
            try:
                embeddings = OpenAIEmbeddings(api_key=settings.openai_api_key)
                persist_directory = os.path.join(os.getcwd(), "chroma_db")
                self.vector_db = Chroma(
                    persist_directory=persist_directory,
                    embedding_function=embeddings
                )
                logger.info("Vector DB initialized successfully")
            except Exception as e:
                logger.error(f"Vector DB Init Error: {str(e)}")

    async def add_document(self, text: str, metadata: dict):
        if not self.vector_db:
            logger.warning("Vector DB not initialized. Skipping document storage.")
            return

        try:
            # Chunking text for better RAG performance
            chunks = [text[i:i+2000] for i in range(0, len(text), 2000)]
            self.vector_db.add_texts(
                texts=chunks,
                metadatas=[metadata] * len(chunks)
            )
        except Exception as e:
            logger.error(f"Error adding document to Vector DB: {str(e)}")

    async def search_similar(self, query: str, institution_id: str = None, k: int = 3):
        if not self.vector_db:
            return []

        try:
            # CRITICAL SECURITY: If institution_id is provided, enforce it as a hard filter
            filter_dict = {"institution_id": institution_id} if institution_id else None
            
            results = self.vector_db.similarity_search(
                query, 
                k=k, 
                filter=filter_dict
            )
            return results
        except Exception as e:
            logger.error(f"Vector Search Error: {str(e)}")
            return []

vector_service = VectorService()
