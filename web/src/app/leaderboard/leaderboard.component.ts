import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { MatSelectModule } from '@angular/material/select';
import { MatButtonModule } from '@angular/material/button';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatTableModule } from '@angular/material/table';
import { LeaderboardService } from '../leaderboard.service';

interface LeaderboardEntry {
  name: string;
  gamesPlayed: number;
  gamesWon: number;
  winPercentage: number;
}

@Component({
  selector: 'app-leaderboard',
  standalone: true,
  imports: [
    CommonModule, 
    FormsModule, 
    MatSelectModule, 
    MatButtonModule, 
    MatFormFieldModule, 
    MatInputModule,
    MatTableModule
  ],
  templateUrl: './leaderboard.component.html',
  styleUrls: ['./leaderboard.component.scss']
})
export class LeaderboardComponent implements OnInit {
  players: any[] = [];
  selectedPlayers: string[] = [];
  winner: string = '';
  newPlayerName: string = '';
  leaderboardData: LeaderboardEntry[] = [];
  displayedColumns: string[] = ['name', 'gamesPlayed', 'gamesWon', 'winPercentage'];

  constructor(private leaderboardService: LeaderboardService) { }

  ngOnInit(): void {
    this.loadPlayers();
    this.loadLeaderboard();
  }

  loadPlayers(): void {
    this.leaderboardService.getPlayers().subscribe(
      (data: any[]) => {
        this.players = data;
      },
      error => console.error('Error loading players:', error)
    );
  }

  loadLeaderboard(): void {
    this.leaderboardService.getLeaderboard().subscribe(
      (data: LeaderboardEntry[]) => {
        this.leaderboardData = data.map(entry => ({
          ...entry,
          winPercentage: (entry.gamesWon / entry.gamesPlayed) * 100 || 0
        }));
      },
      error => console.error('Error loading leaderboard:', error)
    );
  }

  submitGame(): void {
    if (this.selectedPlayers.length > 0 && this.winner) {
      // Here you would typically call an API to submit the game result
      console.log('Submitting game:', { players: this.selectedPlayers, winner: this.winner });
      this.selectedPlayers = [];
      this.winner = '';
      this.loadLeaderboard(); // Reload the leaderboard after submitting a game
    }
  }
}