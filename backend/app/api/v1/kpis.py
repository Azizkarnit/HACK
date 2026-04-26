from fastapi import APIRouter, Depends, HTTPException
from db.supabase import supabase
from api.deps import get_current_user
from utils.permissions import can_access_institution, can_write

from schemas.kpi import (
    KpiDefinitionCreate,
    KpiDefinitionResponse,
    KpiValueCreate,
    KpiValueResponse
)

from services.kpi_service import (
    list_kpi_definitions,
    create_new_kpi_definition,
    list_kpi_values,
    create_new_kpi_value
)

router = APIRouter(prefix="/kpis", tags=["KPIs"])


# =========================
# KPI DEFINITIONS
# =========================

@router.get("/definitions", response_model=list[KpiDefinitionResponse])
def get_definitions(user=Depends(get_current_user)):
    # Definitions are public to all UCAR staff (to see what is being tracked)
    return list_kpi_definitions(supabase)


@router.post("/definitions", response_model=KpiDefinitionResponse)
def create_definition(
    data: KpiDefinitionCreate,
    user=Depends(get_current_user)
):
    # Only Super Admins can define new KPI types
    if user["role"] != "super_admin":
        raise HTTPException(status_code=403, detail="Only Super Admins can create new KPI definitions")
    return create_new_kpi_definition(supabase, data.dict())


# =========================
# KPI VALUES
# =========================

@router.get("/values", response_model=list[KpiValueResponse])
def get_values(
    institution_id: str | None = None,
    user=Depends(get_current_user)
):
    # If no institution_id, use the user's own institution
    target_id = institution_id or user.get("institution_id")
    
    if not target_id:
        # Super Admin without inst_id might want all data, but let's enforce list_kpi_values logic
        if user["role"] != "super_admin":
             raise HTTPException(status_code=403, detail="No institution ID provided")

    # Security Check
    if target_id and not can_access_institution(user, target_id):
        raise HTTPException(status_code=403, detail="Access denied to this institution's data")

    return list_kpi_values(supabase, target_id)


@router.post("/values", response_model=KpiValueResponse)
def create_value(
    data: KpiValueCreate,
    user=Depends(get_current_user)
):
    # Security Check: Must have write access to the institution
    if not can_access_institution(user, str(data.institution_id)) or not can_write(user):
        raise HTTPException(status_code=403, detail="Insufficient permissions to record KPI values")

    return create_new_kpi_value(supabase, data.dict())