import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError, tap} from 'rxjs/operators';

import { IProduct } from './product';

@Injectable({
  providedIn: 'root'
})

export class ProductsService {
  private productURL = 'api/products/products.json';

  constructor(private http: HttpClient) {}

    getProducts(): Observable<IProduct> {
        return this.http.get<IProduct>(this.productURL).pipe(
          tap(data => console.log('All: ' + JSON.stringify(data))),
          catchError(this.handleError)
        );
    }

    private handleError(err: HttpErrorResponse) {
      let errorMessage = '';
      if ( err.error instanceof ErrorEvent) {
        errorMessage = `Le error has occured: ${err.error.message}`;
      } else {
        errorMessage = `Server returned code: ${err.status}, error message is: ${err.message}`;
      }
      console.error(errorMessage);
      return throwError(errorMessage);
    }
}
