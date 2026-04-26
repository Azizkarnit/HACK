import pytest
from unittest.mock import MagicMock, patch, AsyncMock

def test_analyze_kpi_no_data(client, mock_supabase):
    # Mock empty data from Supabase
    mock_supabase.table().select().eq().eq().order().execute.return_value = MagicMock(data=[])
    
    response = client.post("/api/v1/ai/analyze?institution_id=UCAR001&kpi_id=KPI001")
    assert response.status_code == 200
    assert response.json()["message"] == "Not enough data for advanced AI analysis"

@pytest.mark.asyncio
async def test_run_prompt_mock(client, mock_openai):
    # The mock_openai fixture already sets up an AsyncMock for ainvoke
    # But we need to make sure the ai_service uses the SAME mock instance
    with patch("services.ai_service.parser_service.llm") as mock_llm:
        mock_llm.ainvoke = AsyncMock(return_value=MagicMock(content="Mocked AI Response"))
        
        response = client.post("/api/v1/ai/prompt?prompt=hello")
        assert response.status_code == 200
        assert "Mocked AI Response" in response.json()["result"]
