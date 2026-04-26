import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';

@Injectable({ providedIn: 'root' })
export class IngestionService {
  private api = environment.apiUrl;

  constructor(private http: HttpClient) {}

  uploadFile(file: File, institutionId: string, category: string): Observable<any> {
    const form = new FormData();
    form.append('file', file);
    form.append('institution_id', institutionId);
    form.append('category', category);
    return this.http.post(`${this.api}/ingestion/upload`, form);
  }

  getHistory(): Observable<any[]> {
    return this.http.get<any[]>(`${this.api}/ingestion/history`);
  }
}
