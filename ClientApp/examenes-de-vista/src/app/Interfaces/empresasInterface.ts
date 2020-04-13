export interface IEmpresas{
    Empresas: IEmpresa[];
}

interface IEmpresa{
    EmpresaID: number;
    NombreEmpresa: string;
    Domicilio: string;
    Telefono: string;
}