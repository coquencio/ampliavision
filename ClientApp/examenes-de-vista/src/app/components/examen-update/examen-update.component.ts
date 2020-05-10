import { Component, OnInit } from '@angular/core';
import { ExamenesService, IExamenResponse } from 'src/app/services/examenes/examenes.service';
import { OjosService } from 'src/app/services/ojos/ojos.service';

@Component({
  selector: 'app-examen-update',
  templateUrl: './examen-update.component.html',
  styleUrls: ['./examen-update.component.css']
})
export class ExamenUpdateComponent implements OnInit {

  errorMessage: string;
  folio: string;
  canDisplayDetails: boolean;
  examResponse: IExamenResponse;

  iant = {
    Esfera: undefined,
    Cilindro: undefined,
    Eje: undefined,
    Adiccion: undefined
    };
    dant = {
      Esfera: undefined,
      Cilindro: undefined,
      Eje: undefined,
      Adiccion: undefined  
    };
    dtot = {
      Esfera: undefined,
      Cilindro: undefined,
      Eje: undefined,
      Adiccion: undefined  
    };
    itot = {
      Esfera: undefined,
      Cilindro: undefined,
      Eje: undefined,
      Adiccion: undefined  
    };
    dada = {
      Esfera: undefined,
      Cilindro: undefined,
      Eje: undefined,
      Adiccion: undefined  
    };
    iada = {
      Esfera: undefined,
      Cilindro: undefined,
      Eje: undefined,
      Adiccion: undefined  
    };
    detalleAnterior = {
      Lejos: undefined,
      Obl: undefined
    };
    detalleTotal = {
      Lejos: undefined,
      Obl: undefined
    };
    detalleAdaptacion = {
      Lejos: undefined,
      Obl: undefined
    };
    enfermedadId: number;
    beneficiarioId: number;
    requiereLentes: boolean;
    comproLentes: boolean;
    observaciones: string;

    incluyeAdaptacion: boolean;
    incluyeTotal: boolean;
    incluyeAnterior: boolean;
  constructor(
    private examenService: ExamenesService,
    private ojoService: OjosService
    ) { }

  ngOnInit(): void {
  }

  async GetExamen() {
    this.errorMessage = '';
    if (this.folio === '' || this.folio === undefined){
      window.alert("Introduce un folio");
      return;
    }
    try{
      this.examResponse = await this.examenService.GetByFolio(this.folio);
      this.ValidaConjuntos();
      this.AssingData();
      this.canDisplayDetails = true;
    }
    catch(Exception){
      this.errorMessage = 'Examen no encontrado';
      this.canDisplayDetails = false;
    }
  }
  private async AssingData(){
    if(this.incluyeAnterior){
      const anterior = await this.ojoService.GetPair(this.examResponse.Anterior);
      this.detalleAnterior.Lejos = anterior.DpLejos;
      this.detalleAnterior.Obl = anterior.Obl;
      const izquierdo = await this.ojoService.GetSingle(anterior.IzquierdoID);
      const derecho = await this.ojoService.GetSingle(anterior.DerechoID);
      this.iant = izquierdo;
      this.dant = derecho;
    }
    if(this.incluyeTotal){
      const total = await this.ojoService.GetPair(this.examResponse.Total);
      this.detalleTotal.Lejos = total.DpLejos;
      this.detalleTotal.Obl = total.Obl;
      const izquierdo = await this.ojoService.GetSingle(total.IzquierdoID);
      const derecho = await this.ojoService.GetSingle(total.DerechoID);
      this.itot = izquierdo;
      this.dtot = derecho;
    }
    if(this.incluyeAdaptacion){
      const adaptacion = await this.ojoService.GetPair(this.examResponse.Adaptacion);
      this.detalleAdaptacion.Lejos = adaptacion.DpLejos;
      this.detalleAdaptacion.Obl = adaptacion.Obl;
      const izquierdo = await this.ojoService.GetSingle(adaptacion.IzquierdoID);
      const derecho = await this.ojoService.GetSingle(adaptacion.DerechoID);
      this.iada = izquierdo;
      this.dada = derecho;
    }
    this.enfermedadId = this.examResponse.EnfermedadID;
    this.requiereLentes = this.examResponse.RequiereLentes == 1? true : false;
    this.comproLentes = this.examResponse.ComproLentes == 1? true : false;
    this.observaciones = this.examResponse.Observacion;
  }
  private ValidaConjuntos(): void{
    this.incluyeAdaptacion = this.examResponse.Adaptacion === null? false : true;
    this.incluyeAnterior = this.examResponse.Anterior === null? false : true;
    this.incluyeTotal = this.examResponse.Total === null? false : true;
  }
}
