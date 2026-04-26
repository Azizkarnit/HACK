from pydantic import BaseModel
from datetime import datetime
from typing import Optional

class KpiDefinitionBase(BaseModel):
    name: str
    description: Optional[str] = None
    category: str
    target_value: Optional[float] = None

class KpiDefinitionCreate(KpiDefinitionBase):
    pass

class KpiDefinitionResponse(KpiDefinitionBase):
    id: str
    created_at: datetime

class KpiValueBase(BaseModel):
    kpi_definition_id: str
    value: float
    institution_id: str
    period: str

class KpiValueCreate(KpiValueBase):
    pass

class KpiValueResponse(KpiValueBase):
    id: str
    created_at: datetime