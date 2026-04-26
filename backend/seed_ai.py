from supabase import create_client, Client
from app.core.config import settings
import random
from datetime import datetime, timedelta

def seed_ai_analytics():
    url = settings.supabase_url
    key = settings.supabase_key
    supabase: Client = create_client(url, key)

    print("=== Injecting REALISTIC AI Analytics ===")
    
    inst_res = supabase.table("institutions").select("id, name").execute()
    institutions = inst_res.data
    
    kpi_res = supabase.table("kpi_definitions").select("id, code, name").execute()
    kpi_map = {k["code"]: k["id"] for k in kpi_res.data}
    kpi_names = {k["id"]: k["name"] for k in kpi_res.data}

    # Clear old insights to prevent clutter
    supabase.table("ai_insights").delete().neq("status", "permanent_archive").execute()

    reasons = [
        "Unusual spike compared to historical seasonal patterns.",
        "Significant drop detected following academic break period.",
        "Variance exceeds 3-sigma threshold for this specific institution.",
        "Inconsistent reporting detected between departmental data sources."
    ]

    for inst in institutions:
        print(f"   -> AI analysis for {inst['name']}...")
        
        # 1. Seed Anomaly with older dates
        kpi_id = random.choice(list(kpi_map.values()))
        kpi_name = kpi_names[kpi_id]
        days_ago = random.randint(1, 10)
        created_at = (datetime.now() - timedelta(days=days_ago)).isoformat()
        
        supabase.table("ai_insights").insert({
            "institution_id": inst["id"],
            "kpi_id": kpi_id,
            "description": f"The {kpi_name} for {inst['name']} showed a sudden shift. {random.choice(reasons)}",
            "type": "anomaly",
            "value": round(random.uniform(15, 95), 1),
            "confidence": round(random.uniform(0.7, 0.98), 2),
            "status": "active",
            "title": "Anomaly Detected",
            "created_at": created_at
        }).execute()

        # 2. Seed Prediction
        supabase.table("ai_insights").insert({
            "institution_id": inst["id"],
            "kpi_id": kpi_map.get("ACAD_02", list(kpi_map.values())[0]),
            "description": f"Based on 12-month trailing data, {inst['name']} is projected to see improvement in this KPI.",
            "type": "prediction",
            "value": round(random.uniform(85, 98), 1),
            "confidence": round(random.uniform(0.6, 0.85), 2),
            "status": "active",
            "title": "AI Performance Forecast"
        }).execute()

    print("=== REALISTIC AI ANALYTICS READY! ===")

if __name__ == "__main__":
    seed_ai_analytics()
