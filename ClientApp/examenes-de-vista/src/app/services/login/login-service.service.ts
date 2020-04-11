import { Injectable } from '@angular/core';
import {HttpClient} from '@angular/common/http';
import { Observable } from 'rxjs';
import { IToken } from '../../Interfaces/tokenInterface';
import { AppSettings } from '../../core/constants'
@Injectable({
  providedIn: 'root'
})
export class LoginService {

  constructor(private httpClient: HttpClient){ }

  Login(userName: string, password: string): Observable<IToken>{
    return this.httpClient.get<IToken>(AppSettings.BASE_ADDRESS + 'login/' + userName + '/' + password);
  }
}
