import { Component } from '@angular/core';

@Component({
  selector: 'mpm-root',
  template:
    `<div>
    <h1>{{pageTitle}}</h1>
    <mpm-products></mpm-products>
  </div>`
})
export class AppComponent {
  pageTitle = 'Mirzling Product Managment';
}
