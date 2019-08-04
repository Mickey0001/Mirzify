import {Component} from '@angular/core';

@Component({
  selector: 'pm-root',
  template: 
  `<div>
    <h1>{{pageTitle}}</h1>
    <h3>Le first component</h3>
  </div>`
})
export class AppComponent {
  pageTitle: string = 'Mirzling Product Managment';
}