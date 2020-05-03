import { Component, OnInit, ModuleWithComponentFactories } from '@angular/core';
import { IBeneficiarios } from 'src/app/Interfaces/beneficiariosInterface';
import { BeneficiarioService } from 'src/app/services/beneficiarios/beneficiario.service';
import { Store } from '@ngrx/store';
import { OjosService } from 'src/app/services/ojos/ojos.service';
import { ExamenesService } from 'src/app/services/examenes/examenes.service';

@Component({
  selector: 'app-examenes',
  templateUrl: './examenes.component.html',
  styleUrls: ['./examenes.component.css']
})
export class ExamenesComponent implements OnInit {

  constructor(
    private beneficiariosService: BeneficiarioService,
    store: Store<any>,
    private ojosService: OjosService,
    private examenService: ExamenesService,
    ) { 
      store.select('empresa').subscribe(
        e => {
          this.currentEmpresaId = e.empresaId;
          this.nombreEmpresa = e.nombreEmpresa;
        }
      );
    }
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
  requiereLentes: boolean = false;
  comproLentes: boolean = false;
  observaciones: string = '';
  folio: string = '';

  incluyeAdaptacion: boolean = true;
  incluyeTotal: boolean = true;
  incluyeAnterior: boolean = true;
  nombreEmpresa: string;
  currentEmpresaId: number;
  beneficiariosEmpresa: IBeneficiarios;
  beneficiarioRegistro = {
    Nombres: '',
    ApellidoPaterno: '',
    ApellidoMaterno:'',
    Ocupacion: '',
    FechaNacimiento: ''
  };

  ngOnInit(): void {
    this.beneficiariosService.GetByEmpresa(this.currentEmpresaId).subscribe(
      r => this.beneficiariosEmpresa = r
      );
  }

  private ValidateBeneficiarioFields(): boolean{
    if (this.beneficiarioRegistro.Nombres.trim()===''){
      window.alert('Favor de introducir el nombre de beneficiario');
      return false;
    }
    if (this.beneficiarioRegistro.ApellidoPaterno.trim()===''){
      window.alert('Favor de introducir el Apellido paterno');
      return false;
    }
    if (this.beneficiarioRegistro.ApellidoMaterno.trim()===''){
      window.alert('Favor de introducir el Apellido materno');
      return false;
    }
    if (this.beneficiarioRegistro.Ocupacion.trim()===''){
      window.alert('Favor de introducir la ocupación del beneficiario');
      return false;
    }
    if (this.beneficiarioRegistro.FechaNacimiento.trim()===''){
      window.alert('Favor de introducir la fecha de nacimiento');
      return false;
    }
    return true;
  }
  async RegistraExamenAsync(){
    if(this.folio.trim() === ''){
      window.alert('Introduce un folio válido');
      return;
    }
    if(this.beneficiarioId === undefined){
      window.alert('Selecciona un beneficiario para registrar el examen');
      return;
    }
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
    if (this.enfermedadId === undefined){
      window.alert('Selecciona una enfermedad');
      return;
    }
    this.observaciones = this.observaciones.trim();
    if (this.observaciones === ""){
      this.observaciones = ' ';
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
      FechaExamen:  new Date().toISOString().substring(0,10),
      RequiereLentes: this.requiereLentes? 1 : 0,
      ComproLentes: this.requiereLentes? 1 : 0,
      EnfermedadId: parseInt(this.enfermedadId.toString()),
      Observaciones: this.observaciones
    }
    this.examenService.PostExam(examen).subscribe(
      r => {
        console.log('a huevo prro');
        window.alert('Examen registrado satisfactoriamente');
        this.LimpiaCamposExamen();
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
    izquierdoId = (await this.ojosService.AddSingleEyeAsync(izquierdoConjunto, 'izquierdo')).OjoID;
    derechoId = (await this.ojosService.AddSingleEyeAsync(derechoConjunto, 'derecho')).OjoID;
    
    conjuntoId = (await this.ojosService.AddPairAsync(izquierdoId, derechoId, detalles.Lejos, detalles.Obl, tipo)).ConjuntoID;
    return conjuntoId; 
  }
  private LimpiaCamposExamen(): void{
    this.iant = {
      Esfera: undefined,
      Cilindro: undefined,
      Eje: undefined,
      Adiccion: undefined
      };
      this.dant = {
        Esfera: undefined,
        Cilindro: undefined,
        Eje: undefined,
        Adiccion: undefined  
      };
      this.dtot = {
        Esfera: undefined,
        Cilindro: undefined,
        Eje: undefined,
        Adiccion: undefined  
      };
      this.itot = {
        Esfera: undefined,
        Cilindro: undefined,
        Eje: undefined,
        Adiccion: undefined  
      };
      this.dada = {
        Esfera: undefined,
        Cilindro: undefined,
        Eje: undefined,
        Adiccion: undefined  
      };
      this.iada = {
        Esfera: undefined,
        Cilindro: undefined,
        Eje: undefined,
        Adiccion: undefined  
      };
      this.detalleAnterior = {
        Lejos: undefined,
        Obl: undefined
      };
      this.detalleTotal = {
        Lejos: undefined,
        Obl: undefined
      };
      this.detalleAdaptacion = {
        Lejos: undefined,
        Obl: undefined
      };
      this.enfermedadId = undefined;
      this.beneficiarioId = undefined;
      this.requiereLentes = false;
      this.comproLentes = false;
      this.observaciones = '';
      this.folio = '';
    
      this.incluyeAdaptacion = true;
      this.incluyeTotal = true;
      this.incluyeAnterior = true;
  }

  BeneficiarioRegistration(): void{
    if (this.ValidateBeneficiarioFields()){
      this.beneficiariosService.Create(this.currentEmpresaId, this.beneficiarioRegistro).subscribe(
        () => {
          this.ngOnInit();
          window.alert('Empleado registrado satisfactoriamente');
          this.beneficiarioRegistro = {
            Nombres: '',
            ApellidoPaterno: '',
            ApellidoMaterno:'',
            Ocupacion: '',
            FechaNacimiento: ''
          };
        }
      );
    }
  }

}
