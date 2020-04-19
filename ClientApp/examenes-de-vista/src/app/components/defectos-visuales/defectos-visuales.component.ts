import { Component, OnInit } from '@angular/core';
import { IResumenExamenes } from 'src/app/Interfaces/examenInterface';
import { ExamenesService } from 'src/app/services/examenes/examenes.service';
import { Store } from '@ngrx/store';

@Component({
  selector: 'app-defectos-visuales',
  templateUrl: './defectos-visuales.component.html',
  styleUrls: ['./defectos-visuales.component.css']
})
export class DefectosVisualesComponent implements OnInit {

  constructor(
    private examenService: ExamenesService,
    store: Store<any>
    ) { 
      store.select('empresa').subscribe(
        empresa => {this.empresaId = empresa.empresaId}
        );
    }
  empresaId: number;
  resumen: IResumenExamenes;

  ngOnInit(): void {
    this.examenService.GetSummaryByCompany(this.empresaId).subscribe(
      result => {this.resumen = result;}
    );
  }

}
