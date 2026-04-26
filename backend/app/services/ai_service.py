from db.supabase import supabase
from ai.anomaly import detect_anomalies_explained
from ai.prediction import predict_next_enhanced
from ai.recommendation import generate_recommendation_enhanced
from services.parser_service import parser_service
from services.vector_service import vector_service
from services.alert_service import alert_service
import logging
import numpy as np

logger = logging.getLogger(__name__)

async def analyze_kpi(institution_id, kpi_id):
    # 1. Fetch data
    res = supabase.table("kpi_values") \
        .select("*") \
        .eq("institution_id", institution_id) \
        .eq("kpi_id", kpi_id) \
        .order("period_date") \
        .execute()

    rows = res.data

    if not rows or len(rows) < 5:
        return {"message": "Not enough data for advanced AI analysis"}

    values = [r["value"] for r in rows]
    labels = [r.get("period_date", f"Point {i}") for i, r in enumerate(rows)]

    # 2. Run AI (Async)
    anomalies = await detect_anomalies_explained(values, labels=labels)
    predictions = predict_next_enhanced(values, steps=3)
    recommendation = await generate_recommendation_enhanced(values)

    insights = []

    # anomalies
    for a in anomalies:
        insights.append({
            "type": "anomaly",
            "title": "Anomaly detected",
            "description": a["reason"],
            "value": a["value"],
            "confidence": min(abs(a["score"]) / 5, 1.0)
        })
        
        await alert_service.create_alert(
            institution_id=institution_id,
            kpi_id=kpi_id,
            title="Proactive Anomaly Alert",
            message=a["reason"],
            severity="high" if abs(a["score"]) > 4 else "medium"
        )

    # predictions
    if predictions:
        for i, p in enumerate(predictions):
            insights.append({
                "type": "prediction",
                "title": f"Forecast (Step {i+1})",
                "description": f"Predicted value: {round(p, 2)}",
                "value": p,
                "confidence": 0.8 - (i * 0.1)
            })

    # recommendation
    insights.append({
        "type": "recommendation",
        "title": "AI Recommendation",
        "description": recommendation,
        "value": None,
        "confidence": 0.9
    })

    # 3. Save to DB
    for ins in insights:
        try:
            supabase.table("ai_insights").insert({
                "institution_id": institution_id,
                "kpi_id": kpi_id,
                **ins
            }).execute()
        except Exception as e:
            logger.error(f"Error saving insight: {str(e)}")

    return insights

async def get_database_snapshot():
    """Fetches a high-level summary of the entire database for the AI context."""
    try:
        # Fetch institutions
        inst_res = supabase.table("institutions").select("id, name, code").execute()
        insts = inst_res.data or []
        
        # Fetch latest KPI values (grouped by institution)
        # We'll take the most recent 50 entries to keep the prompt small but relevant
        kpi_res = supabase.table("kpi_values") \
            .select("value, period_date, kpi_definitions(name, category), institutions(name)") \
            .order("period_date", desc=True) \
            .limit(50) \
            .execute()
        
        kpis = kpi_res.data or []
        
        summary = "CURRENT DATABASE SNAPSHOT:\n"
        summary += f"- Total Institutions: {len(insts)}\n"
        summary += "- Latest KPI Readings:\n"
        for k in kpis:
            inst_name = k.get("institutions", {}).get("name", "Unknown")
            kpi_name = k.get("kpi_definitions", {}).get("name", "Unknown")
            summary += f"  * {inst_name}: {kpi_name} = {k['value']} (as of {k['period_date']})\n"
            
        return summary
    except Exception as e:
        logger.error(f"Error generating DB snapshot: {str(e)}")
        return "Database snapshot currently unavailable."

async def run_prompt(prompt: str):
    if not parser_service.llm:
         return _run_keyword_prompt(prompt)

    # 1. Get Database Snapshot
    db_context = await get_database_snapshot()

    # 2. Try Vector Search (for documents/policies)
    context_text = "No specific documents found."
    context_docs = []
    try:
        context_docs = await vector_service.search_similar(prompt, k=2)
        if context_docs:
            context_text = "\n\n".join([d.page_content for d in context_docs])
    except Exception as e:
        logger.warning(f"Vector Search Error (Falling back): {str(e)}")

    # 3. Combine contexts and run LLM
    system_prompt = f"""
    You are the UniGov AI Assistant. You help users understand institutional data and policies.
    
    {db_context}
    
    DOCUMENT CONTEXT (RAG):
    {context_text}
    
    INSTRUCTIONS:
    - Use the CURRENT DATABASE SNAPSHOT above to answer specific questions about institution metrics.
    - If a user asks for data you don't see in the snapshot, tell them you can only see the latest performance indicators.
    - Be professional and strategic.
    """
    
    try:
        response = await parser_service.llm.ainvoke([
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": prompt}
        ])
        return {"result": response.content, "sources": [d.metadata for d in context_docs]}
    except Exception as e:
        logger.error(f"LLM Error (Falling back to keyword engine): {str(e)}")
        return _run_keyword_prompt(prompt)

async def generate_network_strategic_insight():
    """Analyzes the entire network data and generates a high-level strategic summary."""
    if not parser_service.llm:
        return "LLM not configured. Please add GITHUB_TOKEN or OPENAI_API_KEY."
        
    db_context = await get_database_snapshot()
    
    prompt = f"""
    UniGov Network Strategic Intelligence Report
    {db_context}
    
    TASK: Analyze the latest data points across all institutions.
    1. Identify the 'Star Performer' (best average metrics).
    2. Identify the 'At-Risk' area (lowest metrics or critical alerts).
    3. Provide a 2-sentence 'Executive Strategy' to improve overall network performance.
    
    Keep the total response under 80 words. Be sharp and professional.
    """
    
    try:
        resp = await parser_service.llm.ainvoke(prompt)
        return resp.content
    except Exception as e:
        logger.error(f"Strategic Insight Error: {str(e)}")
        return "Failed to generate strategic network summary. Please check API quota."

async def run_strategic_benchmark(kpi_code: str):
    # 1. Resolve KPI code to ID
    kpi_def = supabase.table("kpi_definitions").select("id, name").eq("code", kpi_code).execute().data
    if not kpi_def:
        return {"message": f"KPI code {kpi_code} not found"}
    
    kpi_id = kpi_def[0]["id"]
    kpi_name = kpi_def[0]["name"]

    # 2. Fetch data ONLY for this KPI across all institutions
    res = supabase.table("kpi_values").select("value, institution_id").eq("kpi_id", kpi_id).execute()
    if not res.data:
        return {"message": f"No data available for {kpi_name} benchmarking"}

    data = res.data
    benchmarks = {}
    for item in data:
        inst = item["institution_id"]
        if inst not in benchmarks: benchmarks[inst] = []
        benchmarks[inst].append(item["value"])

    avg_benchmarks = {inst: sum(vals)/len(vals) for inst, vals in benchmarks.items()}
    sorted_insts = sorted(avg_benchmarks.items(), key=lambda x: x[1], reverse=True)
    
    leader = sorted_insts[0]
    laggard = sorted_insts[-1]

    prompt = f"""
    UniGov Strategic Benchmarking: {kpi_name}
    Leader: Institution {leader[0]} ({leader[1]:.2f})
    Laggard: Institution {laggard[0]} ({laggard[1]:.2f})
    
    Provide 3 high-level strategic tips for the laggard to improve.
    """
    
    advice = "AI advice not available."
    if parser_service.llm:
        resp = await parser_service.llm.ainvoke(prompt)
        advice = resp.content

    return {
        "kpi": kpi_name,
        "comparison": sorted_insts,
        "strategic_advice": advice
    }

async def run_what_if_simulation(institution_id: str, base_kpi_code: str, target_kpi_code: str, change_percent: float):
    # 1. Resolve KPI codes to IDs
    kpi_defs = supabase.table("kpi_definitions").select("id, code").in_("code", [base_kpi_code, target_kpi_code]).execute().data
    id_map = {d["code"]: d["id"] for d in kpi_defs}
    
    if base_kpi_code not in id_map or target_kpi_code not in id_map:
        return {"error": "One or both KPI codes not found"}

    base_kpi_id = id_map[base_kpi_code]
    target_kpi_id = id_map[target_kpi_code]

    # 2. Fetch historical data
    res_base = supabase.table("kpi_values").select("value, period_date").eq("institution_id", institution_id).eq("kpi_id", base_kpi_id).execute()
    res_target = supabase.table("kpi_values").select("value, period_date").eq("institution_id", institution_id).eq("kpi_id", target_kpi_id).execute()
    
    if not res_base.data or not res_target.data:
        return {"error": "Insufficient data for correlation analysis"}

    base_dict = {r["period_date"]: r["value"] for r in res_base.data}
    target_dict = {r["period_date"]: r["value"] for r in res_target.data}
    
    common_dates = sorted(list(set(base_dict.keys()) & set(target_dict.keys())))
    if len(common_dates) < 3:
        return {"error": "Not enough overlapping data points"}

    x = np.array([base_dict[d] for d in common_dates])
    y = np.array([target_dict[d] for d in common_dates])

    # Safety check: if x or y have no variance, correlation is 0
    if np.std(x) == 0 or np.std(y) == 0:
        correlation = 0.0
    else:
        correlation = np.corrcoef(x, y)[0, 1]
    
    if np.isnan(correlation): correlation = 0.0

    current_target_avg = np.mean(y)
    predicted_change = (change_percent / 100.0) * correlation
    simulated_value = current_target_avg * (1 + predicted_change)

    return {
        "institution_id": institution_id,
        "correlation_coefficient": round(correlation, 4),
        "impact_direction": "positive" if correlation > 0 else "negative",
        "simulated_target_value": round(simulated_value, 2),
        "predicted_impact_percent": round(predicted_change * 100, 2)
    }

async def run_esg_optimization(institution_id: str):
    # 1. Fetch ESG KPI Definitions
    esg_defs = supabase.table("kpi_definitions").select("*").eq("category", "ESG").execute()
    if not esg_defs.data:
        return {"message": "No ESG KPI definitions found in the system."}
    
    esg_ids = [d["id"] for d in esg_defs.data]
    esg_id_to_name = {d["id"]: d["name"] for d in esg_defs.data}

    # 2. Fetch Latest Values for these KPIs
    res_values = supabase.table("kpi_values") \
        .select("*") \
        .eq("institution_id", institution_id) \
        .in_("kpi_id", esg_ids) \
        .order("period_date", desc=True) \
        .limit(10) \
        .execute()
    
    latest_data = res_values.data
    data_summary = "\n".join([f"- {esg_id_to_name[r['kpi_id']]}: {r['value']} (Date: {r['period_date']})" for r in latest_data])

    # 3. Fetch Unstructured Context from Vector DB (RAG)
    context_docs = await vector_service.search_similar(f"infrastructure energy building sustainability for institution {institution_id}", k=3)
    context_text = "\n\n".join([d.page_content for d in context_docs]) if context_docs else "No specific infrastructure documents found."

    # 4. Generate Strategic Roadmap
    prompt = f"""
    UniGov ESG Carbon Optimizer Report
    Institution: {institution_id}
    
    Current ESG Metrics (Supabase):
    {data_summary}
    
    Building & Policy Context (ChromaDB):
    {context_text}
    
    Task: 
    1. Identify the biggest carbon/energy leak based on the data.
    2. Provide a 3-step actionable 'Sustainability Roadmap' to optimize energy and reduce footprint.
    3. Estimate potential impact in professional terms.
    """
    
    roadmap = "AI analysis not available without API key."
    if parser_service.llm:
        resp = await parser_service.llm.ainvoke(prompt)
        roadmap = resp.content

    return {
        "institution_id": institution_id,
        "metrics_analyzed": len(latest_data),
        "sustainability_roadmap": roadmap,
        "context_found": len(context_docs) > 0
    }

def _run_keyword_prompt(prompt: str):
    prompt = prompt.lower()
    
    # Simple Agentic Logic: Try to identify the institution and KPI
    inst_res = supabase.table("institutions").select("id, name").execute()
    institutions = inst_res.data or []
    
    found_inst = None
    for inst in institutions:
        if inst["name"].lower() in prompt:
            found_inst = inst
            break
            
    if found_inst:
        # If institution is mentioned, try to find a relevant KPI
        kpis = supabase.table("kpi_values").select("*, kpi_definitions(name)").eq("institution_id", found_inst["id"]).execute().data
        if kpis:
            if "dropout" in prompt:
                val = next((k["value"] for k in kpis if "dropout" in k["kpi_definitions"]["name"].lower()), None)
                if val: return {"result": f"The current dropout rate for {found_inst['name']} is {val}%. This was retrieved directly from the institutional database."}
            if "success" in prompt:
                val = next((k["value"] for k in kpis if "success" in k["kpi_definitions"]["name"].lower()), None)
                if val: return {"result": f"The latest success rate for {found_inst['name']} is {val}%. All systems are reporting normal for this metric."}
            if "student" in prompt:
                val = next((k["value"] for k in kpis if "total students" in k["kpi_definitions"]["name"].lower()), None)
                if val: return {"result": f"The total student enrollment at {found_inst['name']} is currently {int(val)} students."}
                
        return {"result": f"I found data for {found_inst['name']}, but I'm not sure which specific metric you are asking about. Try asking for 'dropout rate' or 'success rate'."}

    if "institutions" in prompt or "list" in prompt:
        names = [i["name"] for i in institutions[:5]]
        return {"result": f"The UniGov network currently manages {len(institutions)} institutions, including: {', '.join(names)} and others."}

    return {
        "result": "I am the UniGov AI Assistant. I can see your institutional data! To unlock my full conversational power (GPT-4o), please configure the OPENAI_API_KEY. However, I can still answer basic questions about institution names and their key metrics if you name them!"
    }