import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AnalyticsService } from '../../../core/services/analytics.service';
import { DashboardService } from '../../../core/services/dashboard.service';
import { AuthService } from '../../../core/services/auth.service';

@Component({
  selector: 'app-esg-optimizer',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './esg-optimizer.component.html',
  styleUrl: './esg-optimizer.component.scss'
})
export class EsgOptimizerComponent implements OnInit {
  institutions: any[] = [];
  selectedInstitution = '';
  loading = false;
  optimizationResult: any = null;
  error: string | null = null;

  constructor(
    private analyticsService: AnalyticsService,
    private dashboardService: DashboardService,
    private auth: AuthService
  ) {}

  ngOnInit(): void {
    this.loadInstitutions();
  }

  loadInstitutions(): void {
    this.dashboardService.getInstitutions().subscribe({
      next: (data) => {
        this.institutions = data;
        if (this.institutions.length > 0) {
          this.selectedInstitution = this.institutions[0].id;
        }
      },
      error: (err) => console.error('Failed to load institutions', err)
    });
  }

  runOptimization(): void {
    if (!this.selectedInstitution) return;

    this.loading = true;
    this.optimizationResult = null;
    this.error = null;

    this.analyticsService.getEsgOptimization(this.selectedInstitution).subscribe({
      next: (data) => {
        this.optimizationResult = {
          ...data,
          parsed: this.parseRoadmap(data.sustainability_roadmap)
        };
        this.loading = false;
      },
      error: (err) => {
        this.error = 'Failed to run ESG optimization. Please ensure the backend is running and API key is configured.';
        this.loading = false;
        console.error('Optimization error', err);
      }
    });
  }

  parseRoadmap(raw: string): any {
    const sections: any = {
      leak: { content: '' },
      steps: []
    };

    // 1. Extract Leak section - look for "1. Biggest Carbon/Energy Leak" or "1. Identify the biggest"
    const leakMatch = raw.match(/(?:###\s+)?(?:\*\*)?1\.\s+(?:Biggest Carbon\/Energy Leak|Identify the biggest.*?)(?:\*\*)?([\s\S]*?)(?=---|###\s+2|####\s+Step|$)/i);
    if (leakMatch) {
      sections.leak.content = leakMatch[1].trim()
        .replace(/^[\*\s\-\:]+/, '')
        .replace(/^(?:Identification|Analysis)\s*[\*\:]+\s*/i, '')
        .trim();
    } else {
      // Very broad fallback for first section
      const firstSection = raw.split(/---|###\s+2/i)[0];
      sections.leak.content = firstSection.replace(/###.*?Report.*?Analysis/i, '').trim();
    }

    // 2. Extract Steps - look for "Step X:" or similar
    const stepRegex = /(?:####\s+)?(?:\*\*)?Step\s+(\d+)\s*[:\-]\s*(.*?)(?:\*\*)?([\s\S]*?)(?=####\s+Step|---|###\s+3|$)/gis;
    let match;
    while ((match = stepRegex.exec(raw)) !== null) {
      const stepNum = match[1];
      const stepTitle = match[2].trim().replace(/\*\*/g, '');
      const stepContent = match[3].trim();
      
      // Sub-parsing for Action, Implementation, Goal (Optional, if they exist)
      const action = stepContent.match(/(?:\-\s+)?\*\*Action:\*\*(.*?)(?=\*\*|$)/is)?.[1]?.trim().replace(/^[\s\-]+/, '') || '';
      const implementation = stepContent.match(/(?:\-\s+)?\*\*Implementation:\*\*(.*?)(?=\*\*|$)/is)?.[1]?.trim().replace(/^[\s\-]+/, '') || '';
      const goal = stepContent.match(/(?:\-\s+)?\*\*Goal:\*\*(.*?)(?=\*\*|$)/is)?.[1]?.trim().replace(/^[\s\-]+/, '') || '';

      sections.steps.push({
        num: stepNum,
        title: stepTitle,
        action: action,
        implementation: implementation,
        goal: goal,
        // If sub-parsing failed to find everything, keep the original text as fallback
        rawContent: stepContent.replace(/^[\s\-]+/, '')
      });
    }

    // If we didn't find any steps with the regex, try a simpler split
    if (sections.steps.length === 0) {
       const parts = raw.split(/####\s+Step\s+\d+/i);
       if (parts.length > 1) {
         parts.slice(1).forEach((p, i) => {
           sections.steps.push({ num: i + 1, title: 'Recommended Action', rawContent: p.trim() });
         });
       } else {
         sections.isRaw = true;
       }
    }

    return sections;
  }
}
