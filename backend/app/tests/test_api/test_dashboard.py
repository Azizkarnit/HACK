import pytest
from unittest.mock import MagicMock

def test_global_dashboard(client, mock_supabase):
    # Mock data
    mock_supabase.table().select().execute.return_value = MagicMock(data=[{"id": 1}])
    
    response = client.get("/api/v1/dashboard/global")
    assert response.status_code == 200
    assert "kpis" in response.json()
    assert len(response.json()["kpis"]) > 0

def test_compare_institutions(client, mock_supabase):
    mock_supabase.table().select().execute.return_value = MagicMock(data=[{"value": 10, "institution_id": "I1"}])
    
    response = client.get("/api/v1/dashboard/compare?kpi_name=GPA")
    assert response.status_code == 200
    assert len(response.json()) > 0
