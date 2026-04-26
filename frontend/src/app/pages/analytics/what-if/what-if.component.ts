import { Component, OnInit, AfterViewInit, ElementRef, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../../core/services/auth.service';
import { DashboardService } from '../../../core/services/dashboard.service';
import { AnalyticsService } from '../../../core/services/analytics.service';
import { Chart, registerables } from 'chart.js';
Chart.register(...registerables);

@Component({
  selector: 'app-what-if',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './what-if.component.html',
  styleUrls: ['./what-if.component.scss']
})
export class WhatIfComponent implements OnInit, AfterViewInit {
  @ViewChild('scatterChart') chartRef!: ElementRef<HTMLCanvasElement>;
  chart: Chart | null = null;

  role: string | null = null;
  isAccessDenied = false;

  institutions: any[] = [];
  selectedInstitution = '';
  baseKpi = 'dropout_rate';
  targetKpi = 'success_rate';
  changePct = 10;
  loading = false;
  showResults = false;

  kpis = [
    { code: 'dropout_rate', name: 'Dropout Rate' },
    { code: 'success_rate', name: 'Success Rate' },
    { code: 'budget_execution', name: 'Budget Execution' },
    { code: 'absenteeism_rate', name: 'Absenteeism Rate' },
    { code: 'carbon_footprint', name: 'Carbon Footprint' },
    { code: 'classroom_occupancy', name: 'Classroom Occupancy' }
  ];

  presets = [-20, -10, 10, 25, 50];

  result = { 
    correlation: 0, 
    direction: 'Neutral', 
    impact: '0%', 
    newValue: '0', 
    originalValue: '0',
    description: '' 
  };

  constructor(
    private auth: AuthService, 
    private dashboardService: DashboardService,
    private analyticsService: AnalyticsService
  ) {}

  ngOnInit(): void {
    this.role = this.auth.getRole();
    this.isAccessDenied = this.role === 'admin';
    this.loadInstitutions();
  }

  ngAfterViewInit(): void {}

  loadInstitutions(): void {
    this.dashboardService.getInstitutions().subscribe(data => {
      this.institutions = data;
      if (this.institutions.length > 0) {
        this.selectedInstitution = this.institutions[0].id;
      }
    });
  }

  get changeLabel(): string { return this.changePct >= 0 ? `+${this.changePct}%` : `${this.changePct}%`; }
  get changeColor(): string { return this.changePct < 0 ? 'var(--danger)' : this.changePct > 50 ? 'var(--navy)' : 'var(--success)'; }

  setPreset(val: number): void { this.changePct = val; }

  runSimulation(): void {
    if (!this.selectedInstitution) return;
    
    this.loading = true;
    this.showResults = false;

    this.analyticsService.runSimulation({
      institution_id: this.selectedInstitution,
      base_kpi: this.baseKpi,
      target_kpi: this.targetKpi,
      change_percent: this.changePct
    }).subscribe({
      next: (data) => {
        this.loading = false;
        this.showResults = true;
        
        this.result = {
          correlation: Math.abs(data.correlation_coefficient),
          direction: data.impact_direction,
          impact: `${data.predicted_impact_percent > 0 ? '+' : ''}${data.predicted_impact_percent}%`,
          newValue: data.simulated_target_value.toString(),
          originalValue: '--', // Could fetch actual latest value
          description: `Changing ${this.baseKpi.replace('_',' ')} by ${this.changePct}% is projected to result in a ${data.predicted_impact_percent}% change in ${this.targetKpi.replace('_',' ')}.`
        };

        setTimeout(() => this.initChart(data), 100);
      },
      error: (err) => {
        console.error('Simulation failed', err);
        this.loading = false;
        alert('Simulation failed. Please ensure both KPIs have historical data for this institution.');
      }
    });
  }

  initChart(simData: any): void {
    if (!this.chartRef) return;
    if (this.chart) this.chart.destroy();
    
    // Generate some points around a line based on correlation for visualization
    const pts = Array.from({length:20}, (_, i) => {
      const x = 10 + i;
      const y = 50 + (i * simData.correlation_coefficient * 2) + (Math.random() - 0.5) * 10;
      return { x, y };
    });

    this.chart = new Chart(this.chartRef.nativeElement, {
      type: 'scatter',
      data: {
        datasets: [
          { label:'Historical Correlation', data: pts, backgroundColor:'rgba(27,58,107,0.5)', pointRadius:5 },
          { 
            label:'Simulated Point', 
            data:[{x: 20 * (1 + this.changePct/100), y: simData.simulated_target_value}], 
            backgroundColor:'rgba(192,57,43,0.9)', 
            pointRadius:10, 
            pointStyle:'triangle' 
          }
        ]
      },
      options: {
        responsive: true,
        plugins: { legend: { labels: { font:{family:'Inter',size:12} } } },
        scales: {
          x: { title:{display:true,text:this.baseKpi.replace('_',' ').toUpperCase(),font:{family:'Inter'}}, grid:{color:'#EEF1F6'} },
          y: { title:{display:true,text:this.targetKpi.replace('_',' ').toUpperCase(),font:{family:'Inter'}}, grid:{color:'#EEF1F6'} }
        }
      }
    });
  }
}
