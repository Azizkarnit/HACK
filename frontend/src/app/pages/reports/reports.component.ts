import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../core/services/auth.service';

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

  institutions = ['ISET Charguia','ESCT','ISG Tunis','IPEIT','IPEIEM','ISSATS','ISSAT Manouba','ISTMT'];

  constructor(private auth: AuthService) {}

  ngOnInit(): void {
    this.role = this.auth.getRole();
  }

  generate(): void {
    this.generating = true;
    this.progress = 0;
    this.generated = false;
    const interval = setInterval(() => {
      this.progress += 5;
      if (this.progress >= 100) {
        clearInterval(interval);
        setTimeout(() => {
          this.generating = false;
          this.generated = true;
          this.showPreview = true;
          const name = `${this.selectedType}_Report_${new Date().toLocaleDateString('en-GB').replace(/\//g,'-')}.${this.selectedFormat === 'pdf' ? 'pdf' : 'xlsx'}`;
          this.history.unshift({ name, scope: this.scopeMode === 'all' ? 'All Institutions' : this.selectedInst, type: this.selectedType, format: this.selectedFormat, date: new Date().toLocaleDateString('en-GB', {day:'2-digit',month:'short',year:'numeric'}) });
        }, 300);
      }
    }, 150);
  }
}
