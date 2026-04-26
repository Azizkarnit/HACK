from fastapi import APIRouter, Depends, HTTPException, Query
from api.deps import get_current_user
from db.supabase import supabase
from fastapi.responses import StreamingResponse
from services.report_service import report_service
from utils.permissions import can_access_institution

router = APIRouter(prefix="/dashboard", tags=["Dashboard"])


@router.get("/global")
def global_dashboard(user=Depends(get_current_user)):
    # Only Super Admins can see the total global data
    if user["role"] != "super_admin":
        raise HTTPException(status_code=403, detail="Global view is restricted to Super Admins")

    try:
        print("Fetching global dashboard data...")
        kpis = supabase.table("kpi_values").select("*, kpi_definitions(name, category), institutions(name)").order("period_date", desc=True).limit(1000).execute().data
        insights = supabase.table("ai_insights").select("*, kpi_definitions(name, category), institutions(name)").neq("status", "resolved").order("created_at", desc=True).limit(100).execute().data
        alerts = supabase.table("alerts").select("*, institutions(name)").order("created_at", desc=True).limit(100).execute().data
        
        # Simpler count
        activity_res = supabase.table("system_activity").select("id").eq("type", "report_generated").execute()
        report_count = len(activity_res.data) if activity_res.data else 0
        print(f"Loaded: {len(kpis)} KPIs, {len(insights)} Insights, {report_count} Reports")
    except Exception as e:
        print(f"Dashboard Error: {str(e)}")
        return {"kpis": [], "insights": [], "alerts": [], "report_count": 0, "error": str(e)}

    return {
        "kpis": kpis,
        "insights": insights,
        "alerts": alerts,
        "report_count": report_count
    }

@router.get("/institution")
def institution_dashboard(
    institution_id: str = Query(None),
    user=Depends(get_current_user)
):
    # If provided and user is super_admin/agent, use that. Otherwise use user's own inst_id.
    if institution_id and user["role"] in ["super_admin", "agent"]:
        inst_id = institution_id
    else:
        inst_id = user.get("institution_id")
        
    if not inst_id:
         raise HTTPException(status_code=403, detail="No institution associated with this user")

    try:
        kpis = supabase.table("kpi_values") \
            .select("*, kpi_definitions(name, category), institutions(name)") \
            .eq("institution_id", inst_id) \
            .execute().data
            
        insights = supabase.table("ai_insights") \
            .select("*, kpi_definitions(name, category), institutions(name)") \
            .eq("institution_id", inst_id) \
            .neq("status", "resolved") \
            .execute().data
            
        alerts = supabase.table("alerts") \
            .select("*, institutions(name)") \
            .eq("institution_id", inst_id) \
            .execute().data
    except Exception as e:
        return {
            "kpis": [],
            "insights": [],
            "alerts": [],
            "error": str(e)
        }

    return {
        "kpis": kpis,
        "insights": insights,
        "alerts": alerts
    }

@router.get("/compare")
async def compare_institutions(kpi_code: str, user=Depends(get_current_user)):
    if user["role"] != "super_admin":
         raise HTTPException(status_code=403, detail="Unauthorized")

    # 1. Resolve KPI code to ID
    kpi_def = supabase.table("kpi_definitions").select("id").eq("code", kpi_code).execute().data
    if not kpi_def:
        raise HTTPException(status_code=404, detail=f"KPI with code {kpi_code} not found")
    
    kpi_id = kpi_def[0]["id"]

    # 2. Fetch values ONLY for that KPI
    res = supabase.table("kpi_values") \
        .select("value, institution_id, period_date") \
        .eq("kpi_id", kpi_id) \
        .execute()
        
    return res.data

@router.get("/export-pdf")
async def export_pdf(institution_id: str, user=Depends(get_current_user)):
    if not can_access_institution(user, institution_id):
        raise HTTPException(status_code=403, detail="Access denied to this institution's reports")

    # Log Activity
    supabase.table("system_activity").insert({"type": "report_generated", "institution_id": institution_id}).execute()

    res = supabase.table("kpi_values").select("*").eq("institution_id", institution_id).execute()
    pdf_buffer = report_service.generate_pdf_report(f"Institutional Report - {institution_id}", res.data)
    
    return StreamingResponse(
        pdf_buffer,
        media_type="application/pdf",
        headers={"Content-Disposition": f"attachment; filename=UCAR_Report_{institution_id}.pdf"}
    )

@router.get("/export-excel")
async def export_excel(institution_id: str, user=Depends(get_current_user)):
    if not can_access_institution(user, institution_id):
        raise HTTPException(status_code=403, detail="Access denied to this institution's reports")

    # Log Activity
    supabase.table("system_activity").insert({"type": "report_generated", "institution_id": institution_id}).execute()

    res = supabase.table("kpi_values").select("*").eq("institution_id", institution_id).execute()
    excel_buffer = report_service.generate_excel_report(res.data)
    
    return StreamingResponse(
        excel_buffer,
        media_type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        headers={"Content-Disposition": f"attachment; filename=UCAR_Report_{institution_id}.xlsx"}
    )