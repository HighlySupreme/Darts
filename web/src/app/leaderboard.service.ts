import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class LeaderboardService {
  private apiUrl = 'http://localhost:4000/api';

  constructor(private http: HttpClient) { }

  getPlayers(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/players`);
  }

  getHistory(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/history`);
  }

  getLeaderboard(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/history/leaderboard`);
  }

  submitGame(players: string[], winner: string): Observable<any> {
    return this.http.post(`${this.apiUrl}/submit_game`, { players, winner });
  }
}