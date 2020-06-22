export interface IIsos{
    Casos: ICasos[];
}

interface ICasos{
    CasoID: number;
    Descripcion: string;
    EstaActivo: number;
}

export interface IIsosBeneficiario{
    Casos: IRelaciones[];
}
interface IRelaciones{
    CasoPorBeneficiarioID: number;
    CasoID: number;
    Descripcion: string;
}
