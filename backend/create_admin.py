import asyncio
from supabase import create_client, Client
from app.core.config import settings

# NOTE: This script assumes you are using the service_role key in your .env

def create_super_admin():
    url = settings.supabase_url
    key = settings.supabase_key
    
    if not url or not key:
        print("[ERROR] Missing SUPABASE_URL or SUPABASE_KEY in .env")
        return

    supabase: Client = create_client(url, key)

    print("=== U-OS Platform Initialization ===")
    
    # 1. Create a Global Institution (UCAR HQ) if it doesn't exist
    print("\n1. Setting up Global Institution (UCAR HQ)...")
    inst_code = "UCAR-HQ"
    
    # Check if exists
    res = supabase.table("institutions").select("*").eq("code", inst_code).execute()
    
    if res.data:
        print("   -> UCAR HQ already exists.")
        inst_id = res.data[0]["id"]
    else:
        try:
            insert_res = supabase.table("institutions").insert({
                "code": inst_code,
                "name": "UCAR Headquarters"
            }).execute()
            inst_id = insert_res.data[0]["id"]
            print("   -> Created UCAR HQ institution.")
        except Exception as e:
            print(f"[ERROR] Failed to create institution: {e}")
            return

    # 2. Create or fetch the Super Admin user
    print("\n2. Creating Super Admin Account...")
    admin_email = "admin@ucar.tn"
    admin_password = "adminpassword123"
    
    user_id = None
    try:
        auth_res = supabase.auth.admin.create_user({
            "email": admin_email,
            "password": admin_password,
            "email_confirm": True,
            "user_metadata": {
                "full_name": "System Administrator",
                "role": "super_admin",
                "institution_id": None
            }
        })
        user_id = auth_res.user.id
        print(f"   -> Auth account created for {admin_email} (DB trigger will handle public.users sync).")
    except Exception as e:
        err_str = str(e).lower()
        if "already exists" in err_str or "already been registered" in err_str or "422" in err_str:
            print(f"   -> Auth account {admin_email} already exists. Force-syncing metadata...")
            users = supabase.auth.admin.list_users()
            for u in users:
                if u.email == admin_email:
                    user_id = u.id
                    # Update metadata to trigger the DB sync
                    supabase.auth.admin.update_user_by_id(
                        user_id, 
                        {"user_metadata": {"full_name": "System Administrator", "role": "super_admin", "institution_id": None}}
                    )
                    break
            if not user_id:
                print("[ERROR] Could not find existing user ID.")
                return
        else:
            print(f"[ERROR] Auth creation failed: {e}")
            return

    # We no longer manually insert into public.users.
    # The PostgreSQL Trigger 'on_auth_user_created' will handle this automatically.

    print("\n=== Initialization Complete ===")
    print("You can now log into the frontend with:")
    print(f"Email:    {admin_email}")
    print(f"Password: {admin_password}")

if __name__ == "__main__":
    create_super_admin()
