import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { Store } from '@ngrx/store';
import { IBeneficiario } from 'src/app/Interfaces/beneficiariosInterface';
import { IFolios } from 'src/app/Interfaces/foliosInterface';
import { IColor, ILente, IMarca, IMaterial, IModelo, IProteccion, ITamanio } from 'src/app/Interfaces/generalInterface';
import { IOption } from 'src/app/Interfaces/optionsInterface';
import { ArmazonesService } from 'src/app/services/armazones/armazones.service';
import { BeneficiarioService } from 'src/app/services/beneficiarios/beneficiario.service';
import { GeneralService } from 'src/app/services/general/general.service';
import { SalesService } from 'src/app/services/sales/sales.service';
import { ExamenesService } from 'src/app/services/examenes/examenes.service';

@Component({
  selector: 'app-update-sale',
  templateUrl: './update-sale.component.html',
  styleUrls: ['./update-sale.component.css']
})
export class UpdateSaleComponent implements OnInit {
  folios: IFolios = {
    Folios: []
  };

  @Output() ReloadParent = new EventEmitter<boolean>();

  ventaId: number;
  currentEmpresaId: number;
  nombreEmpresa: string;
  tiposVenta: IOption[];
  armazones: any;
  materiales: IMaterial[] = [];
  protecciones: IProteccion[] = [];
  lentes: ILente[] = [];
  //For armazón
  marcas: IMarca[] = [];
  colores: IColor[] = [];
  tamanios:ITamanio[] = [];
  modelos: IModelo[] = [];
  beneficiarios: IBeneficiario[] = [];

  //For sale
  isSelectorDisabled: boolean = false;
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
  folio: string;
  tipoVenta: number;
  beneficiarioId: number;
  numeroPagos: number;

  loadingRegis: boolean = false;
  isValidSaleId : boolean = false;

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
  OnFolioChange(){
    this.isSelectorDisabled = (this.folio !== undefined && this.folio !== null && this.folio !== '')
    if (this.isSelectorDisabled){
      this.ExamenesService.GetBeneficiarioIdByFolio(this.folio).subscribe(
        r=> {
          this.beneficiarioId = r.BeneficiarioID;
        }
      );
    }
  }

  async RegisterSale(){
    if (this.ventaId === undefined || this.ventaId === null || this.ventaId == 0){
      window.alert('Introduce un ID válido de venta');
      return;
    }
    if (this.marcaId === undefined || this.marcaId === null){
      window.alert('Favor de seleccionar una marca antes');
      return;
    }
    if (this.colorId === undefined || this.colorId=== null){
      window.alert('Favor de seleccionar un color antes');
      return;
    }
    if (this.tamanioId === undefined || this.tamanioId === null){
      window.alert('Favor de seleccionar un tamaño antes');
      return;
    }
    if (this.modeloId === undefined || this.modeloId === null){
      window.alert('Favor de seleccionar un modelo antes');
      return;
    }if (this.lenteId === undefined || this.lenteId === null){
      window.alert('Favor de seleccionar un lente antes');
      return;
    }if (this.descArmazon === undefined || this.descArmazon === null){
      window.alert('Favor introduce una descripción de armazón antes');
      return;
    }if (this.proteccionId === undefined || this.proteccionId === null){
      window.alert('Favor de seleccionar una protección antes');
      return;
    }if (this.fechaExamen === undefined || this.fechaExamen === null){
      window.alert('Favor de seleccionar una fecha antes');
      return;
    }if (this.materialId === undefined || this.materialId === null){
      window.alert('Favor de seleccionar un material antes');
      return;
    }if (this.montoTotal === undefined || this.montoTotal === null){
      window.alert('Favor de introduce un monto total antes');
      return;
    }if (this.anticipo === undefined || this.anticipo === null){
      window.alert('Favor de introduce un anticipo antes');
      return;
    }if (this.periodicidad === undefined || this.periodicidad === null){
      window.alert('Favor de introduce una periodicidad antes');
      return;
    }if (this.numeroPagos === undefined || this.numeroPagos === null){
      window.alert('Favor de introduce un numero de pagos antes');
      return;
    }if (this.tipoVenta === undefined || this.tipoVenta === null){
      window.alert('Favor de seleccionar un tipo de venta antes');
      return;
    }if (this.beneficiarioId === undefined || this.beneficiarioId === null){
      window.alert('Favor de seleccionar un empleado antes');
      return;
    }
    this.loadingRegis = true;
    const armazon = {
      MarcaId: parseInt(this.marcaId.toString()), 
      ColorId: parseInt(this.colorId.toString()),
      TamanioId: parseInt(this.tamanioId.toString()),
      ModeloId: parseInt(this.modeloId.toString()),
      DetalleEnArmazon: this.descArmazon
    };
    const armazonResponse = await this.armazonService.registerAndGetAsync(armazon);
    const sale = {
      VentaId: this.ventaId,
      Folio: !this.folio? null: this.folio,
      TotalVenta: this.montoTotal,
      Anticipo: this.anticipo,
      Periodicidad: this.periodicidad,
      NumeroPagos: this.numeroPagos,
      FechaVenta: this.fechaExamen,
      ArmazonId: armazonResponse.ArmazonID,
      MaterialId: parseInt(this.materialId.toString()),
      ProteccionId: parseInt(this.proteccionId.toString()),
      LenteId: parseInt(this.lenteId.toString()),
      TipoVentaId: parseInt(this.tipoVenta.toString()),
      BeneficiarioId: parseInt(this.beneficiarioId.toString())
    };
    this.SalesService.UpdateSale(sale).subscribe(
      r =>{
        this.loadingRegis = false;
        window.alert('Venta Actualizada satisfactoriamente');
        this.ReloadParent.emit(true);
        this.montoTotal = undefined;
        this.folio = undefined;
        this.anticipo = undefined;
        this.periodicidad = undefined;
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
        this.isSelectorDisabled = false;
        this.numeroPagos = undefined;
        this.ventaId = undefined;
        this.isValidSaleId = false;
      },
      err => {
        window.alert(err.error);
        this.loadingRegis = false;
      }
      );
  }

  GetSaleDetails(){
    if (this.ventaId === 0 || !this.ventaId){
      window.alert("Introduce un Id válido");
      this.isValidSaleId = false;
      return;
    }
    this.SalesService.GetSaleDetails(this.ventaId, this.currentEmpresaId).subscribe(
      r=> {
        if (!r){
          this.ventaId = undefined;
          window.alert("No se ha encontrado una venta con el Id " + this.ventaId +" asociada a la empresa " + this.nombreEmpresa);
          this.isValidSaleId = false;
        }
        else{
          this.montoTotal = r.TotalVenta;
          this.folio = r.FolioExamen;
          this.anticipo = r.Anticipo;
          this.periodicidad = r.PeriodicidadDias;
          this.fechaExamen = r.fechaVenta;
          this.materialId = r.MaterialID;
          this.proteccionId = r.ProteccionID;
          this.lenteId = r.LenteID;
          this.tipoVenta = r.TipoVentaID;
          this.marcaId = r.MarcaID;
          this.colorId = r.ColorID;
          this.tamanioId = r.TamanioID;
          this.modeloId = r.ModeloID;
          this.descArmazon = r.DetalleEnArmazon;
          this.beneficiarioId = r.BeneficiarioID;
          this.numeroPagos = r.NumeroPagos;
          this.isValidSaleId = true;
        }
      }
    );
  }

}
