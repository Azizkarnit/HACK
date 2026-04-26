import { Component, OnInit, AfterViewInit, ElementRef, ViewChild, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Chart, registerables } from 'chart.js';
Chart.register(...registerables);

import { DashboardService, GlobalDashboardData } from '../../core/services/dashboard.service';
import { Subscription } from 'rxjs';
import { Router } from '@angular/router';

@Component({
  selector: 'app-dashboard-global',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './dashboard-global.component.html',
  styleUrls: ['./dashboard-global.component.scss']
})
export class DashboardGlobalComponent implements OnInit, AfterViewInit, OnDestroy {
  @ViewChild('barChart') barChartRef!: ElementRef<HTMLCanvasElement>;
  chart: Chart | null = null;
  searchTerm = '';
  selectedDomain = 'Academic';
  aiLoading = false;
  isLoadingData = true;
  private sub?: Subscription;

  constructor(private dashboardService: DashboardService, private router: Router) {}

  domains = ['Academic', 'Finance', 'HR', 'ESG', 'Research', 'Infrastructure'];

  statCards = [
    { label: 'Total Institutions', icon: 'fa-building',             value: '-',  sub: 'Loading...',       color: 'navy',    subColor: 'success' },
    { label: 'KPIs Being Tracked', icon: 'fa-chart-bar',            value: '-',  sub: 'Across all institutions',    color: 'navy',    subColor: 'muted' },
    { label: 'Open Alerts',        icon: 'fa-triangle-exclamation', value: '-',  sub: 'Needs attention',         color: 'danger',  subColor: 'danger' },
    { label: 'Reports Generated',  icon: 'fa-file-lines',           value: '-',  sub: 'Loading...',                color: 'success', subColor: 'muted' },
  ];

  institutions: any[] = [];
  alerts: any[] = [];
  errorMessage: string | null = null;

  chartData: Record<string, number[]> = {
    'Academic': [], 'Finance': [], 'HR': [], 'ESG': [], 'Research': [], 'Infrastructure': []
  };

  get filteredInstitutions() {
    return this.institutions.filter(i =>
      i.name.toLowerCase().includes(this.searchTerm.toLowerCase())
    );
  }

  aiText = 'Analyzing latest institutional data...';

  ngOnInit(): void {
    this.sub = this.dashboardService.getGlobalDashboard().subscribe({
      next: (data) => {
        console.log('Dashboard data received:', data);
        this.isLoadingData = false;
        try {
          // 1. Update Stat Cards
          const uniqueInsts = new Set(data.kpis.map(k => k.institution_id)).size;
          this.statCards[0].value = uniqueInsts.toString();
          this.statCards[1].value = data.kpis.length.toString();
          this.statCards[2].value = data.alerts.length.toString();
          this.statCards[3].value = (data as any).report_count?.toString() || '0';

          // 2. Map Alerts
          this.alerts = data.alerts.map((a: any) => ({
            severity: a.severity,
            institution: a.institutions?.name || 'Global',
            message: a.message,
            time: new Date(a.created_at).toLocaleDateString()
          }));

          // 3. Process Leaderboard & Chart Data
          const instScores: any = {};
          data.kpis.forEach((k: any) => {
            const instId = k.institution_id;
            // Map 'Financial' from DB to 'Finance' for UI
            let cat = k.kpi_definitions?.category || 'Academic';
            if (cat === 'Financial') cat = 'Finance';
            
            if (!instScores[instId]) {
              instScores[instId] = { 
                id: instId, 
                name: k.institutions?.name || 'Unknown', 
                scores: {} 
              };
            }
            if (!instScores[instId].scores[cat]) instScores[instId].scores[cat] = [];
            instScores[instId].scores[cat].push(k.value);
          });

          this.institutions = Object.values(instScores).map((inst: any) => {
            const allScores = Object.values(inst.scores).flat() as number[];
            const avg = allScores.length ? Math.round(allScores.reduce((a, b) => a + b, 0) / allScores.length) : 0;
            
            // Helper to get status string
            const getStatus = (cat: string) => {
              const s = inst.scores[cat];
              if (!s || !s.length) return 'N/A';
              const v = s[0]; // Latest
              return v > 70 ? 'Good' : v > 40 ? 'Warning' : 'Critical';
            };

            return {
              ...inst,
              score: avg,
              academic: getStatus('Academic'),
              finance: getStatus('Finance'),
              hr: getStatus('HR'),
              esg: getStatus('ESG'),
              change: '+2%',
              status: 'up'
            };
          }).sort((a, b) => b.score - a.score).slice(0, 10);

          // 4. Update Chart Data
          this.domains.forEach(d => {
            this.chartData[d] = this.institutions.map(inst => {
              const s = inst.scores[d];
              return s && s.length ? Math.round(s.reduce((a:any,b:any)=>a+b,0)/s.length) : 0;
            });
          });

          if (data.insights && data.insights.length > 0) {
            this.aiText = data.insights[0].description;
          }

          setTimeout(() => this.initChart(), 100);
        } catch (err) {
          console.error('Error processing dashboard data:', err);
        }
      },
      error: (err) => {
        console.error('Failed to load dashboard data', err);
        this.isLoadingData = false;
        this.errorMessage = "Failed to load dashboard data from the server. Please ensure the backend is running and the database is seeded.";
      }
    });
  }

  viewInstitution(inst: any) {
    this.router.navigate(['/institution'], { queryParams: { id: inst.id } });
  }

  ngOnDestroy(): void {
    if (this.sub) this.sub.unsubscribe();
  }

  ngAfterViewInit(): void {
    setTimeout(() => this.initChart(), 100);
  }

  initChart(): void {
    if (!this.barChartRef) return;
    if (this.chart) this.chart.destroy();
    this.chart = new Chart(this.barChartRef.nativeElement, {
      type: 'bar',
      data: {
        labels: this.institutions.map(i => i.name),
        datasets: [{
          data: this.chartData[this.selectedDomain] || [],
          backgroundColor: (this.chartData[this.selectedDomain] || []).map((v: number) => v < 50 ? '#C0392B' : '#1B3A6B'),
          hoverBackgroundColor: '#2D5494',
          borderRadius: 4,
        }]
      },
      options: {
        indexAxis: 'y',
        responsive: true,
        maintainAspectRatio: false,
        plugins: { legend: { display: false } },
        scales: {
          x: { 
            // Scale automatically based on data values
            max: undefined,
            grid: { color: '#EEF1F6' }, 
            ticks: { font: { family: 'Inter', size: 11 } } 
          },
          y: { grid: { display: false }, ticks: { font: { family: 'Inter', size: 12 } } }
        }
      }
    });
  }

  onDomainChange(): void {
    if (!this.chart) return;
    const newData = this.chartData[this.selectedDomain] || [];
    this.chart.data.datasets[0].data = newData;
    this.chart.data.datasets[0].backgroundColor = newData.map((v: number) => v < 50 ? '#C0392B' : '#1B3A6B');
    this.chart.update();
  }

  regenerateInsight(): void {
    this.aiLoading = true;
    this.dashboardService.getStrategicInsight().subscribe({
      next: (res) => {
        this.aiText = res.insight;
        this.aiLoading = false;
      },
      error: (err) => {
        console.error('AI Insight Error', err);
        this.aiLoading = false;
        this.aiText = "Failed to regenerate strategic insights. Please ensure the AI token is valid.";
      }
    });
  }

  getSeverityClass(val: string): string {
    if (val === 'Good')     return 'success';
    if (val === 'Warning')  return 'warning';
    if (val === 'Critical') return 'critical';
    return '';
  }

  dotClass(sev: string): string {
    if (sev === 'critical') return 'dot-critical';
    if (sev === 'warning')  return 'dot-warning';
    if (sev === 'success')  return 'dot-success';
    return 'dot-gray';
  }
}
