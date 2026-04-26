import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';
import { AuthService } from './auth.service';

export interface AiResponse {
  result: string;
  sources?: any[];
  error?: string;
}

@Injectable({
  providedIn: 'root'
})
export class AiService {
  constructor(private http: HttpClient, private authService: AuthService) {}

  private getHeaders(): HttpHeaders {
    const token = this.authService.getToken();
    return new HttpHeaders().set('Authorization', `Bearer ${token}`);
  }

  ask(prompt: string): Observable<AiResponse> {
    // Pass prompt as query param as per current backend implementation
    return this.http.post<AiResponse>(`${environment.apiUrl}/ai/prompt?prompt=${encodeURIComponent(prompt)}`, {}, {
      headers: this.getHeaders()
    });
  }
}
