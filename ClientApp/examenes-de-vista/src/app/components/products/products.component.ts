import { Component, OnInit, ViewChild, ElementRef } from '@angular/core';
import { IMarca, IColor, ITamanio, IModelo, IMaterial, IProteccion, ILente, IGeneral } from 'src/app/Interfaces/generalInterface';
import { GeneralService } from 'src/app/services/general/general.service';
import { IsoService } from 'src/app/services/isos/iso.service';
import { IIsos } from 'src/app/Interfaces/isoInterface';

@Component({
  selector: 'app-products',
  templateUrl: './products.component.html',
  styleUrls: ['./products.component.css']
})
export class ProductsComponent implements OnInit {

  constructor(
    private generalService: GeneralService,
    private isoService: IsoService,
    ) { }
  @ViewChild('closeModal') private closeModal: ElementRef;
  marcas: IMarca[];
  colores: IColor[];
  tamanios: ITamanio[];
  modelos: IModelo[];
  materiales: IMaterial[];
  protecciones: IProteccion[];
  lentes: ILente[];
  currentName: string;
  inTable: IGeneral[]; 
  descripcion: string;
  casos: IIsos;
  isGeneral: boolean;

  ngOnInit(): void {
    this.isGeneral = true;
    this.getGeneralItems();
  }

  private getGeneralItems(){
    this.generalService.Get('marcas').subscribe(
      r => {
        this.marcas = r.marcas;
        if(this.currentName === 'marcas'){
          this.SetCurrentObject('marcas')
        } 
      }
    );
    this.generalService.Get('colores').subscribe(
      r =>{ this.colores = r.colores;
        if(this.currentName === 'colores'){
          this.SetCurrentObject('colores')
        }
      }
    );
    this.generalService.Get('tamanios').subscribe(
      r => {this.tamanios = r.tamanios;
        if(this.currentName === 'tamaños'){
          this.SetCurrentObject('tamaños')
        }
      }
    );
    this.generalService.Get('modelos').subscribe(
      r => {
        this.modelos = r.modelos;
        if(this.currentName === 'modelos'){
          this.SetCurrentObject('modelos')
        }
      }
    );
    this.generalService.Get('materiales').subscribe(
      r => {this.materiales= r.materiales; 
        if(this.currentName === 'materiales'){
          this.SetCurrentObject('materiales')
        }}
    );
    this.generalService.Get('protecciones').subscribe(
      r => {this.protecciones = r.protecciones; 
        if(this.currentName === 'protecciones'){
          this.SetCurrentObject('protecciones')
        }
      }
    );
    this.generalService.Get('lentes').subscribe(
      r =>{ this.lentes = r.lentes;
        if(this.currentName === 'lentes'){
          this.SetCurrentObject('lentes')
        } }
    );
    this.isoService.GetIsos().subscribe(
      r=> this.casos = r
    );
  }

  SetCurrentObject(name: string){
    this.isGeneral = true;
    this.currentName = name;
    this.inTable = this.getType(name);
  }

  private getType(name: string): IGeneral[]{
    switch (name){
      case ('marcas'):
       return this.marcas.map(m=> {return <IGeneral>{ID : m.MarcaID, Descripcion: m.Descripcion }});
      case ('materiales'):
       return this.materiales.map(m=> {return <IGeneral>{ID : m.MaterialID, Descripcion: m.Descripcion }});
      case ('colores'):
        return this.colores.map(m=> {return <IGeneral>{ID : m.ColorID, Descripcion: m.Descripcion }});
      case ('tamaños'):
        return this.tamanios.map(m=> {return <IGeneral>{ID : m.TamanioID, Descripcion: m.Descripcion }});
      case ('modelos'):
          return this.modelos.map(m=> {return <IGeneral>{ID : m.ModeloID, Descripcion: m.Descripcion }});
      case ('protecciones'):
        return this.protecciones.map(m=> {return <IGeneral>{ID : m.ProteccionID, Descripcion: m.Descripcion }});;
      case ('lentes'):
        return this.lentes.map(m=> {return <IGeneral>{ID : m.LenteID, Descripcion: m.Descripcion }});;
    }
  }

  Create(){
    if (this.descripcion === '' || this.descripcion === undefined){
      window.alert('Por favor introduce una descripción');
      return;
    }
    const name = this.currentName === 'tamaños'? 'tamanios' : this.currentName;
    this.generalService.Create(name, this.descripcion).subscribe(
      ()=> {
        this.getGeneralItems();
        this.descripcion = '';
        window.alert('Registro añadido satisfactoriamente en ' + this.currentName);
        this.closeModal.nativeElement.click();
      }
    );
  }

  Deactivate(id: number){
    if(confirm('¿Deseas desactivar un registro perteneciente a ' + this.currentName + '?'))
    {
      const name = this.currentName === 'tamaños'? 'tamanios' : this.currentName;
      this.generalService.Deactivate(name, id).subscribe(
        r => {
          this.getGeneralItems();
          window.alert(r);
        }
      );
    }
  }

  switchToIso(){
    this.isGeneral = false;
    this.currentName = 'Casos Iso 9000';
  }

  
  
}
