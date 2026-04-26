from db.supabase import supabase

def seed_kpis():
    kpis = [
        # Academic
        {"name": "Success Rate", "code": "acad_success", "category": "Academic", "unit": "%"},
        {"name": "Attendance Rate", "code": "acad_attendance", "category": "Academic", "unit": "%"},
        {"name": "Dropout Rate", "code": "acad_dropout", "category": "Academic", "unit": "%"},
        {"name": "Pedagogical Progression", "code": "acad_progression", "category": "Academic", "unit": "%"},
        
        # Employment
        {"name": "Employability Rate", "code": "emp_rate", "category": "Employment", "unit": "%"},
        {"name": "Time to Employment", "code": "emp_time", "category": "Employment", "unit": "months"},
        
        # Finance
        {"name": "Budget Execution Rate", "code": "fin_budget_exec", "category": "Finance", "unit": "%"},
        {"name": "Cost per Student", "code": "fin_cost_student", "category": "Finance", "unit": "TND"},
        {"name": "Allocated vs Consumed Budget", "code": "fin_budget_compare", "category": "Finance", "unit": "TND"},
        
        # ESG / CSR
        {"name": "Energy Consumption", "code": "esg_energy", "category": "ESG", "unit": "kWh"},
        {"name": "Carbon Footprint", "code": "esg_carbon", "category": "ESG", "unit": "tCO2e"},
        {"name": "Recycling Rate", "code": "esg_recycling", "category": "ESG", "unit": "%"},
        {"name": "Campus Accessibility", "code": "esg_accessibility", "category": "ESG", "unit": "score"},
        
        # HR
        {"name": "Absenteeism Rate", "code": "hr_absenteeism", "category": "HR", "unit": "%"},
        {"name": "Teaching Load", "code": "hr_teaching_load", "category": "HR", "unit": "hours"},
        {"name": "Team Stability", "code": "hr_stability", "category": "HR", "unit": "%"},
        
        # Research
        {"name": "Number of Publications", "code": "res_pubs", "category": "Research", "unit": "count"},
        {"name": "Funding Secured", "code": "res_funding", "category": "Research", "unit": "TND"},
        {"name": "Patents Filed", "code": "res_patents", "category": "Research", "unit": "count"},
        
        # Infrastructure
        {"name": "Classroom Occupancy Rate", "code": "inf_occupancy", "category": "Infrastructure", "unit": "%"},
        {"name": "IT Equipment Status", "code": "inf_it_status", "category": "Infrastructure", "unit": "score"},
        
        # Partnerships
        {"name": "Active Agreements", "code": "part_agreements", "category": "Partnerships", "unit": "count"},
        {"name": "International Mobility", "code": "part_mobility", "category": "Partnerships", "unit": "count"},
    ]

    for kpi in kpis:
        try:
            # Check if exists
            exists = supabase.table("kpi_definitions").select("*").eq("code", kpi["code"]).execute()
            if not exists.data:
                supabase.table("kpi_definitions").insert(kpi).execute()
                print(f"Seeded: {kpi['name']}")
            else:
                print(f"Skipped (exists): {kpi['name']}")
        except Exception as e:
            print(f"Error seeding {kpi['name']}: {str(e)}")

if __name__ == "__main__":
    seed_kpis()
