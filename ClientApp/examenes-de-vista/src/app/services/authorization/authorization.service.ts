import { Injectable } from '@angular/core';
import { Store } from '@ngrx/store';
import { Router } from '@angular/router';
import { tokenName } from '@angular/compiler';

@Injectable({
  providedIn: 'root'
})
export class AuthorizationService {

  constructor(private store: Store<any>, private router: Router) { }
  authorize():void{
    var toReturn:Boolean;
    toReturn = false;
    this.store.select('login').subscribe(
        l => {
          if(l){
            if(l.token){
              if(l.token!=''){
                toReturn = true;
              }
            }
          }
        }
      );
      if (!toReturn){
        this.router.navigate(['/Login'])
      }
      else{
        
        this.router.navigate(['/Inicio'])
      }
  }
}
