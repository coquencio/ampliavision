export interface IResumenVentas{
    Ventas: IVenta[];
}

export interface IVenta{
    VentaId: number;
    FolioExamen: string;
    Nombres: string;
    Apellido: string;
    Puesto: string;
    RequiereLentes: number,
    comprolentes: number,
    Material: string;
    Proteccion: string;
    Lente: string;
    Total: number;
    Aticipo: number;
    Abonos: number;
    EstaLiquidada: number;
    Fecha: string;
    Tipo: number;
    TotalPagos: number;
    Marca: string;
    Color: string;
}