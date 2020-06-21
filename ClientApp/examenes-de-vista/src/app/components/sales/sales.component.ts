import { Component, OnInit } from '@angular/core';
import { ExamenesService } from 'src/app/services/examenes/examenes.service';
import { IFolios } from 'src/app/Interfaces/foliosInterface';
import { Store } from '@ngrx/store';
import { SalesService } from 'src/app/services/sales/sales.service';
import { IOption } from 'src/app/Interfaces/optionsInterface';
import { IMaterial, IProteccion, ILente, IMarca, IColor, ITamanio, IModelo } from 'src/app/Interfaces/generalInterface';
import { GeneralService } from 'src/app/services/general/general.service';
import { ArmazonesService } from 'src/app/services/armazones/armazones.service';
import { IBeneficiario } from 'src/app/Interfaces/beneficiariosInterface';
import { BeneficiarioService } from 'src/app/services/beneficiarios/beneficiario.service';

@Component({
  selector: 'app-sales',
  templateUrl: './sales.component.html',
  styleUrls: ['./sales.component.css']
})
export class SalesComponent implements OnInit {

  folios: IFolios;
  currentEmpresaId: number;
  nombreEmpresa: string;
  tiposVenta: IOption[];
  armazones: any;
  materiales: IMaterial[];
  protecciones: IProteccion[];
  lentes: ILente[];
  //For armazón
  marcas: IMarca[];
  colores: IColor[];
  tamanios:ITamanio[];
  modelos: IModelo[];
  beneficiarios: IBeneficiario[];

  //For sale
  marcaId: number;
  colorId: number;
  tamanioId: number;
  modeloId: number;
  descArmazon: string;

  lenteId: number;
  proteccionId: number;
  materialId: number;
  fechaExamen: string;
  montoTotal: number;
  anticipo: number;
  periodicidad: number;
  montoAbonos: number;
  folio: string;
  tipoVenta: number;
  beneficiarioId: number;

  constructor(
    private readonly ExamenesService: ExamenesService,
    store: Store<any>,
    private readonly SalesService: SalesService,
    private readonly generalService: GeneralService,
    private readonly armazonService: ArmazonesService,
    private readonly beneficiarioService: BeneficiarioService
    
    ) { 
      store.select('empresa').subscribe(
        e => {
          this.currentEmpresaId = e.empresaId;
          this.nombreEmpresa = e.nombreEmpresa;
        }
      );
    }

  ngOnInit(): void {
    this.ExamenesService.GetFolioByEmpresa(this.currentEmpresaId).subscribe(r => {
      this.folios = r;
    });
    this.tiposVenta = this.SalesService.PopulateTipoVentaList();
    this.generalService.Get('materiales').subscribe(r => this.materiales = r.materiales);
    this.generalService.Get('protecciones').subscribe(r => this.protecciones = r.protecciones);
    this.generalService.Get('lentes').subscribe(r => this.lentes = r.lentes);    
    this.generalService.Get('marcas').subscribe(r => this.marcas = r.marcas);    
    this.generalService.Get('colores').subscribe(r => this.colores= r.colores);    
    this.generalService.Get('tamanios').subscribe(r => this.tamanios = r.tamanios);    
    this.generalService.Get('modelos').subscribe(r => this.modelos = r.modelos);    
    this.beneficiarioService.GetByEmpresa(this.currentEmpresaId).subscribe(r=> this.beneficiarios= r.Beneficiarios);
  }

  async RegisterSale(){
    if (
      !this.marcas ||
      !this.colores ||
      !this.tamanios ||
      !this.modelos ||
      !this.marcaId ||
      !this.colorId ||
      !this.tamanioId ||
      !this.modeloId ||
      !this.descArmazon ||
      !this.lenteId ||
      !this.proteccionId ||
      !this.materialId ||
      !this.fechaExamen ||
      !this.montoTotal ||
      !this.anticipo ||
      !this.periodicidad ||
      !this.montoAbonos ||
      !this.folio||
      !this.tipoVenta ||
      !this.beneficiarioId
    ){
      window.alert('Por favor llena todos los campos');
      return;
    }
    if ((this.anticipo + this.montoAbonos) > this.montoTotal){
      window.alert('Anticipo sumado con el primer abono no puede ser mayor a total de la venta');
      return;
    }
    const armazon = {
      MarcaId: parseInt(this.marcaId.toString()), 
      ColorId: parseInt(this.colorId.toString()),
      TamanioId: parseInt(this.tamanioId.toString()),
      ModeloId: parseInt(this.modeloId.toString()),
      DetalleEnArmazon: this.descArmazon
    };
    const armazonResponse = await this.armazonService.registerAndGetAsync(armazon);
    const sale = {
      Folio: this.folio,
      TotalVenta: this.montoTotal,
      Anticipo: this.anticipo,
      Periodicidad: this.periodicidad,
      Abonos: this.montoAbonos,
      FechaVenta: this.fechaExamen,
      ArmazonId: armazonResponse.ArmazonID,
      MaterialId: parseInt(this.materialId.toString()),
      ProteccionId: parseInt(this.proteccionId.toString()),
      LenteId: parseInt(this.lenteId.toString()),
      TipoVentaId: parseInt(this.tipoVenta.toString()),
      BeneficiarioId: parseInt(this.beneficiarioId.toString())
    };
    this.SalesService.CreateAndGetSale(sale).subscribe(
      r =>{
        window.alert('Venta creada satisfactoriamente con ID: ' + r.ventaID);
        this.montoTotal = undefined;
        this.folio = undefined;
        this.anticipo = undefined;
        this.periodicidad = undefined;
        this.montoAbonos = undefined;
        this.fechaExamen = undefined;
        this.materialId = undefined;
        this.proteccionId = undefined;
        this.lenteId = undefined;
        this.tipoVenta = undefined;
        this.marcaId = undefined;
        this.colorId = undefined;
        this.tamanioId = undefined;
        this.modeloId = undefined;
        this.descArmazon = undefined;
        this.beneficiarioId = undefined;
      },
      err => window.alert(err.error)
      );
  }

}
