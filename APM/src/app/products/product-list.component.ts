import { Component } from '@angular/core';

@Component({
    // tslint:disable-next-line: component-selector
    selector: 'mpm-products',
    templateUrl: './products-list.component.html'
})

export class ProductListComponent {
    pageTitle: string = 'Product list test';
}