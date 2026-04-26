import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { Alert } from '../models/alert.model';
import { environment } from '../../../environments/environment';

@Injectable({ providedIn: 'root' })
export class AlertService {
  private api = environment.apiUrl;

  constructor(private http: HttpClient) {}

  getAll(): Observable<Alert[]> {
    return this.http.get<Alert[]>(`${this.api}/alerts`).pipe(catchError(() => of([])));
  }

  resolve(alertId: string): Observable<any> {
    return this.http.patch(`${this.api}/alerts/${alertId}/resolve`, {}).pipe(catchError(() => of(null)));
  }
}
