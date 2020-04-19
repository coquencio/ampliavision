import { Component, OnInit } from '@angular/core';
import { IResumenExamenes } from 'src/app/Interfaces/examenInterface';
import { ExamenesService } from 'src/app/services/examenes/examenes.service';
import { Store } from '@ngrx/store';
import { IsoService } from 'src/app/services/isos/iso.service';
import { IIsos, IIsosBeneficiario } from 'src/app/Interfaces/isoInterface';

@Component({
  selector: 'app-defectos-visuales',
  templateUrl: './defectos-visuales.component.html',
  styleUrls: ['./defectos-visuales.component.css']
})
export class DefectosVisualesComponent implements OnInit {

  constructor(
    private examenService: ExamenesService,
    store: Store<any>,
    private isoService: IsoService
    ) { 
      store.select('empresa').subscribe(
        empresa => {this.empresaId = empresa.empresaId}
      );
    }

  empresaId: number;
  resumen: IResumenExamenes;
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

  ngOnInit(): void {
    this.examenService.GetSummaryByCompany(this.empresaId).subscribe(
      result => {this.resumen = result;}
    );
    this.isoService.GetIsos().subscribe(
      r => {this.isoList = r;}
    );
  }
  private populateIsosPorBeneficiario(): void{
    this.isoService.GetIsosByEmployee(this.beneficiarioId).subscribe(
      r=>this.isosPorBeneficiario = r,
      ()=>{window.alert('Aún no hay casos registrados')},
      ()=>{this.isosPorBeneficiario.Casos.forEach(element => {
        element.Descripcion = this.casosIsos[element.CasoID]
      });}
      );
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
      r=>{this.populateIsosPorBeneficiario()},
    );
  }
  deleteRelation(id: number){
    console.log(id);
  }

}
