export type AlertSeverity = 'critical' | 'high' | 'medium' | 'low';

export interface Alert {
  id: string;
  institution_id: string;
  institution_name?: string;
  kpi_id: string;
  kpi_name?: string;
  domain?: string;
  title: string;
  message: string;
  severity: AlertSeverity;
  status: 'open' | 'resolved' | 'snoozed';
  current_value?: number;
  threshold?: string;
  duration_days?: number;
  created_at: string;
  resolved_by?: string;
  resolved_at?: string;
}
