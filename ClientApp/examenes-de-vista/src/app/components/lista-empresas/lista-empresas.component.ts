import { Component, OnInit, EventEmitter, Output, ViewChild, ElementRef } from '@angular/core';
import { IEmpresas } from 'src/app/Interfaces/empresasInterface';
import { EmpresasService } from 'src/app/services/empresas/empresas.service';
import { Store } from '@ngrx/store';

@Component({
  selector: 'app-lista-empresas',
  templateUrl: './lista-empresas.component.html',
  styleUrls: ['./lista-empresas.component.css']
})
export class ListaEmpresasComponent implements OnInit {

  empresas: IEmpresas;
  empresaRegistration = {
    Nombre: '',
    Domicilio: '',
    Telefono: ''
  };
  @ViewChild('closeModal') private closeModal: ElementRef;
 
  constructor(
    private empresaService: EmpresasService,
    private store: Store<any>,
    ) {
     }
  
  ngOnInit(): void {
    this.empresaService.GetEmpresas().subscribe(
      r => {this.empresas = r;}
    );
  }

  setEmpresa(empresaId: number, nombreEmpresa: string): void{
    this.store.dispatch({
      type: 'SET_EMPRESA',
      payload: {
        id: empresaId,
        nombre: nombreEmpresa
      }
    });
  }

  RegistraEmpresa(){
    if (this.empresaRegistration.Nombre === undefined || this.empresaRegistration.Nombre === ''){
      window.alert('Introduce un nombre de empresa');
      return;
    }
    if (this.empresaRegistration.Domicilio === undefined || this.empresaRegistration.Domicilio === ''){
      window.alert('Introduce un domicilio de empresa');
      return;
    }
    if (this.empresaRegistration.Telefono === undefined || this.empresaRegistration.Telefono === ''){
      window.alert('Introduce un teléfono de empresa');
      return;
    }
    if (!this.PhoneValidation()){
      window.alert('Introduce un número de teléfono válido');
      return;
    }
    this.empresaService.Create(this.empresaRegistration).subscribe(
      r => {
        window.alert('Empresa creada satisfactoriamente'+r);
        this.closeModal.nativeElement.click();
        this.ngOnInit();
        this.empresaRegistration.Nombre='';
        this.empresaRegistration.Domicilio='';
        this.empresaRegistration.Telefono='';
      }
    );
  }
  private PhoneValidation(): boolean{
    const allowedCharacters = '1234567890()- +';
    
    for (var i = 0; i < this.empresaRegistration.Telefono.length; i++) {
      const character = this.empresaRegistration.Telefono.charAt(i);
      if (!allowedCharacters.includes(character)){
        return false;
      }
    }
    return true;
  }
}
