import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../core/services/auth.service';

@Component({
  selector: 'app-data-ingestion',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './data-ingestion.component.html',
  styleUrls: ['./data-ingestion.component.scss']
})
export class DataIngestionComponent implements OnInit {
  role: string | null = null;
  isDragOver = false;
  selectedFile: File | null = null;
  selectedInst = '';
  selectedCategory = '';
  processing = false;
  activeResultTab = 'raw';
  toastMsg = '';

  pipelineSteps = [
    { label: '1. File Upload',        status: 'pending' },
    { label: '2. OCR Text Extraction',status: 'pending' },
    { label: '3. AI Data Parsing',    status: 'pending' },
    { label: '4. Data Validation',    status: 'pending' },
    { label: '5. Saved to Database',  status: 'pending' },
  ];

  history = [
    { file:'students_Q1.pdf',      institution:'ISG Tunis', category:'Student Records', date:'15 Apr 2025', records:342, status:'completed' },
    { file:'budget_march.xlsx',    institution:'ESCT',      category:'Financial Data',  date:'10 Apr 2025', records:89,  status:'completed' },
    { file:'hr_data.pdf',          institution:'IPEIEM',    category:'HR Data',         date:'08 Apr 2025', records:0,   status:'failed' },
    { file:'esg_report.pdf',       institution:'ISSAT',     category:'ESG Metrics',     date:'05 Apr 2025', records:156, status:'completed' },
    { file:'research_output.xlsx', institution:'IPEIT',     category:'Research Data',   date:'02 Apr 2025', records:34,  status:'processing' },
  ];

  categories = ['Student Records','HR Data','Financial Data','ESG Metrics','Research Data','Infrastructure Data','General Document'];
  institutions = ['ISET Charguia','ESCT','ISG Tunis','IPEIT','IPEIEM','ISSATS','ISSAT Manouba','ISTMT'];

  constructor(private auth: AuthService) {}

  ngOnInit(): void {
    this.role = this.auth.getRole();
    if (this.role === 'admin') {
      this.selectedInst = this.auth.getInstitutionName();
    }
  }

  onDragOver(e: DragEvent): void { e.preventDefault(); this.isDragOver = true; }
  onDragLeave(): void { this.isDragOver = false; }
  onDrop(e: DragEvent): void {
    e.preventDefault(); this.isDragOver = false;
    const files = e.dataTransfer?.files;
    if (files && files.length > 0) this.selectedFile = files[0];
  }

  onFileSelect(e: Event): void {
    const input = e.target as HTMLInputElement;
    if (input.files && input.files.length > 0) this.selectedFile = input.files[0];
  }

  removeFile(): void { this.selectedFile = null; }

  getFileSizeKB(): string {
    return this.selectedFile ? `${Math.round(this.selectedFile.size / 1024)} KB` : '';
  }

  extract(): void {
    if (!this.selectedFile) return;
    this.processing = true;
    this.pipelineSteps.forEach(s => s.status = 'pending');
    let step = 0;
    const advance = () => {
      if (step < this.pipelineSteps.length) {
        this.pipelineSteps[step].status = 'active';
        setTimeout(() => {
          this.pipelineSteps[step].status = 'complete';
          step++;
          setTimeout(advance, 800);
        }, 1000);
      } else {
        this.history.unshift({ file: this.selectedFile!.name, institution: this.selectedInst, category: this.selectedCategory, date: new Date().toLocaleDateString(), records: 342, status: 'completed' });
        this.showToast('File processed and saved successfully');
      }
    };
    advance();
  }

  showToast(msg: string): void { this.toastMsg = msg; setTimeout(() => this.toastMsg = '', 3000); }
  statusClass(s: string): string { return s === 'completed' ? 'badge-success' : s === 'failed' ? 'badge-critical' : s === 'processing' ? 'badge-gold' : 'badge-navy'; }
}
