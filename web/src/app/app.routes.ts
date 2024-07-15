import { Routes } from '@angular/router';
import { LeaderboardComponent } from './leaderboard/leaderboard.component';

export const routes: Routes = [
    { path: 'leaderboard', component: LeaderboardComponent },
    { path: '', redirectTo: 'leaderboard', pathMatch: 'full' },
    { path: '**', redirectTo: 'leaderboard' }
];
