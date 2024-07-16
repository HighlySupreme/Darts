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
    winner: string = '';
    newPlayerName: string = '';
    leaderboardData: LeaderboardEntry[] = [];
    displayedColumns: string[] = ['name', 'gamesPlayed', 'gamesWon', 'winPercentage'];
    player1: string = '';
    player2: string = '';
    player3: string = '';
    showFireworks: boolean = false;

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
        if (this.getSelectedPlayers().length > 0 && this.winner) {
            this.leaderboardService.submitGame(this.getSelectedPlayers(), this.winner).subscribe(
                response => {
                  console.log('Game submitted successfully:', response);
                  this.winner = '';
                  this.showFireworksAnimation();
                  // Reload leaderboard
                  this.loadLeaderboard();
                },
                error => console.error('Error submitting game:', error)
              );
        }
    }

    isPlayerSelected(player: string, currentDropdown: number): boolean {
        if (currentDropdown === 1) return false;
        if (currentDropdown === 2) return player === this.player1;
        if (currentDropdown === 3) return player === this.player1 || player === this.player2;
        return false;
    }

    getSelectedPlayers(): string[] {
        return [this.player1, this.player2, this.player3].filter(Boolean);
    }

    updatePlayerSelections(): void {
        this.winner = "";
    }

    canSelectWinner(): boolean {
        return this.getSelectedPlayers().length >= 2;
    }

    canAddResult(): boolean {
        const selectedPlayers = this.getSelectedPlayers();
        return selectedPlayers.length >= 2 && selectedPlayers.includes(this.winner);
    }

    showFireworksAnimation() {
        this.showFireworks = true;
        
        // Hide fireworks after 5 seconds
        setTimeout(() => {
          this.showFireworks = false;
        }, 5000);
      }
}