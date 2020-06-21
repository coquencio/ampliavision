import { Injectable } from '@angular/core';
import { TipoVenta } from 'src/app/core/enums/tipoExamen';
import { IOption } from 'src/app/Interfaces/optionsInterface';
import { HttpHeaders, HttpClient } from '@angular/common/http';
import { AppSettings } from 'src/app/core/constants';
import { TokenService } from '../token/token.service';
import { IVentaResponse } from 'src/app/Interfaces/ventaResponseInterface';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class SalesService {

  constructor(private httpClient: HttpClient,
    private tokenService: TokenService) { }

  PopulateTipoVentaList(): IOption[]{
    let index = 0;
    let value = 1;
    let list: any[] = [];
    for (let tipo in TipoVenta){
      if (index  + 1> Object.keys(TipoVenta).length / 2){
        const item = {label: Object.keys(TipoVenta)[index], value:value};
        list.push(item);
        value ++;
      }
      index ++;
    }
    return list;
  }

  CreateAndGetSale(sale: {}): Observable<IVentaResponse>{
  const headers = new HttpHeaders().set('Content-Type', 'application/json; charset=utf-8');
    const url = AppSettings.BASE_ADDRESS + 'venta?token=' + this.tokenService.GetToken();
    return this.httpClient.post<IVentaResponse>(url, sale, { headers, responseType: 'json' });
  }
}
