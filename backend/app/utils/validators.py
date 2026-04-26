from typing import Optional

VALID_ROLES = {"super_admin", "admin", "agent"}

def validate_role(role: str) -> str:
    if role not in VALID_ROLES:
        raise ValueError(f"Invalid role: {role}")
    return role

def validate_kpi_value(value: float) -> float:
    if value is None:
        raise ValueError("KPI value cannot be null")
    return value

def validate_email(email: Optional[str]) -> Optional[str]:
    if email and "@" not in email:
        raise ValueError("Invalid email format")
    return email