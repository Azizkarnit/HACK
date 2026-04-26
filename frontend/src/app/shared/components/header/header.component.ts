import { Component, Input, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Router, NavigationEnd } from '@angular/router';
import { AuthService } from '../../../core/services/auth.service';
import { DashboardService } from '../../../core/services/dashboard.service';
import { filter } from 'rxjs/operators';

@Component({
  selector: 'app-header',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss']
})
export class HeaderComponent implements OnInit {
  @Input() pageTitle = 'Dashboard';

  role: string | null = null;
  currentUser: any = null;
  showAlerts = false;

  institutions: any[] = [];
  selectedInstitutionId: string = 'all';

  sampleAlerts: any[] = [];

  constructor(private auth: AuthService, private dashboard: DashboardService, private router: Router) {}

  onInstitutionChange(event: any) {
    const id = event.target.value;
    this.selectedInstitutionId = id;
    if (id === 'all') {
      this.router.navigate(['/dashboard']);
    } else {
      this.router.navigate(['/institution'], { queryParams: { id: id } });
    }
  }

  private initNavReset() {
    this.router.events.pipe(
      filter(e => e instanceof NavigationEnd)
    ).subscribe((e: any) => {
      const url = e.urlAfterRedirects;
      if (url === '/dashboard' || url === '/') {
        this.selectedInstitutionId = 'all';
      } else if (url.includes('/institution')) {
        // Parse ID from query params
        const queryParams = new URLSearchParams(url.split('?')[1]);
        const id = queryParams.get('id');
        if (id) this.selectedInstitutionId = id;
      }
    });
  }

  ngOnInit(): void {
    this.role = this.auth.getRole();
    this.currentUser = this.auth.getCurrentUser();
    this.initNavReset();
    
    if (this.role === 'super_admin') {
      this.dashboard.getInstitutions().subscribe(data => {
        this.institutions = data;
      });
      
      // Fetch real alerts for the bell
      this.dashboard.getGlobalDashboard().subscribe(data => {
        this.sampleAlerts = data.alerts.slice(0, 5).map(a => ({
          severity: a.severity,
          institution: (a as any).institutions?.name || 'System',
          message: a.message,
          time: new Date(a.created_at).toLocaleTimeString()
        }));
      });
    }
  }

  getInitials(): string {
    const name = this.currentUser?.full_name || 'U';
    return name.split(' ').map((w: string) => w[0]).join('').substring(0, 2).toUpperCase();
  }

  toggleAlerts(): void { this.showAlerts = !this.showAlerts; }
}
