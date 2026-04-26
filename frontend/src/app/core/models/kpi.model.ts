export type KpiSeverity = 'good' | 'warning' | 'critical';
export type KpiDomain = 'Academic' | 'Finance' | 'HR' | 'ESG' | 'Research' | 'Infrastructure' | 'Partnerships';

export interface KpiDefinition {
  id: string;
  code: string;
  name: string;
  domain: KpiDomain;
  unit: string;
  target?: number;
  lower_threshold?: number;
  upper_threshold?: number;
}

export interface KpiValue {
  id: string;
  kpi_id: string;
  kpi_name?: string;
  institution_id: string;
  institution_name?: string;
  value: number;
  period_date: string;
  domain?: KpiDomain;
  severity?: KpiSeverity;
}

export interface AiInsight {
  id?: string;
  institution_id: string;
  kpi_id: string;
  type: 'anomaly' | 'prediction' | 'recommendation';
  title: string;
  description: string;
  value?: number;
  confidence: number;
  created_at?: string;
}
