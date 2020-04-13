import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { AppSettings } from '../../core/constants';
import { Store } from '@ngrx/store';
import { Observable } from 'rxjs';
import { IEmpresas } from 'src/app/Interfaces/empresasInterface';

@Injectable({
  providedIn: 'root'
})
export class EmpresasService {
  constructor(
    private httpClient: HttpClient,
    private store: Store<any>
    ) { }
  
  private getToken(): string{
    let token: string;
    this.store.select('login').subscribe(
      l => token = l.token
    );
    console.log(token);
    return token;
  }  
  GetEmpresas(): Observable<IEmpresas>{
    return this.httpClient.get<IEmpresas>(AppSettings.BASE_ADDRESS + 'empresas' + '?token=' + this.getToken());
  }
}
