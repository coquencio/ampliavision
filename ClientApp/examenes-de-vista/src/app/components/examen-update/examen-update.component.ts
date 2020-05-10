import { Component, OnInit } from '@angular/core';
import { ExamenesService } from 'src/app/services/examenes/examenes.service';

@Component({
  selector: 'app-examen-update',
  templateUrl: './examen-update.component.html',
  styleUrls: ['./examen-update.component.css']
})
export class ExamenUpdateComponent implements OnInit {

  errorMessage: string;
  folio: string;
  canDisplayDetails: boolean;
  examResponse: {};
  constructor(private examenService: ExamenesService) { }

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
    }
    catch(Exception){
      this.errorMessage = 'Examen no encontrado';
    }
    this.canDisplayDetails = this.examResponse === undefined? false : true;
  }
}
