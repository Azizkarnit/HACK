from pydantic import BaseModel, EmailStr


class RegisterRequest(BaseModel):
    email: EmailStr
    password: str
    full_name: str
    institution_code: str


class LoginRequest(BaseModel):
    email: EmailStr
    password: str