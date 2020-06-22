export interface IGeneral{
    ID: number;
    Descripcion: string;
    EstaActivo: number;
}

export interface IMarca extends IGeneral{
    MarcaID: number;
}
export interface IColor extends IGeneral{
    ColorID: number;
}
export interface ITamanio extends IGeneral{
    TamanioID: number;
}
export interface IModelo extends IGeneral{
    ModeloID: number;
}
export interface IMaterial extends IGeneral{
    MaterialID: number;
}
export interface IProteccion extends IGeneral{
    ProteccionID: number;
}
export interface ILente extends IGeneral{
    LenteID: number;
}