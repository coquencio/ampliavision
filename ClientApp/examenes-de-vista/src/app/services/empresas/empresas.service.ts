import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { AppSettings } from '../../core/constants';
import { Store } from '@ngrx/store';
import { Observable } from 'rxjs';
import { IEmpresas } from 'src/app/Interfaces/empresasInterface';
import { TokenService } from '../token/token.service';

@Injectable({
  providedIn: 'root'
})
export class EmpresasService {
  constructor(
    private httpClient: HttpClient,
    private store: Store<any>,
    private tokenService: TokenService
    ) { }

  GetEmpresas(): Observable<IEmpresas>{
    return this.httpClient.get<IEmpresas>(AppSettings.BASE_ADDRESS + 'empresas' + '?token=' + this.tokenService.GetToken());
  }
}
