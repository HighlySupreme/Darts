import { bootstrapApplication } from '@angular/platform-browser';
import { appConfig } from './app/app.config';
import { AppComponent } from './app/app.component';
import { importProvidersFrom } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { MatSelectModule } from '@angular/material/select';
import { MatButtonModule } from '@angular/material/button';
import { MatFormFieldModule } from '@angular/material/form-field';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';


bootstrapApplication(AppComponent, {
    ...appConfig,
    providers: [
        ...appConfig.providers,
        importProvidersFrom(
            FormsModule,
            MatSelectModule,
            MatButtonModule,
            MatFormFieldModule,
            BrowserAnimationsModule
        )
    ]
})
    .catch((err) => console.error(err));
