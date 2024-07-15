import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { LeaderboardComponent } from './leaderboard/leaderboard.component';

@Component({
    selector: 'app-root',
    standalone: true,
    imports: [RouterOutlet, LeaderboardComponent],
    template: '<router-outlet></router-outlet>'
})
export class AppComponent { }