from src.Helpers.sql import MySqlHelper
from src.Core.constants import SpBeneficiario
from src.Services.empresaService import EmpresaService
from src.Helpers.serializer import serialize_data_set
from src.Helpers.stringHelper import StringHelper


class BeneficiariosService:
    def __init__(self):
        self.__sql_helper = MySqlHelper()
        self.__empresa_servicio = EmpresaService()
        self.__string_helper = StringHelper()

    def create_beneficiario(self, empresa_id, data):
        nombres = data['Nombres']
        ape_pat = data['ApellidoPaterno']
        ape_mat = data['ApellidoMaterno']
        fecha_nac = data['FechaNacimiento']
        ocupacion = data['Ocupacion']

        if not self.__empresa_servicio.validate_empresa(empresa_id):
            raise KeyError("Empresa no encontrada")

        if not nombres or not ape_mat or not ape_pat or not fecha_nac or not ocupacion:
            raise ValueError("Datos faltantes")

        nombres = self.__string_helper.build_string(nombres)
        ape_pat = self.__string_helper.build_string(ape_pat)
        ape_mat = self.__string_helper.build_string(ape_mat)
        fecha_nac = self.__string_helper.build_string(fecha_nac)
        ocupacion = self.__string_helper.build_string(ocupacion)
        empresa_id = str(empresa_id)
        args = (nombres, ape_pat, ape_mat, fecha_nac, ocupacion, empresa_id)
        self.__sql_helper.sp_set(SpBeneficiario.Register, args)

    def get_beneficiario_by_empresa(self, empresa_id):
        if not self.__empresa_servicio.validate_empresa(empresa_id):
            raise KeyError("Empresa no encontrada")

        args = (str(empresa_id), )
        data = self.__sql_helper.sp_get(SpBeneficiario.get_by_empresa, args)
        return serialize_data_set(data, "Beneficiarios")

    def validate_existance(self, beneficiario_id):
        if not isinstance(beneficiario_id, int):
            return False
        args = (str(beneficiario_id), )

        data = self.__sql_helper.sp_get(SpBeneficiario.Validate, args, True)
        if data['count'] == 0:
            return False
        return True

    def get_names_by_id(self, beneficiario_id):
        if not isinstance(beneficiario_id, int):
            raise ValueError("Id inválido")
        args = (str(beneficiario_id), )
        data = self.__sql_helper.sp_get(SpBeneficiario.get_name_by_id, args, True)
        return serialize_data_set(data, "Nombres")

    def update_beneficiario(self, beneficiario_id, data):
        nombres = data['Nombres']
        ape_pat = data['ApellidoPaterno']
        ape_mat = data['ApellidoMaterno']
        fecha_nac = data['FechaNacimiento']
        ocupacion = data['Ocupacion']

        if not nombres or not ape_mat or not ape_pat or not fecha_nac or not ocupacion:
            raise ValueError("Datos faltantes")

        nombres = self.__string_helper.build_string(nombres)
        ape_pat = self.__string_helper.build_string(ape_pat)
        ape_mat = self.__string_helper.build_string(ape_mat)
        fecha_nac = self.__string_helper.build_string(fecha_nac)
        ocupacion = self.__string_helper.build_string(ocupacion)
        beneficiario_id = str(beneficiario_id)
        args = (beneficiario_id, nombres, ape_pat, ape_mat, fecha_nac, ocupacion)
        self.__sql_helper.sp_set(SpBeneficiario.Update, args)
