import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';
import { BehaviorSubject, Observable, tap } from 'rxjs';
import { User, UserRole, AuthResponse } from '../models/user.model';
import { environment } from '../../../environments/environment';

@Injectable({ providedIn: 'root' })
export class AuthService {
  private readonly TOKEN_KEY = 'uos_token';
  private readonly ROLE_KEY  = 'uos_role';
  private readonly USER_KEY  = 'uos_user';
  private readonly INST_KEY  = 'uos_institution';

  private currentUserSubject = new BehaviorSubject<User | null>(this.loadUser());
  currentUser$ = this.currentUserSubject.asObservable();

  constructor(private http: HttpClient, private router: Router) {}

  login(email: string, password: string): Observable<AuthResponse> {
    const payload = { email, password };
    return this.http.post<AuthResponse>(`${environment.apiUrl}/auth/login`, payload, {
      headers: { 'Content-Type': 'application/json' }
    }).pipe(
      tap(res => {
        localStorage.setItem(this.TOKEN_KEY, res.access_token);
        localStorage.setItem(this.ROLE_KEY,  res.user.role);
        localStorage.setItem(this.USER_KEY,  JSON.stringify(res.user));
        if (res.user.institution_name) {
          localStorage.setItem(this.INST_KEY, res.user.institution_name);
        }
        this.currentUserSubject.next(res.user);
      })
    );
  }

  logout(): void {
    localStorage.removeItem(this.TOKEN_KEY);
    localStorage.removeItem(this.ROLE_KEY);
    localStorage.removeItem(this.USER_KEY);
    this.currentUserSubject.next(null);
    this.router.navigate(['/login']);
  }

  getToken(): string | null {
    return localStorage.getItem(this.TOKEN_KEY);
  }

  getRole(): UserRole | null {
    return localStorage.getItem(this.ROLE_KEY) as UserRole | null;
  }

  getCurrentUser(): User | null {
    return this.currentUserSubject.value;
  }

  isLoggedIn(): boolean {
    return !!this.getToken();
  }

  hasRole(...roles: UserRole[]): boolean {
    const role = this.getRole();
    return role ? roles.includes(role) : false;
  }

  getInstitutionId(): string | null {
    return this.currentUserSubject.value?.institution_id || null;
  }

  getInstitutionName(): string {
    return localStorage.getItem(this.INST_KEY) || '';
  }

  private loadUser(): User | null {
    try {
      const raw = localStorage.getItem(this.USER_KEY);
      return raw ? JSON.parse(raw) : null;
    } catch { return null; }
  }

  // Demo login (fallback without backend)
  demoLogin(email: string): void {
    let role: UserRole = 'super_admin';
    let name = 'Karim Mansouri';
    let instName = '';

    if (email.includes('agent@')) {
      role = 'agent'; name = 'Sonia Bchir';
    } else if (email.includes('local@') || email.includes('admin@local')) {
      role = 'admin'; name = 'Ahmed Ben Ali';
      instName = 'ISG Tunis';
    }

    const demoUser: User = {
      id: 'demo-1', full_name: name, email, role,
      institution_name: instName || undefined,
      status: 'active'
    };

    localStorage.setItem(this.TOKEN_KEY, 'demo-token');
    localStorage.setItem(this.ROLE_KEY,  role);
    localStorage.setItem(this.USER_KEY,  JSON.stringify(demoUser));
    if (instName) localStorage.setItem(this.INST_KEY, instName);
    this.currentUserSubject.next(demoUser);
  }
}
