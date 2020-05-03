import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { TokenService } from '../token/token.service';
import { AppSettings } from 'src/app/core/constants';
import { Observable } from 'rxjs';
import { IBeneficiarios } from 'src/app/Interfaces/beneficiariosInterface';

@Injectable({
  providedIn: 'root'
})
export class BeneficiarioService {

  constructor(
    private httpClient: HttpClient,
    private tokenService: TokenService
  ) { }

  GetByEmpresa(empresaId: number): Observable<IBeneficiarios>{
  const url = 'empresas/'+ empresaId +'/beneficiarios?token=' + this.tokenService.GetToken();
    return this.httpClient.get<IBeneficiarios>(AppSettings.BASE_ADDRESS + url);
  }

  Create(empresaId: number, Beneficiario: {}): Observable<any>{
    const headers = new HttpHeaders().set('Content-Type', 'application/json; charset=utf-8');
    const url = 'empresas/'+ empresaId +'/beneficiarios/create?token=' + this.tokenService.GetToken();
    return this.httpClient.post(AppSettings.BASE_ADDRESS + url, Beneficiario, {headers, responseType: 'text'});
  }
}
