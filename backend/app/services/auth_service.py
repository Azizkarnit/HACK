from fastapi import HTTPException
from db.supabase import supabase

def register_user(data):
    # 1. Validate institution code first
    inst_res = supabase.table("institutions") \
        .select("*") \
        .eq("code", data.institution_code) \
        .execute()

    if not inst_res.data:
        raise HTTPException(status_code=400, detail="Invalid institution code")
    
    institution = inst_res.data[0]

    # 2. Create user in Supabase Auth
    try:
        auth_response = supabase.auth.sign_up({
            "email": data.email,
            "password": data.password,
            "options": {
                "data": {
                    "full_name": data.full_name,
                    "role": "admin",
                    "institution_id": institution["id"]
                }
            }
        })
    except Exception as e:
        error_msg = str(e).lower()
        if "rate limit" in error_msg:
            raise HTTPException(status_code=429, detail="Too many signup attempts.")
        raise HTTPException(status_code=400, detail=f"Auth signup failed: {str(e)}")

    if not auth_response.user:
        raise HTTPException(status_code=400, detail="Auth signup failed")

    user_id = auth_response.user.id

    # We no longer manually insert into public.users.
    # The PostgreSQL Trigger 'on_auth_user_created' will handle this automatically based on the metadata above.

    return {
        "message": "User registered successfully and linked to " + institution["name"],
        "user_id": user_id
    }

def login_user(data):
    try:
        response = supabase.auth.sign_in_with_password({
            "email": data.email,
            "password": data.password
        })
    except Exception as e:
        raise HTTPException(status_code=401, detail=f"Login failed: {str(e)}")

    if not response.session:
        raise HTTPException(status_code=401, detail="Login failed")

    user_id = response.user.id
    user_res = supabase.table("users").select("*, institutions(name)").eq("id", user_id).execute()
    custom_user = user_res.data[0] if user_res.data else {
        "id": user_id,
        "email": data.email,
        "role": "authenticated"
    }
    
    # Flatten institution name if available
    if custom_user.get("institutions"):
        custom_user["institution_name"] = custom_user["institutions"].get("name")
        del custom_user["institutions"]

    return {
        "access_token": response.session.access_token,
        "token_type": "bearer",
        "user": custom_user
    }