from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.openapi.utils import get_openapi

# Routers
from api.v1.auth import router as auth_router
from api.v1.kpis import router as kpis_router
from api.v1.ai import router as ai_router
from api.v1.dashboard import router as dashboard_router
from api.v1.ingestion import router as ingestion_router
from api.v1.institutions import router as institutions_router
from api.v1.alerts import router as alerts_router
from api.v1.users import router as users_router


# =====================================================
# APP INIT
# =====================================================
app = FastAPI(
    title="UniGov AI Platform",
    description="Strategic Operating System for University Governance",
    version="1.0.0",
    redirect_slashes=False  # Prevent CORS issues on trailing slashes
)


# =====================================================
# CORS (Must be broad for local hackathon development)
# =====================================================
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:4200", "http://127.0.0.1:4200"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

from fastapi.responses import JSONResponse
from fastapi import Request

@app.exception_handler(Exception)
async def global_exception_handler(request: Request, exc: Exception):
    return JSONResponse(
        status_code=500,
        content={"detail": "Internal Server Error", "message": str(exc)},
        headers={
            "Access-Control-Allow-Origin": "http://localhost:4200",
            "Access-Control-Allow-Credentials": "true"
        }
    )


# =====================================================
# ROUTERS (Cleaned & Standardized)
# =====================================================
app.include_router(auth_router, prefix="/api/v1")
app.include_router(kpis_router, prefix="/api/v1")
app.include_router(ai_router, prefix="/api/v1")
app.include_router(dashboard_router, prefix="/api/v1")
app.include_router(ingestion_router, prefix="/api/v1/ingestion")
app.include_router(institutions_router, prefix="/api/v1/institutions")
app.include_router(alerts_router, prefix="/api/v1")
app.include_router(users_router, prefix="/api/v1")


# =====================================================
# HEALTH & VERSION
# =====================================================
@app.get("/api/v1/health")
def root():
    return {"status": "healthy", "platform": "UniGov"}

@app.get("/api/v1/version")
def version():
    return {"version": "1.0.0", "build": "stable"}


# =====================================================
# SWAGGER AUTH (BEARER)
# =====================================================
def custom_openapi():
    if app.openapi_schema:
        return app.openapi_schema

    openapi_schema = get_openapi(
        title="UniGov AI Platform",
        version="1.0.0",
        description="Unified Intelligence for 30+ Institutions",
        routes=app.routes,
    )

    openapi_schema["components"]["securitySchemes"] = {
        "BearerAuth": {
            "type": "http",
            "scheme": "bearer",
            "bearerFormat": "JWT"
        }
    }

    app.openapi_schema = openapi_schema
    return app.openapi_schema

app.openapi = custom_openapi