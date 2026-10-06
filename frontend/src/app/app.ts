import { HttpClient } from '@angular/common/http';
import { Component, inject, signal } from '@angular/core';

interface HealthResponse {
  status: string;
  app: string;
}

@Component({
  selector: 'app-root',
  standalone: true,
  templateUrl: './app.html',
  styleUrl: './app.scss',
})
export class App {
  private readonly http = inject(HttpClient);

  readonly apiStatus = signal('Not checked yet');

  checkBackend(): void {
    this.apiStatus.set('Checking...');

    this.http.get<HealthResponse>('/api/health').subscribe({
      next: (response) => {
        this.apiStatus.set(`${response.app}: ${response.status}`);
      },
      error: () => {
        this.apiStatus.set('Backend unreachable');
      },
    });
  }
}
