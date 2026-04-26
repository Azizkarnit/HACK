import os
from dotenv import load_dotenv

# Load .env from the app directory
env_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), ".env")
load_dotenv(env_path)

class Settings:
    supabase_url = os.getenv("SUPABASE_URL")
    supabase_key = os.getenv("SUPABASE_KEY")
    openai_api_key = os.getenv("OPENAI_API_KEY")
    github_token = os.getenv("GITHUB_TOKEN")
    
    # Auto-detection: If OpenAI key is actually a GitHub token, move it
    if openai_api_key and openai_api_key.startswith("ghp_"):
        github_token = openai_api_key
        openai_api_key = None
        
    openai_model = os.getenv("OPENAI_MODEL", "gpt-4o")
    openai_api_base = os.getenv("OPENAI_API_BASE", "https://models.github.ai/inference")
    
    JWT_SECRET_KEY = os.getenv("JWT_SECRET_KEY", "super-secret-key-change-me")
    JWT_ALGORITHM = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES = 60 * 24  # 1 day

settings = Settings()