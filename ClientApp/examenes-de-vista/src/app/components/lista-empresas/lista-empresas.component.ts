import { Component, OnInit, EventEmitter, Output } from '@angular/core';
import { IEmpresas } from 'src/app/Interfaces/empresasInterface';
import { EmpresasService } from 'src/app/services/empresas/empresas.service';
import { Store } from '@ngrx/store';
import { Router } from '@angular/router';

@Component({
  selector: 'app-lista-empresas',
  templateUrl: './lista-empresas.component.html',
  styleUrls: ['./lista-empresas.component.css']
})
export class ListaEmpresasComponent implements OnInit {

  empresas: IEmpresas;
  constructor(
    private empresaService: EmpresasService,
    private store: Store<any>,
    private router: Router
    ) { }
  
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

}
