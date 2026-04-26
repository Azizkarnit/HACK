import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';
import { AuthService } from './auth.service';

export interface AiInsight {
  id: string;
  institution_id: string;
  kpi_id: string;
  type: 'anomaly' | 'prediction' | 'recommendation';
  title: string;
  description: string;
  value: number;
  confidence: number;
  created_at: string;
  institutions?: { name: string };
  kpi_definitions?: { name: string, category: string };
}

@Injectable({
  providedIn: 'root'
})
export class AnalyticsService {
  constructor(private http: HttpClient, private authService: AuthService) {}

  private getHeaders(): HttpHeaders {
    const token = this.authService.getToken();
    return new HttpHeaders().set('Authorization', `Bearer ${token}`);
  }

  getAnomalies(): Observable<AiInsight[]> {
    // We can filter by type='anomaly' if we add query params to the endpoint
    // For now, let's assume we fetch all and filter in frontend or use a specific endpoint
    return this.http.get<AiInsight[]>(`${environment.apiUrl}/dashboard/global`, {
      headers: this.getHeaders()
    }).pipe(
      // We'll extract only anomalies from the global dashboard data or dedicated endpoint
      // Mapping logic will be in the component for now to keep it simple
    ) as any;
  }

  getPredictions(institutionId?: string): Observable<AiInsight[]> {
    const url = institutionId 
      ? `${environment.apiUrl}/dashboard/institution?institution_id=${institutionId}` 
      : `${environment.apiUrl}/dashboard/global`;
    return this.http.get<any>(url, { headers: this.getHeaders() }) as any;
  }

  resolveInsight(insightId: string): Observable<any> {
    return this.http.patch(`${environment.apiUrl}/ai/insight/${insightId}/resolve`, {}, {
      headers: this.getHeaders()
    });
  }

  runSimulation(data: { institution_id: string, base_kpi: string, target_kpi: string, change_percent: number }): Observable<any> {
    const url = `${environment.apiUrl}/ai/simulate?institution_id=${data.institution_id}&base_kpi=${data.base_kpi}&target_kpi=${data.target_kpi}&change_percent=${data.change_percent}`;
    return this.http.get<any>(url, { headers: this.getHeaders() });
  }
}
