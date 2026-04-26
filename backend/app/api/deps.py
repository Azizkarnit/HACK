from fastapi import Depends, HTTPException
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from db.supabase import supabase

security = HTTPBearer()

def get_current_user(
    credentials: HTTPAuthorizationCredentials = Depends(security)
):
    token = credentials.credentials

    try:
        # Verify the token with Supabase
        auth_user = supabase.auth.get_user(jwt=token)
        if not auth_user or not auth_user.user:
            raise HTTPException(status_code=401, detail="Invalid session")
            
        user_id = auth_user.user.id
        
        # Get extra user info (role, etc) from our public.users table
        user_res = supabase.table("users").select("*").eq("id", user_id).execute()
        if not user_res.data:
            # Fallback to metadata if public.users sync hasn't happened yet
            return {
                "id": user_id,
                "email": auth_user.user.email,
                "role": auth_user.user.user_metadata.get("role", "agent"),
                "institution_id": auth_user.user.user_metadata.get("institution_id")
            }
            
        return user_res.data[0]
        
    except Exception as e:
        print(f"Token validation error: {str(e)}")
        # Catch expired tokens, invalid signatures, etc
        raise HTTPException(
            status_code=401, 
            detail=f"Session expired or invalid: {str(e)}"
        )