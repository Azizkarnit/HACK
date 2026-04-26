import asyncio
from supabase import create_client, Client
from app.core.config import settings
import random
from datetime import datetime, timedelta
import uuid

def seed_database():
    url = settings.supabase_url
    key = settings.supabase_key
    
    if not url or not key:
        print("[ERROR] Missing SUPABASE_URL or SUPABASE_KEY in .env")
        return

    supabase: Client = create_client(url, key)

    print("=== Supercharging U-OS Database with Massive Data ===")
    
    # 1. Seed more institutions (Total 12)
    print("\n1. Seeding 12 Institutions...")
    institutions_list = [
        {"code": "UCAR-HQ", "name": "UCAR Headquarters (Global)"},
        {"code": "ISG-TUNIS", "name": "ISG Tunis"},
        {"code": "ESCT", "name": "ESCT Business School"},
        {"code": "IPEIT", "name": "IPEI Tunis"},
        {"code": "IPEIEM", "name": "IPEI El Manar"},
        {"code": "ISSATS", "name": "ISSAT Sousse"},
        {"code": "ISSAT-MAN", "name": "ISSAT Manouba"},
        {"code": "ISTMT", "name": "ISTM Tunis"},
        {"code": "INSAT", "name": "INSAT"},
        {"code": "ENAU", "name": "ENAU Architecture"},
        {"code": "FST", "name": "Faculty of Sciences Tunis"},
        {"code": "ISET-CH", "name": "ISET Charguia"}
    ]
    
    for inst in institutions_list:
        res = supabase.table("institutions").select("id").eq("code", inst["code"]).execute()
        if not res.data:
            supabase.table("institutions").insert(inst).execute()

    inst_res = supabase.table("institutions").select("id, code, name").execute()
    institutions = inst_res.data
    
    # 2. Seed Rich KPI Definitions
    print("2. Seeding Comprehensive KPI Definitions...")
    kpi_defs = [
        # Academic
        {"name": "Total Students", "code": "ACAD_01", "category": "Academic"},
        {"name": "Success Rate", "code": "ACAD_02", "category": "Academic"},
        {"name": "Dropout Rate", "code": "ACAD_03", "category": "Academic"},
        {"name": "Attendance Rate", "code": "ACAD_04", "category": "Academic"},
        {"name": "Faculty-to-Student Ratio", "code": "ACAD_05", "category": "Academic"},
        
        # Finance
        {"name": "Budget Execution", "code": "FIN_01", "category": "Finance"},
        {"name": "Grant Funding", "code": "FIN_02", "category": "Finance"},
        {"name": "Operating Cost per Student", "code": "FIN_03", "category": "Finance"},
        
        # HR
        {"name": "Staff Satisfaction", "code": "HR_01", "category": "HR"},
        {"name": "Teacher Turnover", "code": "HR_02", "category": "HR"},
        {"name": "Admin Efficiency", "code": "HR_03", "category": "HR"},
        
        # ESG
        {"name": "Energy Consumption", "code": "ESG_01", "category": "ESG"},
        {"name": "Waste Recycled %", "code": "ESG_02", "category": "ESG"},
        {"name": "Carbon Footprint", "code": "ESG_03", "category": "ESG"},
        
        # Research
        {"name": "Research Papers Published", "code": "RES_01", "category": "Research"},
        {"name": "Patents Filed", "code": "RES_02", "category": "Research"},
        {"name": "H-Index Average", "code": "RES_03", "category": "Research"},
        
        # Infrastructure
        {"name": "Classroom Utilization", "code": "INF_01", "category": "Infrastructure"},
        {"name": "IT System Uptime", "code": "INF_02", "category": "Infrastructure"},
        {"name": "Library Footfall", "code": "INF_03", "category": "Infrastructure"}
    ]
    
    for kpi in kpi_defs:
        res = supabase.table("kpi_definitions").select("id").eq("code", kpi["code"]).execute()
        if not res.data:
            supabase.table("kpi_definitions").insert(kpi).execute()

    kpi_res = supabase.table("kpi_definitions").select("id, code, name").execute()
    kpi_map = {k["code"]: k["id"] for k in kpi_res.data}

    # 3. Seed 12 Months of Historical Data for ALL institutions
    print("3. Seeding 12 Months of Historical Data (Massive)...")
    months = []
    for i in range(12):
        d = datetime.now() - timedelta(days=30*i)
        months.append(d.strftime("%Y-%m-01"))

    kpi_values_to_insert = []
    for inst in institutions:
        print(f"   -> Generating data for {inst['name']}...")
        for month in months:
            for code, kpi_id in kpi_map.items():
                # Generate realistic random values based on KPI type
                val = 0
                if "ACAD" in code: val = random.uniform(70, 95) if "Rate" in code else random.randint(500, 5000)
                elif "FIN" in code: val = random.uniform(50, 100) if "Execution" in code else random.randint(10000, 100000)
                elif "ESG" in code: val = random.uniform(10, 90)
                elif "RES" in code: val = random.randint(0, 50)
                else: val = random.uniform(40, 100)

                kpi_values_to_insert.append({
                    "institution_id": inst["id"],
                    "kpi_id": kpi_id,
                    "value": round(val, 2),
                    "period_date": month,
                    "period": "monthly"
                })
        
        # Insert in batches to avoid Supabase timeout
        if len(kpi_values_to_insert) > 500:
            supabase.table("kpi_values").insert(kpi_values_to_insert).execute()
            kpi_values_to_insert = []
            
    if kpi_values_to_insert:
        supabase.table("kpi_values").insert(kpi_values_to_insert).execute()

    # 4. Seed Diverse Alerts
    print("4. Seeding Diverse Alerts & Anomalies...")
    alert_templates = [
        {"sev": "critical", "msg": "Unexpected Dropout Spike (Anomaly detected: +12%)"},
        {"sev": "warning",  "msg": "Budget variance exceeding threshold for Q3"},
        {"sev": "critical", "msg": "IT Infrastructure Uptime below SLA (94%)"},
        {"sev": "warning",  "msg": "Staff turnover rate rising in HR department"},
        {"sev": "success",  "msg": "Carbon neutral target achieved for this campus"}
    ]
    
    for inst in institutions:
        for _ in range(random.randint(2, 5)):
            tpl = random.choice(alert_templates)
            supabase.table("alerts").insert({
                "institution_id": inst["id"],
                "severity": tpl["sev"],
                "message": tpl["msg"],
                "actual_value": round(random.uniform(10, 100), 2),
                "threshold": round(random.uniform(10, 100), 2)
            }).execute()

    # 5. Seed AI Insights (Anomalies, Predictions, Recommendations)
    print("5. Seeding AI Strategic Insights (Anomalies & Predictions)...")
    
    for inst in institutions:
        # Seed Anomalies
        supabase.table("ai_insights").insert({
            "institution_id": inst["id"],
            "kpi_id": random.choice(list(kpi_map.values())),
            "description": f"Significant anomaly detected in KPI performance for {inst['name']}. Value is 2.4 standard deviations from historical mean.",
            "type": "anomaly",
            "confidence": 0.88,
            "status": "active",
            "title": "Anomaly Alert"
        }).execute()

        # Seed Predictions
        supabase.table("ai_insights").insert({
            "institution_id": inst["id"],
            "kpi_id": kpi_map.get("ACAD_02"), # Success Rate
            "description": "AI predicts a positive trend for the next 3 months based on current academic interventions.",
            "type": "prediction",
            "value": 92.5,
            "confidence": 0.76,
            "status": "active",
            "title": "Performance Forecast"
        }).execute()
        
        # Seed Recommendations
        supabase.table("ai_insights").insert({
            "institution_id": inst["id"],
            "description": "Recommend re-allocating budget from administrative overhead to student support services.",
            "type": "recommendation",
            "status": "active",
            "title": "Strategic Recommendation"
        }).execute()

    print("\n=== DATABASE SUPERCHARGED! ===")
    print(f"Summary: 12 Institutions, {len(kpi_defs)} KPIs, 12 Months of History.")

if __name__ == "__main__":
    seed_database()
