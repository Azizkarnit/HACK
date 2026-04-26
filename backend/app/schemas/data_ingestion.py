from pydantic import BaseModel
from typing import List, Optional
from datetime import date

class StudentData(BaseModel):
    student_id: str
    first_name: str
    last_name: str
    email: Optional[str] = None
    major: Optional[str] = None
    gpa: Optional[float] = None
    attendance_rate: Optional[float] = None
    dropout_risk: Optional[float] = None

class HRData(BaseModel):
    employee_id: str
    full_name: str
    department: str
    role: str
    salary: Optional[float] = None
    absenteeism_rate: Optional[float] = None

class FinanceData(BaseModel):
    transaction_id: str
    date: date
    category: str
    amount: float
    budget_execution_rate: Optional[float] = None

class ESGData(BaseModel):
    institution_id: str
    energy_consumption: float
    carbon_footprint: float
    recycling_rate: float
    accessibility_score: float

class ResearchData(BaseModel):
    institution_id: str
    publications_count: int
    active_projects: int
    funding_secured: float
    patents_filed: int

class InfrastructureData(BaseModel):
    institution_id: str
    classroom_occupancy: float
    it_equipment_status: str
    maintenance_required: bool

class IngestionResponse(BaseModel):
    status: str
    document_type: str
    extracted_data: dict
    message: str
