import { Injectable } from '@angular/core';
import { TipoVenta } from 'src/app/core/enums/tipoExamen';
import { IOption } from 'src/app/Interfaces/optionsInterface';
import { HttpHeaders, HttpClient } from '@angular/common/http';
import { AppSettings } from 'src/app/core/constants';
import { TokenService } from '../token/token.service';
import { IVentaResponse } from 'src/app/Interfaces/ventaResponseInterface';
import { Observable } from 'rxjs';
import { IResumenVentas } from 'src/app/Interfaces/resumenVentasInterface';
import { IAbono } from 'src/app/Interfaces/abonosInterface';
import { IArmazonResponse } from 'src/app/Interfaces/armazonResponseInterface';
import { IVentasResumen } from 'src/app/Interfaces/salesSummaryInterface';

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

  GetSalesByEmpresa(empresaId: number): Observable<IResumenVentas>{
    const url = AppSettings.BASE_ADDRESS + 'empresas/'+empresaId+'/ventas?token=' + this.tokenService.GetToken();
    return this.httpClient.get<IResumenVentas>(url);
  }

  PaymentRegistration(ventaId: number, monto: number, fecha:string){
    const payment = {
      Monto: monto,
      FechaAbono: fecha
    };
    const headers = new HttpHeaders().set('Content-Type', 'application/json; charset=utf-8');
    const url = AppSettings.BASE_ADDRESS + 'ventas/'+ventaId+'/abonos?token=' + this.tokenService.GetToken();
    return this.httpClient.post(url, payment, {headers, responseType:'text'});
  }

  GetPaymentsBySale(ventaId: number): Observable<IAbono[]>{
    const url = AppSettings.BASE_ADDRESS + 'ventas/'+ventaId+'/abonos?token=' + this.tokenService.GetToken();
    return this.httpClient.get<IAbono[]>(url);
  }

  DeletePament(abonoId: number){
    const headers = new HttpHeaders().set('Content-Type', 'application/json; charset=utf-8');
    const url = AppSettings.BASE_ADDRESS + 'abono/'+abonoId+'?token=' + this.tokenService.GetToken();
    return this.httpClient.delete(url, {headers, responseType:'text'});
  }

  MarkAsPaid(ventaId: number, paying = true){
    const paid = paying? 1: 0;
    const headers = new HttpHeaders().set('Content-Type', 'application/json; charset=utf-8');
    const url = AppSettings.BASE_ADDRESS + 'ventas/'+ventaId+'/paid/'+paid+'?token=' + this.tokenService.GetToken();
    return this.httpClient.post(url, {}, {headers, responseType:'text'});
  }

  DeleteSale(ventaId: number){
    const headers = new HttpHeaders().set('Content-Type', 'application/json; charset=utf-8');
    const url = AppSettings.BASE_ADDRESS + 'ventas/'+ventaId+'?token=' + this.tokenService.GetToken();
    return this.httpClient.delete(url, {headers, responseType:'text'});
  }

  ArmazonDetails(ventaId: number): Observable<IArmazonResponse>{
    const url = AppSettings.BASE_ADDRESS + 'ventas/'+ventaId+'/armazon?token=' + this.tokenService.GetToken();
    return this.httpClient.get<IArmazonResponse>(url);
  }

  GetBalanceSummary(empresaId): Observable<IVentasResumen>{
    const url = AppSettings.BASE_ADDRESS + 'empresas/'+empresaId+'/ventas/resumen?token=' + this.tokenService.GetToken();
    return this.httpClient.get<IVentasResumen>(url);
  }
}
