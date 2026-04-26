import logging
from services.parser_service import parser_service

logger = logging.getLogger(__name__)

async def generate_recommendation_enhanced(values, kpi_name="this KPI"):
    if len(values) < 3:
        return "Not enough data points to generate a strategic recommendation."

    trend_direction = "upward" if values[-1] > values[0] else "downward"
    pct_change = ((values[-1] - values[0]) / abs(values[0])) * 100 if values[0] != 0 else 0
    
    prompt = f"""
    Strategic Recommendation for KPI: {kpi_name}
    Current Trend: {trend_direction} ({pct_change:.1f}% change over the period)
    Last Value: {values[-1]}
    
    Based on this trend, provide one high-impact, actionable recommendation for a university dean.
    Keep it under 25 words.
    """
    
    try:
        if parser_service.llm:
            resp = await parser_service.llm.ainvoke(prompt)
            return resp.content
        else:
             return f"Trend is {trend_direction}. Monitor closely for further deviations."
    except Exception as e:
        logger.error(f"Recommendation AI Error: {str(e)}")
        return f"Trend is {trend_direction}. Professional review suggested."