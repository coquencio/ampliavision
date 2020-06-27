import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
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
    private tokenService: TokenService
    ) { }
  GetEmpresas(): Observable<IEmpresas>{
    return this.httpClient.get<IEmpresas>(AppSettings.BASE_ADDRESS + 'empresas' + '?token=' + this.tokenService.GetToken());
  }
  Create(empresa: {}): Observable<any>{
    const headers = new HttpHeaders().set('Content-Type', 'application/json; charset=utf-8');
    return this.httpClient.post(AppSettings.BASE_ADDRESS + 'empresas/create' + '?token=' + this.tokenService.GetToken(),empresa,{headers, responseType:'text'});
  }

  GetIdByFolio(folio: string):Observable<IEmpresaIdResponse>{
    const url = AppSettings.BASE_ADDRESS + 'empresas/folio/'+ folio + '?token=' + this.tokenService.GetToken();
    return this.httpClient.get<IEmpresaIdResponse>(url);
  }
  GetIdBySale(ventaId: number):Observable<IEmpresaIdResponse>{
    const url = AppSettings.BASE_ADDRESS + 'empresas/ventas/'+ ventaId + '?token=' + this.tokenService.GetToken();
    return this.httpClient.get<IEmpresaIdResponse>(url);
  }
}

interface IEmpresaIdResponse{
  EmpresaID: number;
}
