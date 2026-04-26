from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel
from api.deps import get_current_user
from db.supabase import supabase
import httpx
import os

router = APIRouter(prefix="/users", tags=["User Management"])

N8N_WEBHOOK_URL = os.getenv("N8N_WEBHOOK_URL", "")


class CreateUserPayload(BaseModel):
    full_name: str
    email: str
    role: str  # 'agent' | 'admin'
    institution: str = ""
    password: str


@router.post("/create")
async def create_user(payload: CreateUserPayload, user=Depends(get_current_user)):
    # Only super admins can create users
    if user["role"] != "super_admin":
        raise HTTPException(403, "Only Super Admins can create users")

    # 1. Look up institution ID if an institution name was provided
    institution_id = None
    if payload.institution:
        inst_res = supabase.table("institutions").select("id").eq("name", payload.institution).execute()
        if inst_res.data:
            institution_id = inst_res.data[0]["id"]

    # 2. Create the user in Supabase Auth
    try:
        auth_response = supabase.auth.admin.create_user({
            "email": payload.email,
            "password": payload.password,
            "email_confirm": True,  # Auto-confirm so they can log in immediately
            "user_metadata": {
                "full_name": payload.full_name,
                "role": payload.role,
                "institution_id": institution_id
            }
        })
    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Failed to create user in auth: {str(e)}")

    if not auth_response.user:
        raise HTTPException(status_code=400, detail="User creation failed")

    # 3. Trigger n8n webhook to send welcome email
    if N8N_WEBHOOK_URL:
        try:
            async with httpx.AsyncClient() as client:
                await client.post(N8N_WEBHOOK_URL, json={
                    "full_name": payload.full_name,
                    "email": payload.email,
                    "password": payload.password,
                    "role": payload.role,
                    "institution": payload.institution or "All Institutions",
                    "platform_url": "http://localhost:4200"
                }, timeout=10.0)
        except Exception as e:
            # Don't fail the user creation if the email fails — just log it
            print(f"[WARNING] n8n webhook failed: {str(e)}")

    return {
        "status": "success",
        "message": f"User {payload.email} created successfully. Welcome email triggered.",
        "user_id": auth_response.user.id
    }
