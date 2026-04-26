export interface Institution {
  id: string;
  name: string;
  name_ar?: string;
  abbreviation: string;
  city: string;
  type: string;
  address?: string;
  director_name?: string;
  email?: string;
  phone?: string;
  status: 'active' | 'inactive';
  health_score?: number;
  open_alerts?: number;
  student_count?: number;
}

export interface InstitutionHealth {
  institution_id: string;
  institution_name: string;
  academic: 'Good' | 'Warning' | 'Critical';
  finance: 'Good' | 'Warning' | 'Critical';
  hr: 'Good' | 'Warning' | 'Critical';
  esg: 'Good' | 'Warning' | 'Critical';
  alerts: number;
  score: number;
}
