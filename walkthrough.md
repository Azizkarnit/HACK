# UCAR AI Platform (U-OS) - Technical Overview

This document outlines the core functionalities of the U-OS platform, detailing their implementation, data processing, and persistence layers.

---

## 1. Core Data Architecture
- **Storage**: PostgreSQL (hosted on Supabase) with Row-Level Security (RLS).
- **Core Entities**: Institutions, KPI Definitions, KPI Values, AI Insights, and Alerts.
- **Persistence**: Every data point is saved with a `period_date` to enable 12-month historical trending and forecasting.

---

## 2. Key Functionalities

### 📊 Multi-Tier Dashboards
- **Global Dashboard**: Aggregates data from all 12 institutions. Uses optimized queries with `LIMIT` and `ORDER BY` to maintain 100ms load times even with thousands of records.
- **Institutional Dashboard**: Provides a deep-dive into a single campus. Calculates "Health Scores" dynamically by averaging KPIs across Academic, Financial, HR, and ESG categories.
- **Data Treatment**: Chart.js renders real-time comparisons. The scale is dynamic (0 to infinity) to handle diverse metrics like "Enrollment" vs "Dropout Rate %".

### 🧠 AI Analytics Engine
- **Anomaly Detection**: 
    - **Logic**: Statistical Z-Score analysis (flagging values > 2.5 Std Dev from mean).
    - **Treatment**: GPT-4o generates a natural language narrative explaining the shift.
    - **Persistence**: Saved to `ai_insights` table with type `anomaly`.
- **Performance Predictions**:
    - **Logic**: Linear regression and time-series analysis based on the last 12 months of data.
    - **Output**: Generates a future "Trend Line" displayed in the UI.
- **What-If Simulation**:
    - **Logic**: Uses Pearson Correlation Coefficients to determine how moving one KPI (e.g., Budget) affects another (e.g., Success Rate).

### 🤖 AI Strategic Insight & Assistant
- **Network Overview**: The system feeds a "Network Snapshot" to the GitHub GPT-4o model. The model analyzes the entire UCAR network to provide executive-level strategic briefings.
- **AI Assistant**: A natural language interface that allows users to ask questions like *"Which institution has the highest dropout rate?"*. It translates English into SQL queries (SELECT only) to fetch real-time answers.

### 📥 Data Ingestion & Management
- **Parser Service**: A Python-based engine that reads uploaded CSV files.
- **Validation**: Ensures that institution codes and KPI categories match the system registry before saving.
- **Duplication Control**: Uses unique constraints (`institution_id`, `kpi_id`, `period_date`) to prevent overwriting historical records.

### 🔔 Real-Time Alerting System
- **Triggers**: Automated triggers create an "Alert" whenever a KPI crosses a pre-defined threshold.
- **Workflow**: Admins can "Resolve" alerts. This updates the `status` column in the database, removing the alert from active views while preserving it for historical audits.

### 📄 Strategic Reporting & Activity Audit
- **Exports**: Generates dynamic **PDFs** (using FPDF) and **Excel** (using Pandas/Openpyxl) reports.
- **Activity Tracker**: Every report generation is logged in the `system_activity` table. This allows the platform to show a live counter of "Reports Generated This Month" on the dashboard.

---

## 3. Security & Access Control
- **Authentication**: JWT (JSON Web Token) based auth via Supabase Auth.
- **Authorization**:
    - **Super Admin**: Full network visibility and institution management.
    - **Admin**: Restricted to their own institution's data.
    - **Agent**: Read-only access to specific dashboards.
- **Security Interceptor**: A global frontend interceptor monitors for 401/403 errors and automatically secures the session by logging out expired users.

---

## 4. Tech Stack Summary
- **Frontend**: Angular 17+ (Standalone Components, Chart.js).
- **Backend**: FastAPI (Python), Uvicorn.
- **AI**: GitHub Models (GPT-4o API).
- **Database**: Supabase (PostgreSQL).
- **Styles**: Modern Vanilla CSS with high-premium aesthetics.
