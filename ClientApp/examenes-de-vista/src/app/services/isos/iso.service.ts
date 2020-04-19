import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { IIsos, IIsosBeneficiario } from 'src/app/Interfaces/isoInterface';
import { Observable } from 'rxjs';
import { AppSettings } from 'src/app/core/constants';
import { TokenService } from '../token/token.service';

@Injectable({
  providedIn: 'root'
})
export class IsoService {

  constructor(
    private client: HttpClient,
    tokenService: TokenService
    ) { 
      this.token = tokenService.GetToken();
  }
  
  private token: string;
  GetIsos(): Observable<IIsos> {
    return this.client.get<IIsos>(AppSettings.BASE_ADDRESS + 'iso/active?token=' + this.token);
  }
  AddNewRelation(beneficiarioId: number, casoId: number): Observable<any>{
    const headers = new HttpHeaders().set('Content-Type', 'text/plain; charset=utf-8');
    let url = 'iso/create/' + beneficiarioId + '/' + casoId + '?token=' + this.token;
    return this.client.post(AppSettings.BASE_ADDRESS + url,{}, {headers, responseType: 'text'});
  }

  GetIsosByEmployee(beneficiarioId: number): Observable<IIsosBeneficiario>{
    let url = 'iso/active/' + beneficiarioId + '?token=' + this.token;
    return this.client.get<IIsosBeneficiario>(AppSettings.BASE_ADDRESS + url);
  }
}
