# Phase 2: The Core Data & Role-Based Access Control (RBAC)

With the login successfully passing the JWT token, we are now ready to tackle Phase 2. This phase is about **security (Who can see what)** and **live data (connecting the Dashboard to Supabase)**.

## Goal
Enforce strict Role-Based Access Control on all pages, create test accounts for each role, and wire up the Global and Institution Dashboards to pull real data from the backend.

## Proposed Changes

### 1. Route Security (RBAC Matrix)
#### [MODIFY] `c:\Users\AZIZ\Desktop\HACK\frontend\src\app\app.routes.ts`
I will strictly lock down the routes based on your architecture:
- **`super_admin`**: Full access (Global Dashboard, Institution Manager, User Management, Analytics).
- **`agent`**: Analyst access (Global Dashboard, Analytics, AI Assistant). Cannot see User Management.
- **`admin`**: Local Institution access (Institution Dashboard, local KPIs). Cannot see the Global Dashboard or other institutions.

### 2. Test Users Seeding
#### [NEW] `c:\Users\AZIZ\Desktop\HACK\backend\create_test_users.py`
To test the routing and dashboards properly, I will create a Python script to inject two new users into your database:
1. `admin@local.tn` (Role: `admin`, assigned to a new institution "ISG Tunis").
2. `agent@ucar.tn` (Role: `agent`, assigned to "UCAR HQ").

### 3. Dashboard API Integration
#### [MODIFY] `c:\Users\AZIZ\Desktop\HACK\frontend\src\app\core\services\dashboard.service.ts` (New)
- Create a dedicated Angular service to communicate with your FastAPI `/api/v1/dashboard/global` and `/api/v1/dashboard/institution` endpoints using the JWT token.
#### [MODIFY] `c:\Users\AZIZ\Desktop\HACK\frontend\src\app\pages\dashboard-global\dashboard-global.component.ts`
- Replace the hardcoded `institutions` and `alerts` arrays with live API calls.
#### [MODIFY] `c:\Users\AZIZ\Desktop\HACK\frontend\src\app\pages\dashboard-institution\dashboard-institution.component.ts`
- Replace hardcoded metrics with live data for the logged-in `admin`'s specific institution.

## User Review Required

> [!WARNING]
> Since we are connecting the dashboard to the real database, the charts and tables will initially be **EMPTY** because your database has no KPI values or alerts yet!
> 
> **Question:** Would you like me to also include a "Dummy Data Seeder" script in the backend to fill the database with realistic data (like what you see in the hardcoded UI) so the dashboard looks beautiful right away?

Please review this plan. If you approve (and let me know about the Dummy Data), I will execute Phase 2 immediately.
