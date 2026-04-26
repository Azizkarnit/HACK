import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from '../../../environments/environment';

@Injectable({ providedIn: 'root' })
export class KpiService {
  private api = environment.apiUrl;

  constructor(private http: HttpClient) {}

  getAll(): Observable<any[]> {
    return this.http.get<any[]>(`${this.api}/kpis`).pipe(catchError(() => of([])));
  }

  getValues(institutionId?: string): Observable<any[]> {
    let params = new HttpParams();
    if (institutionId) params = params.set('institution_id', institutionId);
    return this.http.get<any[]>(`${this.api}/kpis/values`, { params }).pipe(catchError(() => of([])));
  }

  analyze(institutionId: string, kpiId: string): Observable<any> {
    return this.http.get(`${this.api}/ai/analyze/${institutionId}/${kpiId}`).pipe(catchError(() => of(null)));
  }
}
