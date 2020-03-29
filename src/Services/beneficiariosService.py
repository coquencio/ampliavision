from src.Helpers.sql import MySqlHelper
from src.Core.constants import SpBeneficiario
from src.Services.empresaService import EmpresaService
class BeneficiariosService:
    def __init__(self):
        self.__sql_helper = MySqlHelper()
        self.__empresa_servicio = EmpresaService()

    def create_beneficiario(self, nombres, ape_pat, ape_mat, fecha_nac, ocupacion, empresa_id):

        if not self.__empresa_servicio.validate_empresa(empresa_id):
            raise KeyError("Empresa no encontrada")

        if not nombres or not ape_mat or not ape_pat or not fecha_nac or not ocupacion:
            raise ValueError("Datos faltantes")

        nombres = "'"+nombres+"'"
        ape_pat = "'" + ape_pat + "'"
        ape_mat = "'" + ape_mat + "'"
        fecha_nac = "'" + fecha_nac + "'"
        ocupacion = "'" + ocupacion + "'"
        empresa_id = str(empresa_id)
        args = (nombres, ape_pat, ape_mat, fecha_nac, ocupacion, empresa_id)
        self.__sql_helper.sp_set(SpBeneficiario.Register, args)


