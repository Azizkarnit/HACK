export type UserRole = 'super_admin' | 'agent' | 'admin';

export interface User {
  id: string;
  full_name: string;
  email: string;
  role: UserRole;
  institution_id?: string;
  institution_name?: string;
  status: 'active' | 'inactive';
  last_login?: string;
}

export interface AuthResponse {
  access_token: string;
  token_type: string;
  user: User;
}
