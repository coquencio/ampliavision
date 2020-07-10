import { Component, OnInit } from '@angular/core';
import { IVentasChart, IGeneralChart } from 'src/app/Interfaces/chartsInterface';
import { ChartsService } from 'src/app/services/charts/charts.service';
import { Store } from '@ngrx/store';
import { chartType } from 'src/app/core/enums/chartType';
import * as jspdf from 'jspdf';    
import html2canvas from 'html2canvas';  

@Component({
  selector: 'app-charts',
  templateUrl: './charts.component.html',
  styleUrls: ['./charts.component.css']
})
export class ChartsComponent implements OnInit {
  ventas: IVentasChart[];
  isos: IGeneralChart[];
  enfermedades: IGeneralChart[];
  currentEmpresaId: number;
  nombreEmpresa: string;
  fullSumarySaleData = [ ];
  enfermedadesData = [];
  fastSummaryData = [];
  isosData = [];
  pdfGenerating: boolean = false;
  imagePath = 'assets/img/logo.JPG';

  constructor(
    private readonly chartService: ChartsService,
    store: Store<any>,
    ) {
      store.select('empresa').subscribe(
        e => {
          this.currentEmpresaId = e.empresaId;
          this.nombreEmpresa = e.nombreEmpresa;
        }
      );
     }

  ngOnInit(): void {
    this.chartService.GetGeneralChart(this.currentEmpresaId, chartType.enfermedades).subscribe(
      r=>{
      this.enfermedades = r;
      this.enfermedades.forEach(e=>{
        const dataRow = {name:e.Descripcion, value: e.Total};
        this.enfermedadesData.push(dataRow);
      });
      }
    );
    this.chartService.GetGeneralChart(this.currentEmpresaId, chartType.isos).subscribe(
      r=> {
        this.isos = r;
        this.isosData = this.BuildIsosData(r);
      }
    );
    this.chartService.GetSalesChart(this.currentEmpresaId).subscribe(
      r=> {
        this.ventas = r;
        this.fastSummaryData = this.BuildFastSummary(r);
        this.fullSumarySaleData = [
          { name: "Requieren lentes y compraron lentes", value: this.ventas[0]? this.ventas[0].DataSet : 0},
          { name: "Requieren lentes y no compraron lentes", value: this.ventas[1]? this.ventas[1].DataSet : 0},
          { name: "No requieren lentes y no compraron lentes", value: this.ventas[2]?this.ventas[2].DataSet:0},
          { name: "No requieren lentes y compraron lentes", value: this.ventas[3]? this.ventas[3].DataSet: 0},      
        ];
      }
    );
  }

  private BuildFastSummary(data: IVentasChart[]){
    let total: number = 0;
    let buyers: number = 0;
    data.forEach(e=>{
      total = total+e.DataSet;
      if (e.comproLentes === 1){
        buyers = buyers + e.DataSet;
      }
    });

    const dataSet = 
    [
      {name:'Total', value:total},
      {name:'Requieren lentes', value:buyers}
    ]
    return dataSet;
  }
  private BuildIsosData(data: IGeneralChart[]){
    let array = [];
    data.forEach(i =>{
      array.push({name:i.Descripcion, value:i.Total});
    });
    return array;
  }
  async downloadAsPdfasync(){
    this.pdfGenerating = true;
    await this.delay(10);  //await 10 ms in order to take snapshot from screen without button
    let navbar = document.getElementById('navbar');
    let footer = document.getElementById('footer');
    navbar.hidden = true; // hides navbar for snapshot
    footer.hidden = true; // hides footer
    const canvas = document.body;
    html2canvas(canvas).then(canvas => {  
      var imgWidth = 280 + ((canvas.width - 1349) * .225);   //was 320 -20, -22  0.117
      var imgHeight = canvas.height * imgWidth / canvas.width;
      const contentDataURL = canvas.toDataURL('image/png');
      let pdf = new jspdf('p', 'mm', 'a3');  
      pdf.addImage(contentDataURL, -20 -((canvas.width - 1349) * .117) , 0, imgWidth, imgHeight);
      pdf.save(this.nombreEmpresa + ' Reporte de '+new Date().toISOString().slice(0,10));
    }).finally(()=> {
      this.pdfGenerating = false;
      navbar.hidden = false;
      footer.hidden = false;
    });
  }
  private delay(ms: number) {
    return new Promise( resolve => setTimeout(resolve, ms) );
  }
}
