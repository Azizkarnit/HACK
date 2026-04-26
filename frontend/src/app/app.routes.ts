import { Routes } from '@angular/router';
import { authGuard } from './core/guards/auth.guard';
import { roleGuard } from './core/guards/role.guard';
import { ShellComponent } from './shared/components/shell/shell.component';
import { LoginComponent } from './pages/login/login.component';

export const routes: Routes = [
  { path: '', redirectTo: '/login', pathMatch: 'full' },
  { path: 'login', component: LoginComponent },

  {
    path: '',
    component: ShellComponent,
    canActivate: [authGuard],
    children: [
      {
        path: 'dashboard',
        canActivate: [roleGuard('super_admin', 'agent')],
        loadComponent: () => import('./pages/dashboard-global/dashboard-global.component').then(m => m.DashboardGlobalComponent)
      },
      {
        path: 'institution',
        canActivate: [roleGuard('admin', 'super_admin', 'agent')],
        loadComponent: () => import('./pages/dashboard-institution/dashboard-institution.component').then(m => m.DashboardInstitutionComponent)
      },
      {
        path: 'kpis',
        canActivate: [roleGuard('super_admin', 'agent', 'admin')],
        loadComponent: () => import('./pages/kpi-manager/kpi-manager.component').then(m => m.KpiManagerComponent)
      },
      {
        path: 'analytics/anomalies',
        canActivate: [roleGuard('super_admin', 'agent', 'admin')],
        loadComponent: () => import('./pages/analytics/anomalies/anomalies.component').then(m => m.AnomaliesComponent)
      },
      {
        path: 'analytics/predictions',
        canActivate: [roleGuard('super_admin', 'agent', 'admin')],
        loadComponent: () => import('./pages/analytics/predictions/predictions.component').then(m => m.PredictionsComponent)
      },
      {
        path: 'analytics/what-if',
        canActivate: [roleGuard('super_admin', 'agent')],
        loadComponent: () => import('./pages/analytics/what-if/what-if.component').then(m => m.WhatIfComponent)
      },
      {
        path: 'analytics/esg-optimizer',
        canActivate: [roleGuard('super_admin', 'agent', 'admin')],
        loadComponent: () => import('./pages/analytics/esg-optimizer/esg-optimizer.component').then(m => m.EsgOptimizerComponent)
      },
      {
        path: 'analytics',
        redirectTo: 'analytics/anomalies',
        pathMatch: 'full'
      },
      {
        path: 'ai-assistant',
        canActivate: [roleGuard('super_admin', 'agent', 'admin')],
        loadComponent: () => import('./pages/ai-assistant/ai-assistant.component').then(m => m.AiAssistantComponent)
      },
      {
        path: 'reports',
        canActivate: [roleGuard('super_admin', 'agent', 'admin')],
        loadComponent: () => import('./pages/reports/reports.component').then(m => m.ReportsComponent)
      },
      {
        path: 'data-ingestion',
        canActivate: [roleGuard('super_admin', 'agent')],
        loadComponent: () => import('./pages/data-ingestion/data-ingestion.component').then(m => m.DataIngestionComponent)
      },
      {
        path: 'alerts',
        canActivate: [roleGuard('super_admin', 'agent', 'admin')],
        loadComponent: () => import('./pages/alerts/alerts.component').then(m => m.AlertsComponent)
      },
      {
        path: 'user-management',
        canActivate: [roleGuard('super_admin')],
        loadComponent: () => import('./pages/user-management/user-management.component').then(m => m.UserManagementComponent)
      },
      {
        path: 'institutions',
        canActivate: [roleGuard('super_admin', 'agent')],
        loadComponent: () => import('./pages/institution-manager/institution-manager.component').then(m => m.InstitutionManagerComponent)
      },
    ]
  },

  { path: '**', redirectTo: '/login' }
];
