import { Injectable } from '@angular/core';
import {HttpClient} from '@angular/common/http';
import { Observable } from 'rxjs';
import { IToken } from '../Interfaces/FolioInterface';
import { AppSettings } from '../core/constants'
@Injectable({
  providedIn: 'root'
})
export class LoginService {

  constructor(private _httpClient : HttpClient){ }

  Login (userName: String, password: String):Observable<IToken>{
    return this._httpClient.get<IToken>(AppSettings.BASE_ADDRESS+'login/'+userName+'/'+password);
  }
}
