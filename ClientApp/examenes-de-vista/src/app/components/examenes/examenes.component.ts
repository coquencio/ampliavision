import { Component, OnInit } from '@angular/core';
import { IBeneficiarios } from 'src/app/Interfaces/beneficiariosInterface';
import { BeneficiarioService } from 'src/app/services/beneficiarios/beneficiario.service';
import { Store } from '@ngrx/store';

@Component({
  selector: 'app-examenes',
  templateUrl: './examenes.component.html',
  styleUrls: ['./examenes.component.css']
})
export class ExamenesComponent implements OnInit {

  constructor(
    private beneficiariosService: BeneficiarioService,
    store: Store<any>
    ) { 
      store.select('empresa').subscribe(
        e => this.currentEmpresaId = e.empresaId
      );
    }
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
