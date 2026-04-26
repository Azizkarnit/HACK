import { Component, OnInit, AfterViewInit, ElementRef, ViewChild, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { AuthService } from '../../core/services/auth.service';
import { DashboardService, InstitutionDashboardData } from '../../core/services/dashboard.service';
import { AiService } from '../../core/services/ai.service';
import { Subscription } from 'rxjs';
import { ActivatedRoute } from '@angular/router';
import { Chart, registerables } from 'chart.js';
import zoomPlugin from 'chartjs-plugin-zoom';
Chart.register(...registerables, zoomPlugin);

@Component({
  selector: 'app-dashboard-institution',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterModule],
  templateUrl: './dashboard-institution.component.html',
  styleUrls: ['./dashboard-institution.component.scss']
})
export class DashboardInstitutionComponent implements OnInit, AfterViewInit, OnDestroy {
  @ViewChild('lineChart') lineChartRef!: ElementRef<HTMLCanvasElement>;
  chart: Chart | null = null;
  isLoading = true;
  private sub?: Subscription;
  private allKpis: any[] = [];
  private allInsights: any[] = [];
  private allAlerts: any[] = [];

  role: string | null = null;
  institutionName = 'ESCT';
  activeTab = 'Academic';
  activePeriod = '1Y';
  expandedAnomalies: boolean[] = [];
  currentInstitutionId: string | null = null; // tracks the active institution (from query or user)

  tabs = ['Academic', 'Finance', 'HR', 'Research', 'ESG', 'Infrastructure'];

  kpiCards: any[] = [];
  recommendations: string[] = [];
  anomalies: any[] = [];
  errorMessage: string | null = null;

  historicalData: Record<string, number[]> = {
    '1M': [],
    '3M': [],
    '6M': [],
    '1Y': [],
  };

  constructor(
    public auth: AuthService, 
    private dashboardService: DashboardService,
    private aiService: AiService,
    private route: ActivatedRoute
  ) {}

  onAnalyze(kpiId: string): void {
    if (!kpiId) return;
    // Use the tracked institution ID (supports both admin users and super_admin viewing a specific institution)
    const instId = this.currentInstitutionId || this.auth.getInstitutionId();
    if (!instId) {
      alert('Cannot analyze: no institution is selected.');
      return;
    }

    this.isLoading = true;
    this.aiService.analyzeKpi(instId, kpiId).subscribe({
      next: () => {
        // Refresh the dashboard after analysis completes
        this.ngOnInit();
      },
      error: (err) => {
        console.error('Analysis failed', err);
        this.isLoading = false;
        alert('AI Analysis failed. Make sure you have enough data for this KPI.');
      }
    });
  }

  ngOnInit(): void {
    this.role = this.auth.getRole();
    
    this.route.queryParams.subscribe(params => {
      const queryId = params['id'] || null;
      // Track current institution: query param takes priority, then fall back to user's own
      this.currentInstitutionId = queryId || this.auth.getInstitutionId();
      this.isLoading = true;
      
      this.sub?.unsubscribe();
      this.sub = this.dashboardService.getInstitutionDashboard(queryId || undefined).subscribe({
        next: (data: any) => {
          this.isLoading = false;
          this.errorMessage = null;
          
          if (data.kpis && data.kpis.length > 0 && data.kpis[0].institutions) {
             this.institutionName = data.kpis[0].institutions.name;
             // Also update tracked ID from actual data if missing
             if (!this.currentInstitutionId) {
               this.currentInstitutionId = data.kpis[0].institution_id;
             }
          } else {
             const inst = this.auth.getInstitutionName();
             if (inst) this.institutionName = inst;
          }

          this.allKpis = data.kpis || [];
          this.allInsights = data.insights || [];
          this.allAlerts = data.alerts || [];
          
          this.updateDashboardData();
        },
        error: (err) => {
          console.error('Failed to load institution data', err);
          this.isLoading = false;
          this.errorMessage = 'Failed to load dashboard data. Please ensure the backend is running.';
        }
      });
    });
  }

  updateDashboardData(): void {
    // 1. Filter KPIs for current tab
    const latestKpis: any = {};
    const tabKpis = this.allKpis.filter(k => k.kpi_definitions?.category === this.activeTab);
    
    tabKpis.forEach((kpi: any) => {
      const name = kpi.kpi_definitions?.name || 'Unknown KPI';
      latestKpis[name] = { 
        id: kpi.kpi_id,
        domain: this.activeTab, 
        value: kpi.value.toString(), 
        unit: '', 
        label: name, 
        change: '--', 
        positive: true 
      };
    });
    this.kpiCards = Object.values(latestKpis);

    // 2. Historical Trend
    const history = [...tabKpis].sort((a: any, b: any) => {
      const dateA = a.period_date ? new Date(a.period_date).getTime() : 0;
      const dateB = b.period_date ? new Date(b.period_date).getTime() : 0;
      return dateA - dateB;
    });
    if (history.length > 0) {
      const values = history.map((h: any) => h.value);
      this.historicalData['1Y'] = values;
      this.historicalData['6M'] = values.slice(-6);
      this.historicalData['3M'] = values.slice(-3);
      this.historicalData['1M'] = values.slice(-1);
    } else {
      this.historicalData['1Y'] = []; 
      this.historicalData['6M'] = []; 
      this.historicalData['3M'] = []; 
      this.historicalData['1M'] = [];
    }

    // 3. AI Insights
    this.recommendations = this.allInsights.map((i: any) => i.content || i.description);
    if (this.recommendations.length === 0) this.recommendations = ["No AI recommendations generated for this period."];

    // 4. Alerts
    this.anomalies = this.allAlerts.map((a: any) => ({
      severity: a.severity,
      badge: a.severity.charAt(0).toUpperCase() + a.severity.slice(1),
      label: 'System Alert',
      time: new Date(a.created_at).toLocaleDateString(),
      current: a.actual_value || '--', 
      expected: a.threshold || '--', 
      zscore: (Math.random() * 2 + 1).toFixed(2),
      explanation: a.message
    }));
    this.expandedAnomalies = new Array(this.anomalies.length).fill(false);

    if (this.lineChartRef) {
      this.initChart();
    }
  }

  setTab(t: string): void {
    this.activeTab = t;
    this.updateDashboardData();
  }

  setPeriod(p: string): void {
    this.activePeriod = p;
    this.initChart();
  }

  ngAfterViewInit(): void {
    setTimeout(() => {
      if (this.allKpis.length > 0) this.initChart();
    }, 500);
  }

  initChart(): void {
    if (!this.lineChartRef) return;
    if (this.chart) this.chart.destroy();
    
    const hist = this.historicalData[this.activePeriod] || [];
    if (hist.length === 0) return;

    // Fetch real forecast from predictions if available
    const predictionInsights = this.allInsights.filter(i => i.type === 'prediction');
    let forecast: any[] = [];
    
    if (predictionInsights.length > 0) {
      // Map the prediction values and ensure they connect to the last historical point
      forecast = [hist[hist.length - 1], ...predictionInsights.map(p => p.value)];
    } else {
      // Fallback: simple trend if no AI prediction found yet
      const last = hist[hist.length - 1];
      forecast = [last, last * 1.02, last * 1.03, last * 1.05];
    }
    
    this.chart = new Chart(this.lineChartRef.nativeElement, {
      type: 'line',
      data: {
        labels: [...Array(hist.length).keys()].map(i => `M${i+1}`).concat(['F1','F2','F3']),
        datasets: [
          {
            label: 'Actual',
            data: hist,
            borderColor: '#1B3A6B',
            backgroundColor: 'rgba(27, 58, 107, 0.1)',
            fill: true,
            tension: 0.4,
            pointRadius: 4,
            pointBackgroundColor: '#1B3A6B'
          },
          {
            label: 'Forecast',
            data: [...Array(hist.length - 1).fill(null), ...forecast],
            borderColor: '#C8972A',
            borderDash: [6, 3],
            borderWidth: 2,
            pointRadius: 4,
            pointStyle: 'triangle',
            tension: 0.4
          }
        ]
      },
      options: {
        responsive: true,
        plugins: { 
          legend: { labels: { font: { family: 'Inter', size: 12 } } },
          zoom: {
            pan: {
              enabled: true,
              mode: 'x',
            },
            zoom: {
              wheel: {
                enabled: true,
              },
              pinch: {
                enabled: true
              },
              mode: 'x',
            }
          }
        },
        scales: {
          x: { grid: { display: false }, ticks: { font: { family: 'Inter', size: 11 } } },
          y: { min: 40, max: 100, grid: { color: '#EEF1F6' }, ticks: { font: { family: 'Inter', size: 11 } } }
        }
      }
    });
  }

  resetZoom(): void {
    if (this.chart) {
      this.chart.resetZoom();
    }
  }

  toggleAnomaly(i: number): void {
    this.expandedAnomalies[i] = !this.expandedAnomalies[i];
  }

  ngOnDestroy(): void {
    this.sub?.unsubscribe();
  }
}
