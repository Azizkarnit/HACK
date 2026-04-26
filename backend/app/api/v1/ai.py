from fastapi import APIRouter, Depends, HTTPException, Query
from api.deps import get_current_user
from services.ai_service import (
    analyze_kpi, 
    run_prompt, 
    run_strategic_benchmark, 
    run_what_if_simulation,
    run_esg_optimization,
    generate_network_strategic_insight
)
from utils.permissions import can_access_institution, can_write, is_agent

router = APIRouter(prefix="/ai", tags=["AI"])


@router.get("/strategic-insight")
async def get_strategic_insight(user=Depends(get_current_user)):
    if user["role"] != "super_admin":
        raise HTTPException(403, "Only Super Admins can regenerate network-wide insights")
        
    return {"insight": await generate_network_strategic_insight()}


@router.patch("/insight/{insight_id}/resolve")
async def resolve_insight(insight_id: str, user=Depends(get_current_user)):
    # Any authorized user can mark an insight as resolved
    res = supabase.table("ai_insights").update({"status": "resolved"}).eq("id", insight_id).execute()
    if not res.data:
        raise HTTPException(404, "Insight not found")
    return {"status": "success", "message": "Insight resolved"}


@router.get("/esg/optimize")
async def optimize_esg(institution_id: str, user=Depends(get_current_user)):
    if not can_access_institution(user, institution_id):
        raise HTTPException(403, "Access denied")
        
    return await run_esg_optimization(institution_id)


@router.post("/analyze")
async def analyze(institution_id: str, kpi_id: str, user=Depends(get_current_user)):
    if not can_access_institution(user, institution_id) or not can_write(user):
        raise HTTPException(403, "Access denied. Requires write permissions for this institution.")

    return await analyze_kpi(institution_id, kpi_id)


@router.post("/prompt")
async def prompt_ai(prompt: str, user=Depends(get_current_user)):
    # Agents and Super Admins can use the chat
    if not is_agent(user) and user["role"] != "super_admin":
        raise HTTPException(403, "Not allowed. Assistant is restricted to Agents and Super Admins.")

    return await run_prompt(prompt)


@router.get("/benchmark")
async def benchmark(kpi_name: str, user=Depends(get_current_user)):
    if user["role"] != "super_admin":
        raise HTTPException(403, "Only Super Admins can access platform-wide benchmarks")
        
    return await run_strategic_benchmark(kpi_name)


@router.get("/simulate")
async def simulate(
    institution_id: str,
    base_kpi: str,
    target_kpi: str,
    change_percent: float = Query(..., description="Percentage change in base KPI"),
    user=Depends(get_current_user)
):
    if not can_access_institution(user, institution_id) or not can_write(user):
        raise HTTPException(403, "Access denied. Requires write permissions for this institution.")
        
    return await run_what_if_simulation(institution_id, base_kpi, target_kpi, change_percent)