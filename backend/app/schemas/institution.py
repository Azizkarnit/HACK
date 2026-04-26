from pydantic import BaseModel
from uuid import UUID


class InstitutionCreate(BaseModel):
    name: str
    code: str


class InstitutionUpdate(BaseModel):
    name: str | None = None
    code: str | None = None


class InstitutionResponse(BaseModel):
    id: UUID
    name: str
    code: str

    class Config:
        from_attributes = True
