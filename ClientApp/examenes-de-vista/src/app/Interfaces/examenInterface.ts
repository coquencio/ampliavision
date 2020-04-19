export interface IResumenExamenes{
    Examenes: IResumenExamen[];
}

interface IResumenExamen{
    folio: string;
    Nombres: string;
    Apellidopaterno: string;
    ocupacion: string;
    enfermedad: string;
    edad: number;
    requiereLentes: number;
}