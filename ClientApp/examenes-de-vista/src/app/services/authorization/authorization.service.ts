import { Injectable } from '@angular/core';
import { Store } from '@ngrx/store';

@Injectable({
  providedIn: 'root'
})
export class AuthorizationService {

  constructor(private store: Store<any>) { }

  IsLogged(): boolean{
    let isLogged: boolean;
    isLogged = false;
    if (localStorage.getItem('token') !== null){
      if (localStorage.getItem('token') !== ''){
        this.store.dispatch({
          type: 'SET_TOKEN',
          payload: localStorage.getItem('token')
        });
        isLogged = true;
      }
    }
    else{
      this.store.select('login').subscribe(
        l => {
          if (l){
            if (l.token){
              if (l.token !== ''){
                localStorage.setItem('token', l.token);
                isLogged = true;
              }
            }
          }
        }
      );
    }
    return isLogged;
  }
}
