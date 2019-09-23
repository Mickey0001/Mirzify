import { Component } from '@angular/core';

@Component({
  selector: 'burek-root',
  template: `
    <nav class='navbar navbar-expand navbar-dark bg-dark'>
        <a class='navbar-brand'>
          <img style="max-width:50px; margin-top: -5px;"
          src="assets/images/logo.png">
        </a>
        <ul class='nav nav-pills btn-secondary'>
          <li><a class='nav-link' routerLinkActive='active' [routerLink]="['/welcome']">BurekHome</a></li>
          <li><a class='nav-link' routerLinkActive='active' [routerLink]="['/products']">Burek List</a></li>
        </ul>
    </nav>
    
    <div class='container'>
      <router-outlet></router-outlet>
    </div>
    `,
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  pageTitle = 'FindBurek';
}
