import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { IResumenExamenes } from 'src/app/Interfaces/examenInterface';
import { AppSettings } from 'src/app/core/constants';
import { TokenService } from '../token/token.service';

@Injectable({
  providedIn: 'root'
})
export class ExamenesService {

  constructor(
    private httpClient: HttpClient,
    private tokenService: TokenService
    ) { }

  GetSummaryByCompany(EmpresaId: number): Observable<IResumenExamenes>{
    return this.httpClient.get<IResumenExamenes>(AppSettings.BASE_ADDRESS + 'examenes/resumen/' + EmpresaId + '?token=' + this.tokenService.GetToken());
  }
}
