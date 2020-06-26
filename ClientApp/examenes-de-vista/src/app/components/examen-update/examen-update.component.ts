import { Component, OnInit } from '@angular/core';
import { ExamenesService, IExamenResponse } from 'src/app/services/examenes/examenes.service';
import { OjosService } from 'src/app/services/ojos/ojos.service';
import { IBeneficiarios } from 'src/app/Interfaces/beneficiariosInterface';
import { BeneficiarioService } from 'src/app/services/beneficiarios/beneficiario.service';
import { Store } from '@ngrx/store';
import { Router } from '@angular/router';

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
    beneficiariosEmpresa: IBeneficiarios;

    incluyeAdaptacion: boolean;
    incluyeTotal: boolean;
    incluyeAnterior: boolean;
    currentEmpresaId: number;
    constructor(
    private router: Router,
    private examenService: ExamenesService,
    private ojoService: OjosService,
    private beneficiarioService: BeneficiarioService,
    store: Store<any>
    ) { 
      store.select('empresa').subscribe(
        e => {
          this.currentEmpresaId = e.empresaId;
        }
      );
    }

  ngOnInit(): void {
    this.beneficiarioService.GetByEmpresa(this.currentEmpresaId).subscribe(
      r =>{
      this.beneficiariosEmpresa = r;   
      this.folio = this.examenService.GetFolio();
      if (this.folio){
        this.GetExamen();
      }
    }
    );
  }

  async GetExamen() {
    this.errorMessage = '';
    if (this.folio === '' || this.folio === undefined){
      window.alert("Introduce un folio");
      return;
    }
    try{
      this.examResponse = await this.examenService.GetByFolio(this.folio);
      if (this.AssignBeneficiario()){
        this.ValidaConjuntos();
        this.AssingData();
        this.canDisplayDetails = true;
      }
      else{
        this.errorMessage = 'Este folio de examen no pertenece a esta compañía';
      }
    }
    catch(Exception){
      this.errorMessage = 'Examen no encontrado';
      this.canDisplayDetails = false;
    }
  }

  private AssignBeneficiario(): boolean{
    let isInThisCompany: boolean = false;
    this.beneficiariosEmpresa.Beneficiarios.forEach(b=> {
      if (this.examResponse.BeneficiarioID == b.BeneficiarioID){
         isInThisCompany = true;
      }
    });
    if (isInThisCompany)
      this.beneficiarioId = this.examResponse.BeneficiarioID;
    return isInThisCompany;  
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

  async UpdateExam(){
    if (this.incluyeAnterior){
      if (!this._ValidaCamposOjos('anterior')) {
        window.alert('Es necesario completar los datos en la sección con el nombre "anterior"');
        return;
      }
    }
    if (this.incluyeTotal){
      if (!this._ValidaCamposOjos('total')) {
        window.alert('Es necesario completar los datos en la sección con el nombre "total"');
        return;
      }
    }
    if (this.incluyeAdaptacion){
      if (!this._ValidaCamposOjos('adaptacion')) {
        window.alert('Es necesario completar los datos en la sección con el nombre "adaptación"');
        return;
      }
    }
    const anteriorId = this.incluyeAnterior? await this._RegistraParAsync('anterior') : 'NULL';
    const totalId = this.incluyeTotal? await this._RegistraParAsync('total') : 'NULL';
    const adaptacionId = this.incluyeAdaptacion? await this._RegistraParAsync('adaptacion') : 'NULL';

    const examen = {
      Folio: this.folio, 
      BeneficiarioId: parseInt(this.beneficiarioId.toString()),
      AnteriorId: anteriorId,
      TotalId: totalId,
      AdaptacionId: adaptacionId,
      RequiereLentes: this.requiereLentes? 1 : 0,
      ComproLentes: this.comproLentes? 1 : 0,
      EnfermedadId: parseInt(this.enfermedadId.toString()),
      Observaciones: this.observaciones
    }
    this.examenService.UpdateExam(examen).subscribe(
      r => {
        window.alert('Examen actualizado satisfactoriamente');
        this.folio = '';
        this.canDisplayDetails = false;
    }
    );
  }
  private _ValidaCamposOjos(tipo: string): boolean{
    let izquierdo = {
      Esfera: undefined,
      Cilindro: undefined,
      Eje: undefined,
      Adiccion: undefined  
    };
    let derecho = {
      Esfera: undefined,
      Cilindro: undefined,
      Eje: undefined,
      Adiccion: undefined  
    };
    let detalle = {
      Lejos: undefined,
      Obl: undefined
    };;
    switch (tipo){
      case 'anterior':
        derecho = this.dant;
        izquierdo = this.iant;
        detalle = this.detalleAnterior;
      break;
      case 'total':
        derecho = this.dtot;
        izquierdo = this.itot;
        detalle = this.detalleTotal;
      break;
      case 'adaptacion':
        derecho = this.dada;
        izquierdo = this.iada;
        detalle = this.detalleAdaptacion;
      break;
      default:
        break;
    }
    
    if(
      izquierdo.Adiccion === undefined ||
      izquierdo.Cilindro === undefined ||
      izquierdo.Eje === undefined ||
      izquierdo.Esfera === undefined ||
      derecho.Adiccion === undefined ||
      derecho.Cilindro === undefined ||
      derecho.Eje === undefined ||
      derecho.Esfera === undefined ||
      detalle.Lejos === undefined ||
      detalle.Obl === undefined ||
      izquierdo.Adiccion === null ||
      izquierdo.Cilindro === null ||
      izquierdo.Eje === null ||
      izquierdo.Esfera === null ||
      derecho.Adiccion === null ||
      derecho.Cilindro === null ||
      derecho.Eje === null ||
      derecho.Esfera === null ||
      detalle.Lejos === null ||
      detalle.Obl === null
      
      )
    {
      return false;
    }
    return true;
  }
  private async _RegistraParAsync(tipo: string){
    let izquierdoId: Number;
    let derechoId: Number;
    let derechoConjunto: {};
    let izquierdoConjunto: {};
    let detalles: {
      Lejos: undefined,
      Obl: undefined
      };
    let conjuntoId;
    switch (tipo){
      case 'anterior':
        derechoConjunto = this.dant;
        izquierdoConjunto = this.iant;
        detalles = this.detalleAnterior;
        break;
      case 'total':
        derechoConjunto = this.dtot;
        izquierdoConjunto = this.itot;
        detalles = this.detalleTotal;
        break;
      case 'adaptacion':
        derechoConjunto = this.dada;
        izquierdoConjunto = this.iada;
        detalles = this.detalleAdaptacion
        break;
      default:
        break;
    }
    izquierdoId = (await this.ojoService.AddSingleEyeAsync(izquierdoConjunto, 'izquierdo')).OjoID;
    derechoId = (await this.ojoService.AddSingleEyeAsync(derechoConjunto, 'derecho')).OjoID;
    
    conjuntoId = (await this.ojoService.AddPairAsync(izquierdoId, derechoId, detalles.Lejos, detalles.Obl, tipo)).ConjuntoID;
    return conjuntoId; 
  }
}
