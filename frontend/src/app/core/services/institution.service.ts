import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { Institution } from '../models/institution.model';
import { environment } from '../../../environments/environment';

@Injectable({ providedIn: 'root' })
export class InstitutionService {
  private api = environment.apiUrl;

  constructor(private http: HttpClient) {}

  getAll(): Observable<Institution[]> {
    return this.http.get<Institution[]>(`${this.api}/institutions`).pipe(catchError(() => of([])));
  }

  getById(id: string): Observable<Institution> {
    return this.http.get<Institution>(`${this.api}/institutions/${id}`).pipe(catchError(() => of({} as Institution)));
  }

  create(data: Partial<Institution>): Observable<Institution> {
    return this.http.post<Institution>(`${this.api}/institutions`, data);
  }

  update(id: string, data: Partial<Institution>): Observable<Institution> {
    return this.http.put<Institution>(`${this.api}/institutions/${id}`, data);
  }

  delete(id: string): Observable<any> {
    return this.http.delete(`${this.api}/institutions/${id}`);
  }
}
