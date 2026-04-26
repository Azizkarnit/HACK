import numpy as np
from services.parser_service import parser_service
import asyncio
import logging

logger = logging.getLogger(__name__)

async def detect_anomalies_explained(values, labels=None, threshold=2.5):
    if len(values) < 5:
        return []

    mean = np.mean(values)
    std = np.std(values)

    anomalies = []

    for i, v in enumerate(values):
        if std == 0:
            continue

        z = (v - mean) / std
        if abs(z) > threshold:
            label = labels[i] if labels else f"Data Point {i}"
            
            # Explain the anomaly using the ParserService logic (LLM)
            reason = await explain_anomaly(v, mean, std, label)
            
            anomalies.append({
                "index": i,
                "label": label,
                "value": v,
                "score": float(z),
                "reason": reason
            })

    return anomalies

async def explain_anomaly(value, mean, std, label):
    prompt = f"The value for {label} is {value}. The mean is {mean:.2f} and standard deviation is {std:.2f}. Explain why this is an anomaly and what the potential impact might be in a short, professional sentence."
    
    try:
        # Re-using the LLM from parser_service if available
        if parser_service.llm:
            resp = await parser_service.llm.ainvoke(prompt)
            return resp.content
        else:
            return f"Value {value} is {abs(value-mean)/std:.2f} standard deviations from the mean."
    except Exception as e:
        logger.error(f"Explanation Error: {str(e)}")
        return f"Statistical anomaly detected at {label}."