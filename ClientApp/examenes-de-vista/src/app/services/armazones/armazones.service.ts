import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { TokenService } from '../token/token.service';
import { AppSettings } from 'src/app/core/constants';
import { IArmazonResponse } from 'src/app/Interfaces/armazonInterface';

@Injectable({
  providedIn: 'root'
})
export class ArmazonesService {

  constructor(
    private httpClient: HttpClient,
    private tokenService: TokenService
  ) { }

  async registerAndGetAsync(armazon: {}): Promise<IArmazonResponse>{
  const headers = new HttpHeaders().set('Content-Type', 'application/json; charset=utf-8');
    const url = AppSettings.BASE_ADDRESS + 'armazones?token=' + this.tokenService.GetToken();
    return await this.httpClient.post<IArmazonResponse>(url, armazon, { headers, responseType: 'json' }).toPromise();
  }
}
