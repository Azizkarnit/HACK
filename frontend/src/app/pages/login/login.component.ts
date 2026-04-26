import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../core/services/auth.service';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent {
  email = '';
  password = '';
  showPassword = false;
  loading = false;
  errorMsg = '';

  constructor(private auth: AuthService, private router: Router) {}

  onSubmit(): void {
    if (!this.email || !this.password) {
      this.errorMsg = 'Please enter your email and password.';
      return;
    }
    this.loading = true;
    this.errorMsg = '';

    // Try real API first, fall back to demo
    this.auth.login(this.email, this.password).subscribe({
      next: (res) => {
        this.loading = false;
        this.navigateByRole();
      },
      error: (err) => {
        this.loading = false;
        // Display actual error from backend if available, otherwise generic
        this.errorMsg = err.error?.detail || 'Invalid email or password. Please try again.';
      }
    });
  }

  private navigateByRole(): void {
    const role = this.auth.getRole();
    if (role === 'admin') this.router.navigate(['/institution']);
    else this.router.navigate(['/dashboard']);
  }

  togglePassword(): void { this.showPassword = !this.showPassword; }
}
