import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { AuthService } from '../../core/services/auth.service';
import { environment } from '../../../environments/environment';

@Component({
  selector: 'app-user-management',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './user-management.component.html',
  styleUrls: ['./user-management.component.scss']
})
export class UserManagementComponent implements OnInit {
  role: string | null = null;
  searchTerm = '';
  roleFilter = '';
  instFilter = '';
  showModal = false;
  showDeleteModal = false;
  editMode = false;
  deleteTarget: any = null;
  toastMsg = '';

  modalForm = { full_name: '', email: '', role: 'agent', institution: '', password: '', confirm_password: '' };
  isSaving = false;
  passwordVisible = false;

  users = [
    { id:'1', full_name:'Karim Mansouri',  email:'karim.m@ucar.rnu.tn',     role:'super_admin', institution:'All Institutions', status:'active',   last_login:'Today' },
    { id:'2', full_name:'Leila Jebali',    email:'l.jebali@ucar.rnu.tn',    role:'super_admin', institution:'All Institutions', status:'active',   last_login:'2 days ago' },
    { id:'3', full_name:'Sonia Bchir',     email:'s.bchir@ucar.rnu.tn',     role:'agent',       institution:'All Institutions', status:'active',   last_login:'Today' },
    { id:'4', full_name:'Mohamed Trabelsi',email:'m.trabelsi@ucar.rnu.tn',  role:'agent',       institution:'All Institutions', status:'active',   last_login:'1 day ago' },
    { id:'5', full_name:'Fatma Saidi',     email:'f.saidi@ucar.rnu.tn',     role:'agent',       institution:'All Institutions', status:'active',   last_login:'3 days ago' },
    { id:'6', full_name:'Amine Khelil',    email:'a.khelil@ucar.rnu.tn',    role:'agent',       institution:'All Institutions', status:'inactive', last_login:'2 weeks ago' },
    { id:'7', full_name:'Ahmed Ben Ali',   email:'a.benali@isg.ucar.tn',    role:'admin',       institution:'ISG Tunis',        status:'active',   last_login:'Today' },
    { id:'8', full_name:'Marwa Oueslati',  email:'m.oueslati@ipeiem.ucar.tn',role:'admin',      institution:'IPEIEM',           status:'active',   last_login:'Today' },
    { id:'9', full_name:'Rami Hamdi',      email:'r.hamdi@esct.ucar.tn',    role:'admin',       institution:'ESCT',             status:'active',   last_login:'1 day ago' },
    { id:'10',full_name:'Nour Ghorbel',    email:'n.ghorbel@issats.ucar.tn',role:'admin',       institution:'ISSATS',           status:'active',   last_login:'4 days ago' },
    { id:'11',full_name:'Slim Bayoudh',    email:'s.bayoudh@istmt.ucar.tn', role:'admin',       institution:'ISTMT',            status:'inactive', last_login:'1 month ago' },
    { id:'12',full_name:'Hedi Chaabane',   email:'h.chaabane@ipeit.ucar.tn',role:'admin',       institution:'IPEIT',            status:'active',   last_login:'2 days ago' },
  ];

  institutions = ['ISG Tunis','IPEIEM','ESCT','ISSATS','ISTMT','IPEIT','ISET Charguia','ISSAT Manouba'];

  constructor(private auth: AuthService, private http: HttpClient) {}

  ngOnInit(): void {
    this.role = this.auth.getRole();
  }

  get filteredUsers() {
    return this.users.filter(u => {
      const matchSearch = !this.searchTerm || u.full_name.toLowerCase().includes(this.searchTerm.toLowerCase()) || u.email.toLowerCase().includes(this.searchTerm.toLowerCase());
      const matchRole = !this.roleFilter || u.role === this.roleFilter;
      const matchInst = !this.instFilter || u.institution.includes(this.instFilter);
      return matchSearch && matchRole && matchInst;
    });
  }

  get counts() {
    return {
      superAdmins: this.users.filter(u => u.role === 'super_admin').length,
      agents:      this.users.filter(u => u.role === 'agent').length,
      admins:      this.users.filter(u => u.role === 'admin').length,
    };
  }

  openAddModal(): void { 
    this.editMode = false; 
    this.passwordVisible = false;
    this.modalForm = { full_name:'', email:'', role:'agent', institution:'', password:'', confirm_password:'' }; 
    this.showModal = true; 
  }
  openEditModal(u: any): void { this.editMode = true; this.modalForm = { ...u, password:'', confirm_password:'' }; this.showModal = true; }
  closeModal(): void { this.showModal = false; }

  generatePassword(): void {
    const chars = 'ABCDEFGHJKMNPQRSTUVWXYZabcdefghjkmnpqrstuvwxyz23456789!@#$%';
    const length = 12;
    let pwd = '';
    for (let i = 0; i < length; i++) {
      pwd += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    this.modalForm.password = pwd;
    this.passwordVisible = true;
  }

  saveUser(): void {
    if (!this.modalForm.full_name || !this.modalForm.email || !this.modalForm.password) return;
    this.isSaving = true;

    if (!this.editMode) {
      const token = this.auth.getToken();
      const headers = new HttpHeaders().set('Authorization', `Bearer ${token}`);
      const payload = {
        full_name: this.modalForm.full_name,
        email: this.modalForm.email,
        role: this.modalForm.role,
        institution: this.modalForm.institution,
        password: this.modalForm.password
      };

      this.http.post(`${environment.apiUrl}/users/create`, payload, { headers }).subscribe({
        next: () => {
          this.users.push({ id: String(this.users.length+1), ...this.modalForm, status:'active', last_login:'Just now' } as any);
          this.showModal = false;
          this.isSaving = false;
          this.showToast('User created & welcome email sent!');
        },
        error: (err) => {
          console.error('Failed to create user', err);
          this.isSaving = false;
          this.showToast('Failed to create user. Please try again.');
        }
      });
    } else {
      this.showModal = false;
      this.isSaving = false;
      this.showToast('User updated successfully');
    }
  }

  confirmDelete(u: any): void { this.deleteTarget = u; this.showDeleteModal = true; }
  cancelDelete(): void { this.showDeleteModal = false; this.deleteTarget = null; }
  deleteUser(): void {
    if (!this.deleteTarget) return;
    this.users = this.users.filter(u => u.id !== this.deleteTarget.id);
    this.showDeleteModal = false;
    this.showToast('User deleted');
  }

  resetPassword(): void { this.showToast('Password reset email sent'); }

  showToast(msg: string): void { this.toastMsg = msg; setTimeout(() => this.toastMsg = '', 3000); }

  roleBadge(role: string): string {
    if (role === 'super_admin') return 'badge-navy';
    if (role === 'agent') return 'badge-gold';
    return 'badge-success';
  }

  roleLabel(role: string): string {
    if (role === 'super_admin') return 'Super Admin';
    if (role === 'agent') return 'Agent';
    return 'Admin';
  }

  getInitials(name: string): string {
    return name.split(' ').map(w => w[0]).join('').substring(0, 2).toUpperCase();
  }
}
