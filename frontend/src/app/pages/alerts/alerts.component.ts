import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
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

  alertsData: any[] = [];
  activeAlerts: any[] = []; // Template dependency
  resolvedData: any[] = []; // Template dependency
  resolvedIds: Set<string> = new Set();

  constructor(
    private auth: AuthService,
    private dashboardService: DashboardService
  ) {}

  ngOnInit(): void {
    this.role = this.auth.getRole();
    this.loadAlerts();
  }

  loadAlerts(): void {
    this.isLoading = true;
    const fetch$ = this.role === 'super_admin' 
      ? this.dashboardService.getGlobalDashboard()
      : this.dashboardService.getInstitutionDashboard(this.auth.getInstitutionId() || '');

    fetch$.subscribe({
      next: (data) => {
        this.alertsData = data.alerts.map((a: any) => ({
          id: a.id,
          severity: a.severity,
          kpi: a.message.split('(')[0].trim(),
          institution: a.institutions?.name || 'Your Institution',
          domain: 'General',
          current: a.actual_value?.toString() || '--',
          threshold: a.threshold?.toString() || '--',
          days: this.calculateDays(a.created_at),
          msg: a.message,
          created_at: a.created_at
        }));
        this.activeAlerts = this.alertsData;
        this.isLoading = false;
      },
      error: (err) => {
        console.error('Failed to load alerts', err);
        this.isLoading = false;
      }
    });
  }

  calculateDays(dateStr: string): number {
    const created = new Date(dateStr);
    const now = new Date();
    const diff = now.getTime() - created.getTime();
    return Math.floor(diff / (1000 * 60 * 60 * 24));
  }

  get filteredAlerts() {
    let list = this.alertsData.filter(a => !this.resolvedIds.has(a.id));
    if (this.activeTab === 'critical') list = list.filter(a => a.severity === 'critical');
    if (this.activeTab === 'warning')  list = list.filter(a => a.severity === 'warning');
    if (this.activeTab === 'resolved') return []; // This would pull from a different list if we had it
    return list;
  }

  get unresolvedCount(): number { return this.filteredAlerts.length; }
  get activeCriticalCount(): number { return this.alertsData.filter(a => a.severity === 'critical' && !this.resolvedIds.has(a.id)).length; }
  get activeWarningCount():  number { return this.alertsData.filter(a => a.severity === 'warning' && !this.resolvedIds.has(a.id)).length; }

  setTab(tab: string): void { this.activeTab = tab; }

  resolve(id: string): void {
    // In a real app, call backend to mark as resolved
    this.resolvedIds.add(id);
    this.showToast('Alert resolved successfully');
  }

  snooze(id: string): void { 
    this.showToast('Alert snoozed for 24 hours'); 
  }

  markAllResolved(): void {
    if (confirm('Mark all alerts as resolved?')) {
      this.alertsData.forEach(a => this.resolvedIds.add(a.id));
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
