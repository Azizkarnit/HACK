import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { forkJoin } from 'rxjs';
import { AuthService } from '../../core/services/auth.service';
import { DashboardService } from '../../core/services/dashboard.service';

@Component({
  selector: 'app-alerts',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './alerts.component.html',
  styleUrls: ['./alerts.component.scss']
})
export class AlertsComponent implements OnInit {
  role: string | null = null;
  activeTab = 'all';
  toastMsg = '';
  isLoading = true;

  activeAlerts: any[] = [];
  resolvedAlerts: any[] = [];
  snoozedIds: Set<string> = new Set();
  currentUser: any = null;

  constructor(
    private auth: AuthService,
    private dashboardService: DashboardService
  ) {}

  ngOnInit(): void {
    this.role = this.auth.getRole();
    this.currentUser = this.auth.getCurrentUser();
    
    // Snoozed state can stay in localStorage as it is temporary
    const savedSnoozed = localStorage.getItem('snoozedAlerts');
    if (savedSnoozed) this.snoozedIds = new Set(JSON.parse(savedSnoozed));

    this.loadAlerts();
  }

  loadAlerts(): void {
    this.isLoading = true;
    const instId = this.auth.getInstitutionId() || undefined;

    const dashboard$ = this.role === 'super_admin' 
      ? this.dashboardService.getGlobalDashboard()
      : this.dashboardService.getInstitutionDashboard(instId);
    
    const resolved$ = this.dashboardService.getResolvedAlerts(this.role === 'admin' ? instId : undefined);

    forkJoin([dashboard$, resolved$]).subscribe({
      next: ([dashData, resolvedData]) => {
        this.activeAlerts = dashData.alerts.map((a: any) => this.mapAlert(a));
        this.resolvedAlerts = resolvedData.map((a: any) => this.mapAlert(a));
        this.isLoading = false;
      },
      error: (err) => {
        console.error('Failed to load alerts', err);
        this.isLoading = false;
      }
    });
  }

  private mapAlert(a: any) {
    return {
      id: a.id,
      severity: a.severity,
      kpi: a.message.split('(')[0].trim(),
      institution: a.institutions?.name || 'Your Institution',
      institution_id: a.institution_id,
      domain: 'General',
      current: a.actual_value?.toString() || '--',
      threshold: a.threshold?.toString() || '--',
      days: this.calculateDays(a.created_at),
      msg: a.message,
      created_at: a.created_at
    };
  }

  calculateDays(dateStr: string): number {
    const created = new Date(dateStr);
    const now = new Date();
    const diff = now.getTime() - created.getTime();
    return Math.floor(diff / (1000 * 60 * 60 * 24));
  }

  get filteredAlerts() {
    if (this.activeTab === 'resolved') {
      return this.resolvedAlerts;
    }
    
    let list = this.activeAlerts.filter(a => !this.snoozedIds.has(a.id));
    if (this.activeTab === 'critical') list = list.filter(a => a.severity === 'critical');
    if (this.activeTab === 'warning')  list = list.filter(a => a.severity === 'warning');
    return list;
  }

  get unresolvedCount(): number { 
    return this.activeAlerts.filter(a => !this.snoozedIds.has(a.id)).length; 
  }
  
  get activeCriticalCount(): number { return this.activeAlerts.filter(a => a.severity === 'critical' && !this.snoozedIds.has(a.id)).length; }
  get activeWarningCount():  number { return this.activeAlerts.filter(a => a.severity === 'warning' && !this.snoozedIds.has(a.id)).length; }

  setTab(tab: string): void { this.activeTab = tab; }

  resolve(id: string): void {
    this.dashboardService.resolveAlert(id).subscribe({
      next: () => {
        const alert = this.activeAlerts.find(a => a.id === id);
        if (alert) {
          this.activeAlerts = this.activeAlerts.filter(a => a.id !== id);
          this.resolvedAlerts.unshift(alert);
        }
        this.showToast('Alert resolved successfully');
      },
      error: (err) => {
        console.error('Failed to resolve alert', err);
      }
    });
  }

  snooze(id: string): void { 
    this.snoozedIds.add(id);
    localStorage.setItem('snoozedAlerts', JSON.stringify(Array.from(this.snoozedIds)));
    this.showToast('Alert snoozed for 24 hours'); 
  }

  viewDetails(alert: any): void {
    // Attempt to navigate to the institution or global dashboard depending on the alert
    const instId = alert.institution_id;
    if (instId) {
      window.location.href = `/institution?id=${instId}`;
    } else {
      // If no institution ID, route admins to their own dashboard, and global users to the global dashboard
      if (this.role === 'admin') {
        window.location.href = `/institution`;
      } else {
        window.location.href = `/dashboard`;
      }
    }
  }

  markAllResolved(): void {
    if (confirm('Mark all alerts as resolved?')) {
      // In a real app, we'd have a bulk resolve endpoint. 
      // For this demo, we'll just resolve them one by one or clear the list.
      const ids = this.activeAlerts.map(a => a.id);
      ids.forEach(id => {
        this.dashboardService.resolveAlert(id).subscribe({
          next: () => {
            const alert = this.activeAlerts.find(a => a.id === id);
            if (alert) {
              this.activeAlerts = this.activeAlerts.filter(a => a.id !== id);
              this.resolvedAlerts.unshift(alert);
            }
          }
        });
      });
      this.showToast('All alerts marked as resolved');
    }
  }

  showToast(msg: string): void {
    this.toastMsg = msg;
    setTimeout(() => this.toastMsg = '', 3000);
  }

  badgeClass(sev: string): string {
    return sev === 'critical' ? 'badge-critical' : 'badge-warning';
  }

  borderClass(sev: string): string {
    return sev === 'critical' ? 'border-critical' : 'border-warning';
  }
}
