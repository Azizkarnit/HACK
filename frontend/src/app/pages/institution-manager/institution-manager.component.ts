import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../core/services/auth.service';

@Component({
  selector: 'app-institution-manager',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './institution-manager.component.html',
  styleUrls: ['./institution-manager.component.scss']
})
export class InstitutionManagerComponent implements OnInit {
  role: string | null = null;
  viewMode: 'table' | 'cards' = 'table';
  searchTerm = '';
  showModal = false;
  showPanel = false;
  selectedInstitution: any = null;
  toastMsg = '';

  institutions: Array<{id:string; name:string; city:string; type:string; score:number; alerts:number; status: string}> = [
    { id:'1',  name:'ISET Charguia',  city:'Tunis',   type:'Institut Supérieur',   score:78, alerts:0, status:'active' },
    { id:'2',  name:'ESCT',           city:'Tunis',   type:'École Supérieure',     score:91, alerts:3, status:'active' },
    { id:'3',  name:'ISG Tunis',      city:'Tunis',   type:'Institut Supérieur',   score:82, alerts:1, status:'active' },
    { id:'4',  name:'IPEIT',          city:'Ariana',  type:'Institut Préparatoire',score:67, alerts:0, status:'active' },
    { id:'5',  name:'IPEIEM',         city:'Manouba', type:'Institut Préparatoire',score:44, alerts:4, status:'active' },
    { id:'6',  name:'ISSATS',         city:'Sousse',  type:'Institut Supérieur',   score:73, alerts:0, status:'active' },
    { id:'7',  name:'ISSAT Manouba',  city:'Manouba', type:'Institut Supérieur',   score:88, alerts:2, status:'active' },
    { id:'8',  name:'ISTMT',          city:'Tunis',   type:'Institut Supérieur',   score:41, alerts:1, status:'active' },
    { id:'9',  name:'INSAT',          city:'Tunis',   type:'Institut National',    score:86, alerts:0, status:'active' },
    { id:'10', name:'ENAU',           city:'Tunis',   type:'École Nationale',      score:79, alerts:0, status:'active' },
    { id:'11', name:'FSEG Nabeul',    city:'Nabeul',  type:'Faculté',              score:55, alerts:2, status:'active' },
    { id:'12', name:'ISET Nabeul',    city:'Nabeul',  type:'Institut Supérieur',   score:38, alerts:0, status:'inactive' },
  ];

  modalForm = { name:'', name_ar:'', abbreviation:'', city:'', type:'', address:'', director:'', email:'', phone:'', status:'active' };

  constructor(private auth: AuthService) {}

  ngOnInit(): void {
    this.role = this.auth.getRole();
    if (this.role === 'admin') {
      // Redirect handled by route guard; show empty here as fallback
    }
  }

  get filteredInstitutions() {
    return this.institutions.filter(i =>
      !this.searchTerm || i.name.toLowerCase().includes(this.searchTerm.toLowerCase())
    );
  }

  get counts() {
    return {
      total:    this.institutions.length,
      active:   this.institutions.filter(i => i.status === 'active').length,
      inactive: this.institutions.filter(i => i.status === 'inactive').length,
    };
  }

  scoreColor(score: number): string {
    if (score >= 70) return 'var(--success)';
    if (score >= 40) return 'var(--warning)';
    return 'var(--danger)';
  }

  openPanel(inst: any): void { this.selectedInstitution = inst; this.showPanel = true; }
  closePanel(): void { this.showPanel = false; }
  openModal(): void { this.modalForm = { name:'', name_ar:'', abbreviation:'', city:'', type:'', address:'', director:'', email:'', phone:'', status:'active' }; this.showModal = true; }
  closeModal(): void { this.showModal = false; }

  saveInstitution(): void {
    if (!this.modalForm.name) return;
    this.institutions.push({ id: String(this.institutions.length+1), name: this.modalForm.name, city: this.modalForm.city, type: this.modalForm.type, score: 70, alerts: 0, status: 'active' });
    this.showModal = false;
    this.showToast('Institution added successfully');
  }

  deleteInstitution(inst: any): void {
    if (confirm(`Delete ${inst.name}?`)) {
      this.institutions = this.institutions.filter(i => i.id !== inst.id);
      this.showToast('Institution deleted');
    }
  }

  showToast(msg: string): void { this.toastMsg = msg; setTimeout(() => this.toastMsg = '', 3000); }

  getInitial(name: string): string { return name[0].toUpperCase(); }
}
