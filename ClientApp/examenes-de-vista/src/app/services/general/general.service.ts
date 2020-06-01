import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
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
}