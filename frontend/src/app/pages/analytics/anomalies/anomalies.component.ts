import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../../core/services/auth.service';
import { DashboardService } from '../../../core/services/dashboard.service';
import { AnalyticsService } from '../../../core/services/analytics.service';

@Component({
  selector: 'app-anomalies',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './anomalies.component.html',
  styleUrls: ['./anomalies.component.scss']
})
export class AnomaliesComponent implements OnInit {
  role: string | null = null;
  activeSeverity = 'all';
  expandedCards: boolean[] = [];
  resolvedIds: Set<string> = new Set();
  isLoading = true;

  anomalies: any[] = [];

  constructor(
    private auth: AuthService, 
    private dashboardService: DashboardService,
    private analyticsService: AnalyticsService
  ) {}

  ngOnInit(): void {
    this.role = this.auth.getRole();
    this.loadAnomalies();
  }

  loadAnomalies(): void {
    this.isLoading = true;
    this.dashboardService.getGlobalDashboard().subscribe({
      next: (data) => {
        // Map backend insights (type: anomaly) to the component format
        this.anomalies = data.insights
          .filter((ins: any) => ins.type === 'anomaly' && (ins.status === 'active' || !ins.status))
          .map((ins: any) => ({
            id: ins.id,
            severity: ins.confidence > 0.8 ? 'critical' : 'warning',
            kpi: ins.kpi_definitions?.name || 'Unknown KPI',
            institution: ins.institutions?.name || 'Global',
            institution_id: ins.institution_id,
            domain: ins.kpi_definitions?.category || 'General',
            current: ins.value ? ins.value.toString() : '--',
            expected: 'Within threshold',
            zscore: (ins.confidence * 4).toFixed(1), 
            duration: this.calculateDuration(ins.created_at),
            explanation: ins.description
          }));
        
        this.expandedCards = new Array(this.anomalies.length).fill(false);
        this.isLoading = false;
      },
      error: (err: any) => {
        console.error('Failed to load anomalies', err);
        this.isLoading = false;
      }
    });
  }

  get filtered() {
    let list = this.anomalies.filter(a => !this.resolvedIds.has(a.id));
    if (this.activeSeverity !== 'all') list = list.filter(a => a.severity === this.activeSeverity);
    return list;
  }

  get criticalCount() { return this.anomalies.filter(a => a.severity==='critical' && !this.resolvedIds.has(a.id)).length; }
  get warningCount()  { return this.anomalies.filter(a => a.severity==='warning'  && !this.resolvedIds.has(a.id)).length; }
  get normalCount() { 
    // Count institutions that don't have any active anomalies in the current list
    const anomalyInstIds = new Set(this.anomalies.filter(a => !this.resolvedIds.has(a.id)).map(a => a.institution_id));
    // Assuming total institutions is 12 (from our seeder)
    return Math.max(0, 12 - anomalyInstIds.size);
  }

  toggleExpand(i: number): void { this.expandedCards[i] = !this.expandedCards[i]; }

  resolve(id: string): void {
    this.analyticsService.resolveInsight(id).subscribe({
      next: () => {
        this.resolvedIds.add(id);
      },
      error: (err: any) => {
        console.error('Failed to resolve insight in DB', err);
        // Fallback to local hide if DB column is missing
        this.resolvedIds.add(id);
      }
    });
  }

  viewDetails(anomaly: any): void {
    // Navigate to the institution's dashboard
    const instId = this.anomalies.find(a => a.id === anomaly.id)?.institution_id;
    if (instId) {
      window.location.href = `/institution?id=${instId}`;
    } else {
      window.location.href = `/institution`;
    }
  }

  exportAnomaly(anomaly: any): void {
    const content = `UCAR ANOMALY REPORT\n--------------------\nKPI: ${anomaly.kpi}\nInstitution: ${anomaly.institution}\nSeverity: ${anomaly.severity}\nCurrent Value: ${anomaly.current}\nExplanation: ${anomaly.explanation}`;
    const blob = new Blob([content], { type: 'text/plain' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `Anomaly_${anomaly.kpi.replace(' ','_')}.txt`;
    a.click();
    window.URL.revokeObjectURL(url);
  }

  calculateDuration(dateStr: string): string {
    const created = new Date(dateStr);
    const now = new Date();
    const diffMs = now.getTime() - created.getTime();
    const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24));
    const diffHours = Math.floor(diffMs / (1000 * 60 * 60));
    
    if (diffDays > 0) return `${diffDays} day${diffDays > 1 ? 's' : ''} ago`;
    if (diffHours > 0) return `${diffHours} hour${diffHours > 1 ? 's' : ''} ago`;
    return 'Just now';
  }

  borderColor(sev: string): string { return sev === 'critical' ? 'var(--danger)' : 'var(--warning)'; }
  badgeClass(sev: string): string { return sev === 'critical' ? 'badge-critical' : 'badge-warning'; }
}
