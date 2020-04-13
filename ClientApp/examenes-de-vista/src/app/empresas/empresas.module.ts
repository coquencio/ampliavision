import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ListaEmpresasComponent } from './lista-empresas/lista-empresas.component';
import { RouterModule } from '@angular/router';
import { StoreModule } from '@ngrx/store';
import { reducerEmpresa } from './state/empresa.reducer';



@NgModule({
  declarations: [ListaEmpresasComponent],
  imports: [
    CommonModule,
    RouterModule.forRoot([
      {path: 'Empresas', component: ListaEmpresasComponent}
    ]),
    StoreModule.forFeature('empresa', reducerEmpresa)
  ]
})
export class EmpresasModule { }
