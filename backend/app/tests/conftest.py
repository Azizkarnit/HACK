import pytest
from fastapi.testclient import TestClient
from unittest.mock import MagicMock, patch, AsyncMock
import sys

# Import app and routers
from main import app
from api.deps import get_current_user

@pytest.fixture
def client():
    # Override authentication for tests
    app.dependency_overrides[get_current_user] = lambda: {
        "id": "test-user-id",
        "role": "super_admin",
        "institution_id": "UCAR001"
    }
    with TestClient(app) as c:
        yield c
    app.dependency_overrides = {}

@pytest.fixture(autouse=True)
def mock_supabase():
    mock_client = MagicMock()
    
    # This is the key: patch it everywhere it might be imported
    with patch("db.supabase.supabase", mock_client):
        # We also need to patch it in services because they might have already imported it
        with patch("services.ai_service.supabase", mock_client, create=True):
            with patch("api.v1.dashboard.supabase", mock_client, create=True):
                with patch("api.v1.kpis.supabase", mock_client, create=True):
                    yield mock_client

@pytest.fixture
def mock_openai():
    with patch("services.parser_service.ChatOpenAI") as mock:
        mock_instance = MagicMock()
        mock.return_value = mock_instance
        mock_instance.ainvoke = AsyncMock()
        yield mock
