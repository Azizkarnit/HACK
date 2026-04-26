from supabase import create_client, Client
from app.core.config import settings

def test_connection_only():
    url = settings.supabase_url
    key = settings.supabase_key
    
    if not url or not key:
        print("[ERROR] Missing credentials in .env")
        return

    print(f"Testing connection to: {url}")
    try:
        supabase: Client = create_client(url, key)
        # Check API access
        res = supabase.auth.get_session()
        print("[SUCCESS] API Key is VALID and connection is LIVE!")
        
        print("\nChecking for 'institutions' table...")
        try:
            # We use a limit(0) just to check if the table exists
            res = supabase.table("institutions").select("name").limit(1).execute()
            print("[SUCCESS] Table 'institutions' exists!")
            print(f"Data found: {res.data}")
        except Exception as e:
            err_msg = str(e)
            if "42501" in err_msg:
                print("[ERROR] TABLE ACCESS DENIED: RLS is blocking you. Are you SURE this is the 'service_role' key?")
            elif "42P01" in err_msg or "not found" in err_msg.lower():
                print("[ERROR] TABLE MISSING: The table 'institutions' does not exist in your database.")
            else:
                print(f"[ERROR] Table error: {err_msg}")

    except Exception as e:
        print(f"[ERROR] Connection/Auth failed: {e}")

if __name__ == "__main__":
    test_connection_only()
