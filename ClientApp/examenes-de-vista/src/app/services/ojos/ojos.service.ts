import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { TokenService } from '../token/token.service';
import { AppSettings } from 'src/app/core/constants';
import { Observable } from 'rxjs';

interface singleEyeResponse{
  OjoID: Number;
}
interface conjuntoResponse{
  ConjuntoID: Number;
}

@Injectable({
  providedIn: 'root'
})
export class OjosService {

  constructor(
    private httpclient: HttpClient,
    private tokenService: TokenService
  ) { }

 
  async AddSingleEyeAsync(ojo:{}, lado: string): Promise<singleEyeResponse>{
    const headers = new HttpHeaders().set('Content-Type', 'application/json; charset=utf-8');
    const url = AppSettings.BASE_ADDRESS + 'empresas/beneficiarios/ojos/'+ lado +'?token=' + this.tokenService.GetToken();
    return await this.httpclient.post<singleEyeResponse>(url, ojo,  {headers, responseType: 'json'}).toPromise();
  }
  async AddPairAsync(IzquierdoId: Number, DerechoId: Number, DpLejos: Number, Obl: Number, tipo: string): Promise<conjuntoResponse>{
    const headers = new HttpHeaders().set('Content-Type', 'application/json; charset=utf-8');
    const url = AppSettings.BASE_ADDRESS + 'empresas/beneficiarios/ojos/conjunto/'+ tipo+'?token=' + this.tokenService.GetToken();
    return await this.httpclient.post<conjuntoResponse>(url, {IzquierdoId, DerechoId, DpLejos, Obl},  {headers, responseType: 'json'}).toPromise();
  }
}
