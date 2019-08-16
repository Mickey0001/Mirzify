import { Component, OnInit } from '@angular/core';
import { IProduct } from './product';
import { ProductsService } from './product.service';

@Component({
  // tslint:disable-next-line: component-selector
  selector: 'mpm-products',
  templateUrl: './products-list.component.html',
  styleUrls: ['./product-list.component.css']
})

export class ProductListComponent implements OnInit {
  pageTitle = 'Product list test';
  imageWidth = 50;
  imageMargin = 2;
  showImage = false;
  errorMessage: string;

  _listFilter: string;
  get listFilter(): string {
    return this._listFilter;
  }

  set listFilter(value: string) {
    this._listFilter = value;
    this.filteredProducts = this.listFilter ? this.preformFilter(this.listFilter) : this.products;
  }

  filteredProducts: IProduct[];
  products: IProduct[] = [];

  constructor(private productService: ProductsService) {
  }

  onRatingClicked(message: string): void {
    this.pageTitle = 'Product List ' + message;
  }

  preformFilter(filterBy: string): IProduct[] {
    filterBy = filterBy.toLocaleLowerCase();
    return this.products.filter((product: IProduct) =>
      product.productName.toLocaleLowerCase().indexOf(filterBy) !== -1);
  }

  toggleImage(): void {
    this.showImage = !this.showImage;
  }

  ngOnInit(): void {
    this.productService.getProducts().subscribe({
      next: products => {
        this.products = this.products,
        this.filteredProducts = this.products;
      },
      error: err => this.errorMessage = err
    });
  }
}
