import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Store } from '@ngrx/store';
import { getMaxListeners } from 'process';
import { Observable } from 'rxjs';
import { AppSettings } from 'src/app/core/constants';
import { TokenService } from '../token/token.service';

@Injectable({
  providedIn: 'root'
})
export class MailService {

  constructor(
    private httpclient: HttpClient,
    private tokenService: TokenService
    ) {
   }
   
   GetMails(): Observable<IMailResponse>{
      const url = AppSettings.BASE_ADDRESS + 'mail?token=' + this.tokenService.GetToken();
      return this.httpclient.get<IMailResponse>(url);
   }

   SendMail(body: {}): Observable<string>{
    const url = AppSettings.BASE_ADDRESS + 'mail/send?token=' + this.tokenService.GetToken();
    return this.httpclient.post<string>(url, body, {responseType: 'text' as 'json'});
   }
}

export interface IMailResponse{
  Emails: IMail[]
}

interface IMail{
  mail: string;
}