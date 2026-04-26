# UCAR AI Platform (U-OS) - Backend Architecture

The backend for the **UCAR AI Platform (U-OS)** (Strategic Operating System for University Governance) is a modern, AI-powered API built with **FastAPI** in Python. It provides unified intelligence capabilities for managing and analyzing data across 30+ institutions.

## Technology Stack
- **Web Framework**: FastAPI (Python)
- **Database / Backend-as-a-Service**: Supabase (PostgreSQL)
- **AI & NLP**: OpenAI (`gpt-4o`), LangChain, ChromaDB (Vector DB for RAG)
- **OCR & Document Processing**: pytesseract, pdf2image, pypdf
- **Data Science & ML**: NumPy, Statsmodels, Prophet (time-series forecasting & anomaly detection)
- **Task Queue**: Celery with Redis (for async processing)
- **Authentication**: JWT Bearer Tokens

## Core Architecture

The backend is modularized into standard FastAPI directories:

### 1. **API Routers (`app/api/v1/`)**
The application exposes standardized RESTful endpoints under the `/api/v1` prefix:
- **`auth.py`**: Handles user authentication and JWT token generation.
- **`kpis.py`**: Manages Key Performance Indicators (KPIs) definitions and values.
- **`ai.py`**: Exposes AI-driven features like strategic benchmarking, ESG optimization, and what-if simulations.
- **`dashboard.py`**: Provides aggregated data views for global (Super Admin) and institutional (Local Admin/Agent) levels. Supports PDF and Excel report exports.
- **`ingestion.py`**: Handles document and data ingestion for the RAG and OCR pipelines.
- **`institutions.py`**: Manages the CRUD operations for institutions.

### 2. **AI Modules (`app/ai/`)**
Handles the core mathematical and statistical AI processes:
- **`anomaly.py`**: Uses statistical methods (Z-score thresholds) combined with LLM-based explanations to detect anomalies in KPI values.
- **`prediction.py`**: Handles time-series forecasting to predict future KPI trends.
- **`recommendation.py`**: Generates AI recommendations based on historical data.

### 3. **Services (`app/services/`)**
Contains the business logic connecting the database, AI modules, and API layers:
- **`ai_service.py`**: The heavy lifter orchestrating KPI analysis, RAG-based chat prompts, strategic benchmarking, what-if simulations (calculating correlations between KPIs), and ESG optimization.
- **`parser_service.py`**: Uses LangChain and OpenAI to extract structured JSON data from unstructured text (e.g., extracting student data, HR info, ESG metrics).
- **`vector_service.py`**: Interacts with ChromaDB to store and retrieve contextual embeddings for the Retrieval-Augmented Generation (RAG) pipeline.
- **`ocr_service.py`**: Wraps Tesseract to parse text from uploaded images and PDFs.
- **`alert_service.py`**: Generates severity-based system alerts (e.g., when an anomaly is detected).
- **`report_service.py`**: Responsible for dynamically generating PDF and Excel reports.

### 4. **Database (`app/db/`)**
- Connects directly to **Supabase** via the official Python client.
- Key tables utilized include `kpi_values`, `kpi_definitions`, `ai_insights`, and `alerts`.

## Key Features

> [!TIP]
> **Retrieval-Augmented Generation (RAG)**
> The platform uses a vector database (ChromaDB) to ground LLM responses in real institutional data. For instance, the ESG optimization tool combines structured database metrics with unstructured PDF policy documents to provide actionable sustainability roadmaps.

> [!IMPORTANT]
> **Automated Insights Pipeline**
> When a KPI is analyzed, the backend automatically performs three operations:
> 1. Detects statistical anomalies and generates human-readable explanations via GPT-4o.
> 2. Forecasts the next 3 steps using predictive modeling.
> 3. Generates actionable strategic recommendations.

> [!NOTE]
> **Role-Based Access Control (RBAC)**
> The system enforces strict data segregation. A `super_admin` can view global dashboards and compare institutions, while institutional users are locked to their assigned `institution_id`.

## Integration Flow Example: "What-If" Simulation
1. The user provides a base KPI, a target KPI, and a percentage change.
2. `ai_service.py` fetches overlapping historical timeline data for both KPIs.
3. It computes the Pearson correlation coefficient between the two datasets using NumPy.
4. It calculates the simulated target value impact and returns whether the relationship is positive or negative.
