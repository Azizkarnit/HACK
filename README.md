# UniGov — Strategic University Governance OS

**UniGov** is an AI-powered Strategic Operating System designed for modern university governance. It enables university networks to monitor performance, detect anomalies, and generate strategic insights across multiple institutions in real-time.

---

## 🚀 Key Features

### 🧠 AI-Powered Intelligence
- **AI Assistant**: A RAG-powered chatbot that analyzes institutional data and policy documents to provide strategic answers.
- **Anomaly Detection**: Automatically identifies unusual shifts in KPIs (e.g., sudden dropout spikes or budget variances).
- **KPI Predictions**: Forecasts future trends for academic and financial metrics using historical data.
- **Strategic Recommendations**: AI-generated roadmaps to optimize energy consumption (ESG) and improve institutional performance.

### 📊 Comprehensive Dashboards
- **Global Overview**: High-level metrics for the entire university network.
- **Institution Specific**: Deep dives into individual campus performance.
- **KPI Manager**: Centralized hub to manage and monitor 30+ key performance indicators.

### 🛠️ Governance Tools
- **What-If Simulator**: Predict how changes in one KPI (e.g., student support budget) might impact another (e.g., success rate).
- **Report Generator**: Automated PDF/Excel reports with AI summaries.
- **Alerts Center**: Real-time critical alerts for decision-makers.
- **Data Ingestion**: Extract data from structured PDFs and spreadsheets directly into the system.

---

## 🛠️ Tech Stack

### Frontend
- **Framework**: Angular 17+ (Standalone Components)
- **Styling**: Vanilla CSS (Modern Design System)
- **Charts**: Chart.js
- **Icons**: FontAwesome 6

### Backend
- **Core**: FastAPI (Python 3.10+)
- **Database**: Supabase (PostgreSQL)
- **Vector DB**: ChromaDB (for AI context & RAG)
- **AI Framework**: LangChain / OpenAI / Google Gemini
- **Automation**: n8n

---

## 📦 Installation & Setup

### Prerequisites
- Node.js (v18+)
- Python (v3.10+)
- Supabase Account
- n8n (for automation workflows)

### 1. Backend Setup
1. Navigate to the `backend` directory:
   ```bash
   cd backend
   ```
2. Create and activate a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: .\venv\Scripts\activate
   ```
3. Install dependencies:
   ```bash
   pip install -r ../requirements.txt
   ```
4. Configure `.env` file in `backend/app/.env`:
   ```env
   SUPABASE_URL=your_url
   SUPABASE_KEY=your_key
   OPENAI_API_KEY=your_key
   ```
5. Seed the database:
   ```bash
   python seed_data.py
   python create_admin.py
   ```
6. Run the server:
   ```bash
   cd app
   uvicorn main:app --reload
   ```

### 2. Frontend Setup
1. Navigate to the `frontend` directory:
   ```bash
   cd frontend
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Run the development server:
   ```bash
   npm start
   ```
4. Access the app at `http://localhost:4200`.

---

## 🤖 AI Customization
To enable full AI features:
1. Ensure `OPENAI_API_KEY` is set in the backend `.env`.
2. Use the **Data Upload** tool to index policy documents into ChromaDB.
3. Configure **n8n** webhooks for automated notifications.

---

## 📄 License
Project developed for University Governance Optimization.
© 2025 UniGov Team.
