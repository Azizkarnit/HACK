from fastapi import HTTPException


# =========================
# KPI DEFINITIONS
# =========================

def list_kpi_definitions(supabase):
    res = supabase.table("kpi_definitions").select("*").execute()
    return res.data


def create_new_kpi_definition(supabase, data: dict):
    res = supabase.table("kpi_definitions").insert(data).execute()

    if not res.data:
        raise HTTPException(status_code=400, detail="Error creating KPI definition")

    return res.data[0]


# =========================
# KPI VALUES
# =========================

def list_kpi_values(supabase, institution_id=None):
    query = supabase.table("kpi_values").select("*")

    if institution_id:
        query = query.eq("institution_id", institution_id)

    res = query.execute()
    return res.data


def create_new_kpi_value(supabase, data: dict):
    res = supabase.table("kpi_values").insert(data).execute()

    if not res.data:
        raise HTTPException(status_code=400, detail="Error creating KPI value")

    return res.data[0]