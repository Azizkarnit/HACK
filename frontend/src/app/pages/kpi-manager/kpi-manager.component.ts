import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../core/services/auth.service';

@Component({
  selector: 'app-kpi-manager',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './kpi-manager.component.html',
  styleUrls: ['./kpi-manager.component.scss']
})
export class KpiManagerComponent implements OnInit {
  role: string | null = null;
  searchTerm = '';
  domainFilter = '';
  selectedKpi: any = null;
  aiLoading = false;
  showAiPanel = false;

  kpiList = [
    { name:'Success Rate',       institution:'ESCT',          domain:'Academic',       value:'91.2%', severity:'good' },
    { name:'Dropout Rate',       institution:'IPEIEM',         domain:'Academic',       value:'18.4%', severity:'critical' },
    { name:'Budget Execution',   institution:'ESCT',          domain:'Finance',        value:'54.1%', severity:'critical' },
    { name:'Attendance Rate',    institution:'ISG',           domain:'Academic',       value:'92.1%', severity:'good' },
    { name:'Energy Consumption', institution:'ISET',          domain:'ESG',            value:'142 kWh',severity:'warning' },
    { name:'Absenteeism Rate',   institution:'IPEIEM',         domain:'HR',             value:'12.3%', severity:'critical' },
    { name:'Publications Count', institution:'IPEIT',          domain:'Research',       value:'34',    severity:'good' },
    { name:'Cost per Student',   institution:'ISG',           domain:'Finance',        value:'4,200 TND',severity:'good' },
    { name:'Carbon Footprint',   institution:'ESCT',          domain:'ESG',            value:'88 tCO2',severity:'warning' },
    { name:'Repeat Rate',        institution:'ISET Charguia', domain:'Academic',       value:'4.2%',  severity:'warning' },
    { name:'Classroom Occupancy',institution:'ISTMT',          domain:'Infrastructure', value:'41%',   severity:'critical' },
    { name:'Research Projects',  institution:'ISSATS',         domain:'Research',       value:'8',     severity:'good' },
    { name:'Employability Rate', institution:'ISG',           domain:'Academic',       value:'78.3%', severity:'good' },
    { name:'Budget Allocation',  institution:'ISSAT',          domain:'Finance',        value:'92%',   severity:'good' },
    { name:'HR Training Hours',  institution:'IPEIT',          domain:'HR',             value:'12h',   severity:'warning' },
  ];

  domains = ['Academic','Finance','HR','ESG','Research','Infrastructure','Partnerships'];

  constructor(private auth: AuthService) {}

  ngOnInit(): void {
    this.role = this.auth.getRole();
    this.selectedKpi = this.kpiList[1]; // default: Dropout Rate
  }

  get filteredKpis() {
    return this.kpiList.filter(k => {
      const ms = !this.searchTerm || k.name.toLowerCase().includes(this.searchTerm.toLowerCase());
      const md = !this.domainFilter || k.domain === this.domainFilter;
      return ms && md;
    });
  }

  selectKpi(k: any): void { this.selectedKpi = k; this.showAiPanel = false; }

  runAi(): void {
    this.aiLoading = true;
    this.showAiPanel = false;
    setTimeout(() => { this.aiLoading = false; this.showAiPanel = true; }, 2000);
  }

  severityBadge(sev: string): string {
    if (sev === 'critical') return 'badge-critical';
    if (sev === 'warning')  return 'badge-warning';
    return 'badge-success';
  }

  domainColor(domain: string): string {
    const map: Record<string,string> = {
      Academic: '#1B3A6B', Finance: '#C8972A', HR: '#C0392B',
      ESG: '#1B7A4A', Research: '#6C3483', Infrastructure: '#B06A00', Partnerships: '#1A535C'
    };
    return map[domain] || '#8E97A8';
  }
}
