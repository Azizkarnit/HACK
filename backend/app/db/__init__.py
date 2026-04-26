import os
from supabase import create_client, Client
from dotenv import load_dotenv

# Load .env from the app directory
env_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), ".env")
load_dotenv(env_path)

supabase_url = os.getenv("SUPABASE_URL")
supabase_key = os.getenv("SUPABASE_KEY")

print("SUPABASE_URL =", supabase_url)
print("SUPABASE_KEY =", supabase_key)

if not supabase_url or not supabase_key:
    print("[WARNING] .env not loaded or variables missing")

supabase: Client = create_client(supabase_url or "", supabase_key or "")