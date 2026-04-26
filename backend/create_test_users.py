import asyncio
from supabase import create_client, Client
from app.core.config import settings

def create_test_users():
    url = settings.supabase_url
    key = settings.supabase_key
    
    if not url or not key:
        print("[ERROR] Missing SUPABASE_URL or SUPABASE_KEY in .env")
        return

    supabase: Client = create_client(url, key)

    print("=== Creating Global & Local Test Users ===")
    
    # Fetch all institutions to link users correctly
    inst_res = supabase.table("institutions").select("id, code, name").execute()
    inst_map = {i["code"]: i["id"] for i in inst_res.data}

    if "ISG-TUNIS" not in inst_map or "ESCT" not in inst_map or "UCAR-HQ" not in inst_map:
        print("[ERROR] Missing core institutions. Please run seed_data.py first!")
        return

    test_users = [
        # LOCAL ADMIN 1: ISG Tunis
        {
            "email": "admin@isg.tn",
            "password": "localpassword123",
            "full_name": "ISG Administrator",
            "role": "admin",
            "institution_id": inst_map["ISG-TUNIS"]
        },
        # LOCAL ADMIN 2: ESCT
        {
            "email": "admin@esct.tn",
            "password": "localpassword123",
            "full_name": "ESCT Administrator",
            "role": "admin",
            "institution_id": inst_map["ESCT"]
        },
        # GLOBAL AGENT: UCAR HQ
        {
            "email": "agent@ucar.tn",
            "password": "agentpassword123",
            "full_name": "HQ Data Analyst",
            "role": "agent",
            "institution_id": inst_map["UCAR-HQ"]
        }
    ]

    for u in test_users:
        print(f"\nProcessing User: {u['email']} ({u['role']})")
        user_id = None
        try:
            auth_res = supabase.auth.admin.create_user({
                "email": u["email"],
                "password": u["password"],
                "email_confirm": True,
                "user_metadata": {
                    "full_name": u["full_name"],
                    "role": u["role"],
                    "institution_id": u["institution_id"]
                }
            })
            user_id = auth_res.user.id
            print(f"   -> Auth account created.")
        except Exception as e:
            err_str = str(e).lower()
            if "already exists" in err_str or "already been registered" in err_str:
                print(f"   -> Auth account already exists. Force-syncing metadata...")
                users = supabase.auth.admin.list_users()
                for existing_u in users:
                    if existing_u.email == u["email"]:
                        user_id = existing_u.id
                        # Update metadata to trigger the DB sync
                        supabase.auth.admin.update_user_by_id(
                            user_id, 
                            {"user_metadata": {"full_name": u["full_name"], "role": u["role"], "institution_id": u["institution_id"]}}
                        )
                        break
            else:
                print(f"[ERROR] Auth creation failed: {e}")
                continue

    print("\n=== All Test Users Synced ===")
    for u in test_users:
        print(f"Role: {u['role'].ljust(12)} | Email: {u['email'].ljust(18)} | Password: {u['password']}")

if __name__ == "__main__":
    create_test_users()
