import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Router, NavigationEnd } from '@angular/router';
import { AuthService } from '../../../core/services/auth.service';
import { UserRole } from '../../../core/models/user.model';
import { filter } from 'rxjs/operators';

interface NavItem {
  icon: string;
  label: string;
  route: string;
  roles: UserRole[];
}

interface NavSection {
  label: string;
  items: NavItem[];
}

@Component({
  selector: 'app-sidebar',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.scss']
})
export class SidebarComponent implements OnInit {
  role: UserRole | null = null;
  currentUser: any = null;
  activeRoute = '';

  navSections: NavSection[] = [
    {
      label: 'OVERVIEW',
      items: [
        { icon: 'fa-gauge',    label: 'Dashboard',     route: '/dashboard',    roles: ['super_admin', 'agent'] },
        { icon: 'fa-gauge',    label: 'Dashboard',     route: '/institution',  roles: ['admin'] },
      ]
    },
    {
      label: 'ANALYTICS',
      items: [
        { icon: 'fa-chart-line',              label: 'Analytics',    route: '/analytics/anomalies', roles: ['super_admin', 'agent', 'admin'] },
        { icon: 'fa-triangle-exclamation',   label: 'Alerts',       route: '/alerts',              roles: ['super_admin', 'agent', 'admin'] },
        { icon: 'fa-robot',                  label: 'AI Assistant', route: '/ai-assistant',        roles: ['super_admin', 'agent', 'admin'] },
        { icon: 'fa-leaf',                   label: 'ESG Optimizer',route: '/analytics/esg-optimizer',roles: ['super_admin', 'agent', 'admin'] },
      ]
    },
    {
      label: 'MANAGEMENT',
      items: [
        { icon: 'fa-table-cells',         label: 'KPI Manager',    route: '/kpis',           roles: ['super_admin', 'agent', 'admin'] },
        { icon: 'fa-file-lines',          label: 'Reports',        route: '/reports',        roles: ['super_admin', 'agent', 'admin'] },
        { icon: 'fa-upload',              label: 'Data Upload',    route: '/data-ingestion', roles: ['super_admin', 'agent', 'admin'] },
        { icon: 'fa-building-columns',    label: 'Institutions',   route: '/institutions',   roles: ['super_admin', 'agent'] },
      ]
    },
    {
      label: 'ADMIN',
      items: [
        { icon: 'fa-users', label: 'User Management', route: '/user-management', roles: ['super_admin'] }
      ]
    }
  ];

  constructor(private auth: AuthService, private router: Router) {}

  ngOnInit(): void {
    this.role = this.auth.getRole();
    this.currentUser = this.auth.getCurrentUser();
    this.activeRoute = this.router.url;
    this.router.events.pipe(
      filter(e => e instanceof NavigationEnd)
    ).subscribe((e: any) => this.activeRoute = e.urlAfterRedirects);
  }

  visibleItems(items: NavItem[]): NavItem[] {
    return items.filter(i => this.role && i.roles.includes(this.role));
  }

  isActive(route: string): boolean {
    return this.activeRoute.startsWith(route);
  }

  getInitials(): string {
    const name = this.currentUser?.full_name || 'User';
    return name.split(' ').map((w: string) => w[0]).join('').substring(0, 2).toUpperCase();
  }

  getRoleBadge(): string {
    const map: Record<string, string> = {
      super_admin: 'Super Admin',
      agent: 'Agent',
      admin: 'Admin'
    };
    return map[this.role || ''] || this.role || '';
  }

  logout(): void { this.auth.logout(); }
}
