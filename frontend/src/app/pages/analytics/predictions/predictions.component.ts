import { Component, OnInit, AfterViewInit, ElementRef, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../../core/services/auth.service';
import { DashboardService } from '../../../core/services/dashboard.service';
import { Chart, registerables } from 'chart.js';
Chart.register(...registerables);

@Component({
  selector: 'app-predictions',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './predictions.component.html',
  styleUrls: ['./predictions.component.scss']
})
export class PredictionsComponent implements OnInit, AfterViewInit {
  @ViewChild('forecastChart') chartRef!: ElementRef<HTMLCanvasElement>;
  chart: Chart | null = null;

  role: string | null = null;
  institutions: any[] = [];
  selectedInstId = '';
  selectedKpi = 'dropout_rate';
  horizon = '3';
  generated = false;
  loading = false;

  kpis = [
    { code: 'dropout_rate', name: 'Dropout Rate' },
    { code: 'success_rate', name: 'Success Rate' },
    { code: 'budget_execution', name: 'Budget Execution' },
    { code: 'absenteeism_rate', name: 'Absenteeism Rate' }
  ];
  
  horizons = [
    { value: '3', label: '3 Months' },
    { value: '6', label: '6 Months' },
    { value: '12', label: '1 Year' }
  ];

  forecasts: any[] = [];
  compTable: any[] = [];

  constructor(
    private auth: AuthService,
    private dashboardService: DashboardService
  ) {}

  ngOnInit(): void { 
    this.role = this.auth.getRole();
    this.loadInstitutions();
  }
  
  ngAfterViewInit(): void {}

  loadInstitutions(): void {
    this.dashboardService.getInstitutions().subscribe(data => {
      this.institutions = data;
      if (this.institutions.length > 0) {
        this.selectedInstId = this.institutions[0].id;
      }
    });
  }

  generate(): void {
    this.loading = true;
    this.generated = false;
    
    // Fetch historical data + predictions from the institution dashboard endpoint
    this.dashboardService.getInstitutionDashboard(this.selectedInstId).subscribe({
      next: (data) => {
        // 1. Extract historical values for this KPI
        const history = data.kpis
          .filter((k: any) => k.kpi_definitions?.code === this.selectedKpi)
          .sort((a: any, b: any) => new Date(a.period_date).getTime() - new Date(b.period_date).getTime());
        
        const histValues = history.map((h: any) => h.value);
        const histLabels = history.map((h: any) => new Date(h.period_date).toLocaleDateString(undefined, {month: 'short'}));

        // 2. Extract AI Predictions
        const predictions = data.insights
          .filter((i: any) => i.type === 'prediction' && i.description.toLowerCase().includes('predicted'))
          .slice(0, parseInt(this.horizon));

        this.forecasts = predictions.map((p: any, idx: number) => ({
          label: `Month +${idx + 1} (Forecast)`,
          value: `${p.value}${this.selectedKpi.includes('rate') ? '%' : ''}`,
          confidence: `${Math.round(p.confidence * 100)}%`
        }));

        this.loading = false;
        this.generated = true;
        
        setTimeout(() => this.initChart(histValues, histLabels, predictions.map((p: any) => p.value)), 100);
      },
      error: (err) => {
        console.error('Failed to load predictions', err);
        this.loading = false;
      }
    });
  }

  initChart(hist: number[], histLabels: string[], fc: number[]): void {
    if (!this.chartRef) return;
    if (this.chart) this.chart.destroy();
    
    const lastHistVal = hist[hist.length - 1];
    const fullLabels = [...histLabels, ...fc.map((_, i) => `Month +${i+1}*`)];
    const fcData = [...new Array(hist.length - 1).fill(null), lastHistVal, ...fc];

    this.chart = new Chart(this.chartRef.nativeElement, {
      type: 'line',
      data: {
        labels: fullLabels,
        datasets: [
          { 
            label:'Historical Data', 
            data: [...hist, ...new Array(fc.length).fill(null)] as any[], 
            borderColor:'#1B3A6B', 
            borderWidth:3, 
            pointRadius:4, 
            tension:0.4,
            fill: false 
          },
          { 
            label:'AI Forecast', 
            data: fcData as any[], 
            borderColor:'#C8972A', 
            borderDash:[8,4], 
            borderWidth:3, 
            pointRadius:6, 
            tension:0.4,
            fill: false 
          }
        ]
      },
      options: {
        responsive: true,
        plugins: { 
          legend: { labels: { font:{family:'Inter',size:12} } },
          tooltip: { mode: 'index', intersect: false }
        },
        scales: {
          x: { grid:{display:false}, ticks:{font:{family:'Inter',size:11}} },
          y: { 
            grid:{color:'#EEF1F6'}, 
            ticks:{font:{family:'Inter',size:11}},
            beginAtZero: false 
          }
        }
      }
    });
  }
}
