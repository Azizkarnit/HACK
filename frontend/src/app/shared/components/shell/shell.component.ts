import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterOutlet, RouterModule } from '@angular/router';
import { SidebarComponent } from '../sidebar/sidebar.component';
import { HeaderComponent } from '../header/header.component';
import { Router, NavigationEnd } from '@angular/router';
import { filter } from 'rxjs/operators';

const TITLES: Record<string, string> = {
  '/dashboard':             'Global Dashboard',
  '/institution':           'Institution Dashboard',
  '/kpis':                  'KPI Manager',
  '/analytics/anomalies':   'Anomaly Detection',
  '/analytics/predictions': 'KPI Predictions',
  '/analytics/what-if':     'What-If Simulator',
  '/analytics/esg-optimizer': 'ESG Optimizer',
  '/ai-assistant':          'AI Assistant',
  '/reports':               'Reports',
  '/data-ingestion':        'Data Upload & Extraction',
  '/alerts':                'Alerts Center',
  '/user-management':       'User Management',
  '/institutions':          'Institutions',
};

@Component({
  selector: 'app-shell',
  standalone: true,
  imports: [CommonModule, RouterOutlet, RouterModule, SidebarComponent, HeaderComponent],
  template: `
    <app-sidebar></app-sidebar>
    <div class="main-area">
      <app-header [pageTitle]="pageTitle"></app-header>
      <main class="main-content">
        <router-outlet></router-outlet>
      </main>
    </div>
  `,
  styles: [`
    .main-area {
      margin-left: 260px;
      min-height: 100vh;
    }
    .main-content {
      margin-top: 64px;
      min-height: calc(100vh - 64px);
      background: var(--gray-50);
    }
  `]
})
export class ShellComponent implements OnInit {
  pageTitle = 'Dashboard';

  constructor(private router: Router) {}

  ngOnInit(): void {
    this.updateTitle(this.router.url);
    this.router.events.pipe(filter(e => e instanceof NavigationEnd)).subscribe((e: any) => {
      this.updateTitle(e.urlAfterRedirects);
    });
  }

  private updateTitle(url: string): void {
    const match = Object.keys(TITLES).find(k => url.startsWith(k));
    this.pageTitle = match ? TITLES[match] : 'UniGov';
  }
}
