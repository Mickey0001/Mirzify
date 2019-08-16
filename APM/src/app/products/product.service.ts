import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

import { IProduct } from './product';

@Injectable({
  providedIn: 'root'
})


export class ProductsService {
  private productURL = 'api/products/products.json';

  constructor(private http: HttpClient) {}

    getProducts(): Observable<IProduct> {
        return this.http.get<IProduct>(this.productURL);
    }
}
