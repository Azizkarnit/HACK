import pytest
from io import BytesIO

def test_upload_unsupported_file(client):
    response = client.post(
        "/api/v1/ingestion/upload",
        data={"doc_type": "student", "institution_id": "UCAR001"},
        files={"file": ("test.txt", BytesIO(b"hello"), "text/plain")}
    )
    assert response.status_code == 400
    assert "Unsupported file format" in response.json()["detail"]

def test_upload_invalid_doc_type(client):
    response = client.post(
        "/api/v1/ingestion/upload",
        data={"doc_type": "invalid", "institution_id": "UCAR001"},
        files={"file": ("test.png", BytesIO(b"fake image data"), "image/png")}
    )
    assert response.status_code == 400
    assert "Invalid document type" in response.json()["detail"]

@pytest.mark.asyncio
async def test_upload_csv_success(client, mock_supabase):
    # Mock CSV data
    csv_content = "student_id,first_name,last_name\nSTU1,John,Doe"
    response = client.post(
        "/api/v1/ingestion/upload",
        data={"doc_type": "student", "institution_id": "UCAR001"},
        files={"file": ("test.csv", BytesIO(csv_content.encode()), "text/csv")}
    )
    assert response.status_code == 200
    assert response.json()["status"] == "success"
    assert response.json()["extracted_data"]["student_id"] == "STU1"
