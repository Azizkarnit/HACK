from fastapi import APIRouter
from schemas.auth import RegisterRequest, LoginRequest
from services.auth_service import register_user, login_user

router = APIRouter(prefix="/auth", tags=["Auth"])


@router.post("/register")
def register(data: RegisterRequest):
    return register_user(data)


@router.post("/login")
def login(data: LoginRequest):
    return login_user(data)