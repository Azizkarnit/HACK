import pytest
import time
from unittest.mock import MagicMock, AsyncMock, patch

def test_dashboard_performance(client, mock_supabase):
    # Mock a large dataset
    mock_supabase.table().select().execute.return_value = MagicMock(data=[{"id": i} for i in range(1000)])
    
    start_time = time.time()
    response = client.get("/api/v1/dashboard/global")
    end_time = time.time()
    
    latency = end_time - start_time
    print(f"\nDashboard Latency: {latency:.4f}s")
    
    assert response.status_code == 200
    assert latency < 0.1 # Goal: under 100ms for metadata-only dashboard

@pytest.mark.asyncio
async def test_ingestion_performance(client, mock_supabase):
    # Mocking the AI services to isolate ingestion logic performance
    with patch("services.ai_service.detect_anomalies_explained", new_callable=AsyncMock) as mock_anomaly:
        mock_anomaly.return_value = []
        
        start_time = time.time()
        # Test with a multi-step CSV
        csv_content = "student_id,first_name,last_name\n" + "\n".join([f"STU{i},User{i},Name{i}" for i in range(100)])
        
        from io import BytesIO
        response = client.post(
            "/api/v1/ingestion/upload",
            data={"doc_type": "student", "institution_id": "UCAR001"},
            files={"file": ("large_test.csv", BytesIO(csv_content.encode()), "text/csv")}
        )
        end_time = time.time()
        
        latency = end_time - start_time
        print(f"\nIngestion Latency (100 rows): {latency:.4f}s")
        
        assert response.status_code == 200
        assert latency < 0.5 # Goal: under 500ms for processing 100 rows
