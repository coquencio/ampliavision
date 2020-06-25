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
  criteria : string;
  folio: string;
  id: number;
  @ViewChild('closeModal') private closeModal: ElementRef;
 
  constructor(
    private empresaService: EmpresasService,
    private store: Store<any>,
    ) {
     }
  
  ngOnInit(): void {
    this.empresaService.GetEmpresas().subscribe(
      r => {
        this.empresas = r;
        this.empresasMirror = {Empresas:[]};
        this.empresas.Empresas.forEach(
          e=> this.empresasMirror.Empresas.push(e)
        );
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
    this.empresaService.Create(this.empresaRegistration).subscribe(
      r => {
        window.alert(r);
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
  searchByRelation(isByFolio: boolean = true){
    this.criteria = null;
    if (isByFolio){
      this.id = null;
      if (!this.folio || this.folio === ''){
        window.alert('Introduce un folio válido');
        return;
      }
      this.empresaService.GetIdByFolio(this.folio).subscribe(
        r=> {
          if (r.EmpresaID){
            this.empresasMirror.Empresas=this.empresas.Empresas.filter(e=>e.EmpresaID === r.EmpresaID);
          }
        },
        ()=> window.alert('No se ha encontrado una empresa con ese folio')
      );
    }
    else{
      this.folio = null;
      
      if (!this.id){
        window.alert('Introduce un id de venta válido');
        return;
      }
      this.empresaService.GetIdBySale(this.id).subscribe(
        r=> {
            this.empresasMirror.Empresas=this.empresas.Empresas.filter(e=>e.EmpresaID === r.EmpresaID);
        },
        ()=> window.alert('No se ha encontrado una empresa con ese id de venta')
      );
    }
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
