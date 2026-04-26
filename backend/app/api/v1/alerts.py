from fastapi import APIRouter, Depends, HTTPException, Query
from api.deps import get_current_user
from db.supabase import supabase
from utils.permissions import can_access_institution, is_agent

router = APIRouter(prefix="/alerts", tags=["Alerts"])

@router.get("/resolved")
async def get_resolved_alerts(
    institution_id: str = Query(None),
    limit: int = 50,
    user=Depends(get_current_user)
):
    # Only super_admin or agent can query globally. Others only query their own inst.
    inst_id = institution_id
    if user["role"] not in ["super_admin", "agent"]:
        inst_id = user.get("institution_id")

    query = supabase.table("alerts").select("*, institutions(name)").eq("status", "resolved").order("created_at", desc=True).limit(limit)
    
    if inst_id:
        if not can_access_institution(user, inst_id):
            raise HTTPException(403, "Access denied")
        query = query.eq("institution_id", inst_id)

    res = query.execute()
    return res.data


@router.patch("/{alert_id}/resolve")
async def resolve_alert(alert_id: str, user=Depends(get_current_user)):
    # Verify the alert exists and the user has access
    alert_res = supabase.table("alerts").select("*").eq("id", alert_id).execute()
    if not alert_res.data:
        raise HTTPException(404, "Alert not found")
        
    alert = alert_res.data[0]
    
    # Check permissions
    if user["role"] not in ["super_admin", "agent"]:
        if alert.get("institution_id") != user.get("institution_id"):
            raise HTTPException(403, "Access denied")
            
    res = supabase.table("alerts").update({"status": "resolved"}).eq("id", alert_id).execute()
    if not res.data:
        raise HTTPException(500, "Failed to update alert status")
        
    return {"status": "success", "message": "Alert resolved"}
