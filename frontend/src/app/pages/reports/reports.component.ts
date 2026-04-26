import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../core/services/auth.service';
import { DashboardService } from '../../core/services/dashboard.service';

@Component({
  selector: 'app-reports',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './reports.component.html',
  styleUrls: ['./reports.component.scss']
})
export class ReportsComponent implements OnInit {
  role: string | null = null;
  selectedType = 'monthly';
  scopeMode = 'all';
  selectedInst = '';
  selectedFormat = 'pdf';
  generating = false;
  progress = 0;
  generated = false;
  showPreview = false;

  sections = [
    { id:'exec',     label:'Executive Summary (AI-generated)', checked: true },
    { id:'academic', label:'Academic Performance',              checked: true },
    { id:'finance',  label:'Financial Overview',               checked: true },
    { id:'hr',       label:'HR Report',                        checked: true },
    { id:'research', label:'Research Output',                  checked: false },
    { id:'esg',      label:'ESG & Sustainability',             checked: true },
    { id:'infra',    label:'Infrastructure Status',            checked: false },
    { id:'partner',  label:'Partnership Activity',             checked: false },
    { id:'anomaly',  label:'Anomaly Summary',                  checked: true },
    { id:'ai',       label:'AI Recommendations',               checked: true },
  ];

  history = [
    { name:'Monthly_April_2025_All.pdf',    scope:'All Institutions', type:'Monthly', format:'pdf',   date:'01 Apr 2025' },
    { name:'Monthly_March_2025_All.xlsx',   scope:'All Institutions', type:'Monthly', format:'excel', date:'01 Mar 2025' },
    { name:'Weekly_W14_ESCT.pdf',           scope:'ESCT',            type:'Weekly',  format:'pdf',   date:'06 Apr 2025' },
    { name:'Annual_2024_All.pdf',           scope:'All Institutions', type:'Annual',  format:'pdf',   date:'01 Jan 2025' },
    { name:'Monthly_Feb_2025_IPEIEM.pdf',   scope:'IPEIEM',          type:'Monthly', format:'pdf',   date:'01 Feb 2025' },
  ];

  institutions: any[] = [];
  selectedInstId = '';

  constructor(private auth: AuthService, private dashboardService: DashboardService) {}

  ngOnInit(): void {
    this.role = this.auth.getRole();
    this.dashboardService.getInstitutions().subscribe(data => {
      this.institutions = data;
      if (this.institutions.length > 0) {
        this.selectedInstId = this.institutions[0].id;
      }
    });
  }

  generate(): void {
    this.generating = true;
    this.progress = 0;
    this.generated = false;
    
    // Determine target institution (defaults to user's institution if they are not super_admin/agent, or if "all" is selected we use HQ or current for now)
    const targetInstId = this.scopeMode === 'specific' ? this.selectedInstId : this.auth.getInstitutionId();
    if (!targetInstId) {
       alert("No institution selected or found.");
       this.generating = false;
       return;
    }

    const reportObs = this.selectedFormat === 'pdf' 
      ? this.dashboardService.downloadPdfReport(targetInstId, this.selectedType)
      : this.dashboardService.downloadExcelReport(targetInstId, this.selectedType);

    // Fake progress bar while waiting for HTTP
    const interval = setInterval(() => {
      if (this.progress < 90) this.progress += 10;
    }, 200);

    reportObs.subscribe({
      next: (blob: Blob) => {
        clearInterval(interval);
        this.progress = 100;
        
        setTimeout(() => {
          this.generating = false;
          this.generated = true;
          this.showPreview = true;
          
          const instName = this.institutions.find(i => i.id === targetInstId)?.name || 'Institution';
          const ext = this.selectedFormat === 'pdf' ? 'pdf' : 'xlsx';
          const name = `${this.selectedType}_Report_${new Date().toLocaleDateString('en-GB').replace(/\//g,'-')}_${instName}.${ext}`;
          
          this.history.unshift({ 
            name, 
            scope: this.scopeMode === 'all' ? 'All Institutions' : instName, 
            type: this.selectedType, 
            format: this.selectedFormat, 
            date: new Date().toLocaleDateString('en-GB', {day:'2-digit',month:'short',year:'numeric'}) 
          });

          // Trigger download automatically
          this.downloadBlob(blob, name);
        }, 500);
      },
      error: (err) => {
        clearInterval(interval);
        console.error("Report generation failed", err);
        alert("Failed to generate report. Make sure backend is running and you have access.");
        this.generating = false;
      }
    });
  }

  downloadBlob(blob: Blob, filename: string): void {
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = filename;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    window.URL.revokeObjectURL(url);
  }
}
