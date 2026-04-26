from fastapi import APIRouter, Depends, HTTPException
from db.supabase import supabase
from schemas.institution import InstitutionCreate, InstitutionUpdate, InstitutionResponse
from api.deps import get_current_user
from typing import List
from utils.permissions import can_access_institution

router = APIRouter(tags=["institutions"])

@router.get("", response_model=List[InstitutionResponse])
async def get_institutions(user=Depends(get_current_user)):
    # Only super_admin can see all institutions
    if user["role"] != "super_admin":
        raise HTTPException(status_code=403, detail="Not authorized to list all institutions")
    
    res = supabase.table("institutions").select("*").execute()
    return res.data

@router.post("/", response_model=InstitutionResponse)
async def create_institution(data: InstitutionCreate, user=Depends(get_current_user)):
    if user["role"] != "super_admin":
        raise HTTPException(status_code=403, detail="Not authorized to create institutions")
        
    res = supabase.table("institutions").insert(data.dict()).execute()
    if not res.data:
        raise HTTPException(status_code=400, detail="Failed to create institution")
    return res.data[0]

@router.get("/{institution_id}", response_model=InstitutionResponse)
async def get_institution(institution_id: str, user=Depends(get_current_user)):
    # Secure check: only Super Admin or a member of THIS institution
    if not can_access_institution(user, institution_id):
        raise HTTPException(status_code=403, detail="Access denied to this institution")

    res = supabase.table("institutions").select("*").eq("id", institution_id).execute()
    if not res.data:
        raise HTTPException(status_code=404, detail="Institution not found")
    return res.data[0]

@router.patch("/{institution_id}", response_model=InstitutionResponse)
async def update_institution(institution_id: str, data: InstitutionUpdate, user=Depends(get_current_user)):
    if user["role"] != "super_admin":
        raise HTTPException(status_code=403, detail="Not authorized to update institutions")
        
    res = supabase.table("institutions").update(data.dict(exclude_unset=True)).eq("id", institution_id).execute()
    if not res.data:
         raise HTTPException(status_code=404, detail="Institution not found or update failed")
    return res.data[0]
