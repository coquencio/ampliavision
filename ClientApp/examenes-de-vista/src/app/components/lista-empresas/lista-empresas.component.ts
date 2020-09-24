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
  empresasMirror: IEmpresas;
  empresaRegistration = {
    Nombre: '',
    Domicilio: '',
    Telefono: ''
  };
  empresaUpdate = {
    EmpresaID:0,
    NombreEmpresa: '',
    Domicilio: '',
    Telefono: ''
  };
  criteria : string;
  folio: string;
  id: number;
  loading: boolean = false;
  loadingRegistration: boolean = false;
  @ViewChild('closeModal') private closeModal: ElementRef;
  @ViewChild('closeUpdate') private closeUpdate: ElementRef;

  constructor(
    private empresaService: EmpresasService,
    private store: Store<any>,
    ) {
     }
  
  ngOnInit(): void {
    this.loading = true;
    this.empresaService.GetEmpresas().subscribe(
      r => {
        this.empresas = r;
        this.empresasMirror = {Empresas:[]};
        this.empresas.Empresas.forEach(
          e=> this.empresasMirror.Empresas.push(e)
        );
        this.loading = false;
      }
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
    this.loadingRegistration = true;
    this.empresaService.Create(this.empresaRegistration).subscribe(
      r => {
        this.loadingRegistration = false;
        this.closeModal.nativeElement.click();
        this.ngOnInit();
        this.empresaRegistration.Nombre='';
        this.empresaRegistration.Domicilio='';
        this.empresaRegistration.Telefono='';
        window.alert(r);
      },
      err => {
        this.loadingRegistration = false;
        window.alert(err.error);
      }
    );
  }
  private PhoneValidation(isUpdate = false): boolean{
    const allowedCharacters = '1234567890()- +';
    const phoneToValidate = isUpdate? this.empresaUpdate.Telefono : this.empresaRegistration.Telefono;
    for (var i = 0; i < phoneToValidate.length; i++) {
      const character = phoneToValidate.charAt(i);
      if (!allowedCharacters.includes(character)){
        return false;
      }
    }
    return true;
  }
  searchByRelation(isByFolio: boolean = true){
    this.criteria = null;
    if (isByFolio){
      this.id = null;
      if (!this.folio || this.folio === ''){
        window.alert('Introduce un folio válido');
        return;
      }
      this.loading = true;
      this.empresaService.GetIdByFolio(this.folio).subscribe(
        r=> {
          if (r.EmpresaID){
            this.empresasMirror.Empresas=this.empresas.Empresas.filter(e=>e.EmpresaID === r.EmpresaID);
            this.loading = false;
          }
        },
        ()=> {
          this.loading = false;
          window.alert('No se ha encontrado una empresa con ese folio');
          this.folio = '';
        }
      );
    }
    else{
      this.folio = null;
      if (!this.id){
        window.alert('Introduce un id de venta válido');
        return;
      }
      this.loading = true;
      this.empresaService.GetIdBySale(this.id).subscribe(
        r=> {
            this.empresasMirror.Empresas=this.empresas.Empresas.filter(e=>e.EmpresaID === r.EmpresaID);
            this.loading = false;
        },
        ()=> {
          this.loading = false;
          window.alert('No se ha encontrado una empresa con ese id de venta');
          this.id = undefined;
        },
        ()=> this.loading = false
      );
    }
  }
  setEmpresaUpdate(empresa){
    this.empresaUpdate.EmpresaID = empresa.EmpresaID;
    this.empresaUpdate.NombreEmpresa= empresa.NombreEmpresa;
    this.empresaUpdate.Domicilio = empresa.Domicilio;
    this.empresaUpdate.Telefono = empresa.Telefono;
  }
  cleanUpdate (){
    this.empresaUpdate = {
      EmpresaID: 0,
      NombreEmpresa: '',
      Domicilio: '',
      Telefono: ''
    };
  }
  UpdateEmpresa(){
    if (this.empresaUpdate.NombreEmpresa === undefined || this.empresaUpdate.NombreEmpresa === null || this.empresaUpdate.NombreEmpresa.trim() === ''){
      window.alert('Introduce un nombre válido');
      return;
    }
    if (this.empresaUpdate.Domicilio === undefined || this.empresaUpdate.Domicilio === null || this.empresaUpdate.Domicilio.trim() === ''){
      window.alert('Introduce un domicilio válido');
      return;
    }
    if (this.empresaUpdate.Telefono === undefined || this.empresaUpdate.Telefono === null || this.empresaUpdate.Telefono.trim() === ''){
      window.alert('Introduce un teléfono válido');
      return;
    }
    if (!this.PhoneValidation(true)){
      window.alert('Introduce un teléfono válido');
      return;
    }
    this.loadingRegistration = true;
    this.empresaService.Update(this.empresaUpdate, this.empresaUpdate.EmpresaID).subscribe(
      r=> {
        this.loadingRegistration = false;
        this.cleanUpdate();
        this.closeUpdate.nativeElement.click();
        this.ngOnInit();
        window.alert(r);
      },
      err=>{
        this.loadingRegistration = false;
        window.alert(err.error);
      }
      );
  }
  changeFolio(){
      this.criteria = '';
      this.searchByName();
  }
  
  changeId(){
      this.criteria = '';
      this.searchByName();
  }
  searchByName(){
    this.empresasMirror = {Empresas:[]};
    if (!this.criteria){
      this.empresas.Empresas.forEach(e=> this.empresasMirror.Empresas.push(e));
    }
    else{
      this.empresas.Empresas.forEach(e=>
         {
           if (e.NombreEmpresa.toLowerCase().includes(this.criteria.toLowerCase())){
            this.empresasMirror.Empresas.push(e);
           }
         }
         );
    }
  }
}
