import jwt
from fastapi import Depends, HTTPException
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from db.supabase import supabase

security = HTTPBearer()

def get_current_user(
    credentials: HTTPAuthorizationCredentials = Depends(security)
):
    token = credentials.credentials

    try:
        # Decode the token locally to avoid global supabase client race conditions
        payload = jwt.decode(token, options={"verify_signature": False})
        user_id = payload.get("sub")
        
        if not user_id:
            raise HTTPException(status_code=401, detail="Invalid session")
            
        # Get extra user info (role, etc) from our public.users table using the service role client
        user_res = supabase.table("users").select("*").eq("id", user_id).execute()
        if not user_res.data:
            # Fallback to metadata if public.users sync hasn't happened yet
            user_metadata = payload.get("user_metadata", {})
            return {
                "id": user_id,
                "email": payload.get("email"),
                "role": user_metadata.get("role", "agent"),
                "institution_id": user_metadata.get("institution_id")
            }
            
        return user_res.data[0]
        
    except Exception as e:
        print(f"Token validation error: {str(e)}")
        raise HTTPException(
            status_code=401, 
            detail=f"Session expired or invalid: {str(e)}"
        )