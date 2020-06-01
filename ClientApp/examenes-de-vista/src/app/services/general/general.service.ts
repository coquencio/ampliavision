import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { TokenService } from '../token/token.service';
import { Observable } from 'rxjs';
import { AppSettings } from 'src/app/core/constants';

@Injectable({
  providedIn: 'root'
})
export class GeneralService {

  constructor(
    private httpclient: HttpClient,
    private tokenService: TokenService,
  ) { }
  Get (entity:string): Observable<any>{
    return this.httpclient.get<any>(AppSettings.BASE_ADDRESS + entity + '?token=' + this.tokenService.GetToken());    
  }
  Create(entity: string, description: string): Observable<any>{
    const headers = new HttpHeaders().set('Content-Type', 'application/json; charset=utf-8');
    return this.httpclient.post(AppSettings.BASE_ADDRESS + entity + '/create/' + description + '?token=' + this.tokenService.GetToken(),{},{headers: headers, responseType:'text'});
  }
}