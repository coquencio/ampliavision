import { Component, OnInit } from '@angular/core';
import { IResumenExamenes } from 'src/app/Interfaces/examenInterface';
import { ExamenesService } from 'src/app/services/examenes/examenes.service';
import { Store } from '@ngrx/store';
import { IsoService } from 'src/app/services/isos/iso.service';
import { IIsos, IIsosBeneficiario } from 'src/app/Interfaces/isoInterface';
import { Router } from '@angular/router';
import * as XLSX from 'xlsx'; 

@Component({
  selector: 'app-defectos-visuales',
  templateUrl: './defectos-visuales.component.html',
  styleUrls: ['./defectos-visuales.component.scss']
})
export class DefectosVisualesComponent implements OnInit {

  constructor(
    private examenService: ExamenesService,
    store: Store<any>,
    private isoService: IsoService,
    private router: Router
    ) { 
      store.select('empresa').subscribe(
        empresa => {
          this.empresaId = empresa.empresaId;
          this.nombreEmpresa = empresa.nombreEmpresa;
        }
      );
    }
  nombreEmpresa: string;
  empresaId: number;
  resumen: IResumenExamenes;
  resumenMirror:IResumenExamenes = {
    Examenes: []
  };
  nombreBeneficiario: string;
  beneficiarioId: number;
  isoList: IIsos;
  isosPorBeneficiario: IIsosBeneficiario;
  casoId: number;
  casosIsos = ['', 
  'Armazón Oftálmico',
  'Armazón Solar',
  'Cambio de micas',
  'Lente de contacto',
  'Accesorios'];
  folio: string;
  loading: boolean = false;

  ngOnInit(): void {
    this.loading = true;
    this.examenService.GetSummaryByCompany(this.empresaId).subscribe(
      result => {
        this.loading = false;
        this.resumen = result;
        this.resumenMirror = {Examenes:[]};
        this.resumen.Examenes.forEach(e=> this.resumenMirror.Examenes.push(e));
      }
    );
    this.isoService.GetIsos().subscribe(
      r => {this.isoList = r;}
    );
  }
  private populateIsosPorBeneficiario(): void{
    this.isoService.GetIsosByEmployee(this.beneficiarioId).subscribe(
      r => this.isosPorBeneficiario = r,
      () => {
        this.isosPorBeneficiario = undefined;
      },
      () => {
        this.isosPorBeneficiario.Casos.forEach(element => {
          element.Descripcion = this.casosIsos[element.CasoID]});
      }
    );
  }
  RedirectToUpdate(folio:string ){
    this.examenService.SetFolio(folio);
    this.router.navigate(['Examenes/Actualiza']);
  }
  setName(beneficiarioId: number, nombre: string): void{
    this.nombreBeneficiario = nombre;
    this.beneficiarioId = beneficiarioId;
    this.populateIsosPorBeneficiario();
  }

  addIsoCase(): void{
    if (this.casoId===undefined){
      window.alert('Por favor selecciona primero un caso para registrar');
      return;
    }
    this.isoService.AddNewRelation(this.beneficiarioId, this.casoId).subscribe(
      () => {this.populateIsosPorBeneficiario()},
    );
  }
  deleteRelation(id: number){
    this.isoService.DeleteIsosRelation(id).subscribe(
      () => this.populateIsosPorBeneficiario()
      );
  }

  SearchFolio(){
    if (this.folio){
      this.resumenMirror.Examenes = [];
      this.resumenMirror.Examenes = this.resumen.Examenes.filter(e=>e.folio.toLowerCase().includes(this.folio.toLowerCase()));
    }
    else{
      this.resumen.Examenes.forEach(e=> this.resumenMirror.Examenes.push(e));
    }
  }
  ExportTable(){
    const element = document.getElementById('reporteExamenes'); 
    const ws: XLSX.WorkSheet =XLSX.utils.table_to_sheet(element);

    /* generate workbook and add the worksheet */
    const wb: XLSX.WorkBook = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, 'Hoja 1');

    /* save to file */
    XLSX.writeFile(wb, this.nombreEmpresa + new Date().toISOString().slice(0,10)+'Examenes.xlsx');
  }
}
