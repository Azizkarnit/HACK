import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { AuthService } from '../services/auth.service';
import { UserRole } from '../models/user.model';

export function roleGuard(...allowedRoles: UserRole[]): CanActivateFn {
  return () => {
    const auth = inject(AuthService);
    const router = inject(Router);
    if (!auth.isLoggedIn()) { router.navigate(['/login']); return false; }
    if (auth.hasRole(...allowedRoles)) return true;
    // Redirect to appropriate home page
    const role = auth.getRole();
    if (role === 'admin') { router.navigate(['/institution']); return false; }
    if (role === 'super_admin' || role === 'agent') { router.navigate(['/dashboard']); return false; }
    
    // If we get here, they have a weird role or no role, send them to login to avoid infinite loops
    router.navigate(['/login']);
    return false;
  };
}
