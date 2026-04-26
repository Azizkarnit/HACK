import numpy as np
from statsmodels.tsa.holtwinters import ExponentialSmoothing
import logging

logger = logging.getLogger(__name__)

def predict_next_enhanced(values, steps=3):
    if len(values) < 5:
        # Fallback to simple linear regression for very short sequences
        return _predict_linear(values, steps)

    try:
        model = ExponentialSmoothing(
            values, 
            trend='add', 
            seasonal=None, 
            initialization_method="estimated"
        ).fit()
        
        forecast = model.forecast(steps)
        return [float(v) for v in forecast]
    except Exception as e:
        logger.error(f"Prediction Error: {str(e)}")
        return _predict_linear(values, steps)

def _predict_linear(values, steps=3):
    if len(values) < 2:
        return []
        
    x = np.arange(len(values))
    y = np.array(values)

    coef = np.polyfit(x, y, 1)
    model = np.poly1d(coef)

    predictions = []
    for i in range(1, steps + 1):
        future_x = len(values) + i
        predictions.append(float(model(future_x)))
    
    return predictions