import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { TokenService } from '../token/token.service';
import { AppSettings } from 'src/app/core/constants';
import { IVentasChart, IGeneralChart } from 'src/app/Interfaces/chartsInterface';
import { Observable } from 'rxjs';
import { chartType } from 'src/app/core/enums/chartType';

@Injectable({
  providedIn: 'root'
})
export class ChartsService {

  constructor(
    private httpClient: HttpClient,
    private tokenService: TokenService
  ) { }

  GetSalesChart(empresaId: number):Observable <IVentasChart[]>{
    const url = AppSettings.BASE_ADDRESS + 'empresas/' + empresaId + '/grafico/ventas?token=' + this.tokenService.GetToken();
    return this.httpClient.get<IVentasChart[]>(url);
  }
  GetGeneralChart(empresaId: number, criteria : chartType):Observable <IGeneralChart[]>{
    const url = AppSettings.BASE_ADDRESS + 'empresas/' + empresaId + '/grafico/'+ criteria +'?token=' + this.tokenService.GetToken();
    return this.httpClient.get<IGeneralChart[]>(url);
  }
 
}
