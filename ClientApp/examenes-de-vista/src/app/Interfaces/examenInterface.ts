export interface IResumenExamenes{
    Examenes: IResumenExamen[];
}

interface IResumenExamen{
    folio: string;
    BeneficiarioId: number;
    Nombres: string;
    Apellidopaterno: string;
    ocupacion: string;
    enfermedad: string;
    edad: number;
    requiereLentes: number;
}