import { Injectable } from '@angular/core';
import { Store } from '@ngrx/store';

@Injectable({
  providedIn: 'root'
})
export class TokenService {

  constructor(private store: Store<any>) { }

  GetToken(): string{
    let token: string;
    this.store.select('login').subscribe(
      l => token = l.token
    );
    return token;
  }  
  
}
