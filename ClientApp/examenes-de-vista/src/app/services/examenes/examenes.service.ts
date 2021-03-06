import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { IResumenExamenes } from 'src/app/Interfaces/examenInterface';
import { AppSettings } from 'src/app/core/constants';
import { TokenService } from '../token/token.service';
import { IFolios } from 'src/app/Interfaces/foliosInterface';
import { IBeneficiarioId } from 'src/app/Interfaces/beneficiarioIdInterface';

export interface IExamenResponse{
  ExamenID: number;
  Folio: string;
  BeneficiarioID: number;
  Anterior: number;
  Total: number;
  Adaptacion: number;
  FechaExamen: string;
  RequiereLentes: number;
  ComproLentes: number;
  EnfermedadID: number;
  Observacion: string;
}

@Injectable({
  providedIn: 'root'
})

export class ExamenesService {

  constructor(
    private httpClient: HttpClient,
    private tokenService: TokenService
    ) { }

  folio: string;

  GetSummaryByCompany(EmpresaId: number): Observable<IResumenExamenes>{
    return this.httpClient.get<IResumenExamenes>(AppSettings.BASE_ADDRESS + 'examenes/resumen/' + EmpresaId + '?token=' + this.tokenService.GetToken());
  }
  PostExam(examen: {}): Observable<any>{
    const headers = new HttpHeaders().set('Content-Type', 'application/json; charset=utf-8');
    const url = AppSettings.BASE_ADDRESS + 'examenes?token=' + this.tokenService.GetToken();
    return this.httpClient.post<any>(url, examen,  {headers, responseType: 'json'});
  }
  UpdateExam(examen: {}): Observable<any>{
    const headers = new HttpHeaders().set('Content-Type', 'application/json; charset=utf-8');
    const url = AppSettings.BASE_ADDRESS + 'examenes?token=' + this.tokenService.GetToken();
    return this.httpClient.put<any>(url, examen,  {headers, responseType: 'json'});
  }
  async GetByFolio(folio: string): Promise<IExamenResponse>{
    const url = AppSettings.BASE_ADDRESS + 'examenes/folio/'+ folio +'?token=' + this.tokenService.GetToken();
    return await this.httpClient.get<IExamenResponse>(url).toPromise();  
  }

  GetFolioByEmpresa(EmpresaId: number): Observable<IFolios>{
    const url = AppSettings.BASE_ADDRESS +'empresas/' + EmpresaId+'/examenes/folios?token=' + this.tokenService.GetToken();
    return this.httpClient.get<IFolios>(url);
  }

  GetBeneficiarioIdByFolio(folio: string): Observable<IBeneficiarioId>{
    const url = AppSettings.BASE_ADDRESS + 'examenes/'+ folio +'/beneficiario?token=' + this.tokenService.GetToken();  
    return this.httpClient.get<IBeneficiarioId>(url);
  }
  SetFolio(folio:string){
    this.folio = folio;
  }
  GetFolio(){
    return this.folio;
  }
  CleanFolio(){
    this.folio = null;
  }
}
