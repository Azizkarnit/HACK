import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';
import { AuthService } from './auth.service';

export interface KpiValue {
  id: string;
  kpi_definition_id: string;
  value: number;
  institution_id: string;
  period: string;
  kpi_definitions?: {
    category: string;
  };
  institutions?: {
    name: string;
  };
  period_date?: string;
}

export interface Alert {
  id: string;
  institution_id: string;
  severity: string;
  message: string;
  status: string;
  created_at: string;
}

export interface GlobalDashboardData {
  kpis: KpiValue[];
  insights: any[];
  alerts: Alert[];
}

export interface InstitutionDashboardData {
  kpis: KpiValue[];
  insights: any[];
  alerts: Alert[];
}

@Injectable({
  providedIn: 'root'
})
export class DashboardService {
  constructor(private http: HttpClient, private authService: AuthService) {}

  private getHeaders(): HttpHeaders {
    const token = this.authService.getToken();
    return new HttpHeaders().set('Authorization', `Bearer ${token}`);
  }

  getGlobalDashboard(): Observable<GlobalDashboardData> {
    return this.http.get<GlobalDashboardData>(`${environment.apiUrl}/dashboard/global`, {
      headers: this.getHeaders()
    });
  }

  getInstitutionDashboard(institutionId?: string): Observable<InstitutionDashboardData> {
    const url = institutionId 
      ? `${environment.apiUrl}/dashboard/institution?institution_id=${institutionId}` 
      : `${environment.apiUrl}/dashboard/institution`;
      
    return this.http.get<InstitutionDashboardData>(url, {
      headers: this.getHeaders()
    });
  }

  getInstitutions(): Observable<any[]> {
    return this.http.get<any[]>(`${environment.apiUrl}/institutions`, {
      headers: this.getHeaders()
    });
  }

  getStrategicInsight(): Observable<{insight: string}> {
    return this.http.get<{insight: string}>(`${environment.apiUrl}/ai/strategic-insight`, {
      headers: this.getHeaders()
    });
  }
}
