export interface IBeneficiarios{
    Beneficiarios: IBeneficiario[];
}

interface IBeneficiario{
    BeneficiarioID: number;
    Nombres: string;
    ApellidoPaterno: string;
    ApellidoMaterno: string;
    FechaNacimiento: string;
    Ocupacion: string;
    EmpresaID: number;
}