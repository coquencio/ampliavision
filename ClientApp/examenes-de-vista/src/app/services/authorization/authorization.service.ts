import { Injectable } from '@angular/core';
import { Store } from '@ngrx/store';
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class AuthorizationService {

  constructor(private store: Store<any>, private router: Router) { }

  authorize(): void{
    let isLogged: boolean;
    isLogged = false;
    if (localStorage.getItem('token') !== null){
      if (localStorage.getItem('token') !== ''){
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
    if (!isLogged){
      if (this.router.url !== '/Login'){
        this.router.navigate(['/Login']);
      }
    }
    else{
      if (this.router.url === '/Login'){
        this.router.navigate(['/Inicio']);
      }
    }
  }
}
