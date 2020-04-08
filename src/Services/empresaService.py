from src.Helpers.sql import MySqlHelper
from src.Core.constants import SpEmpresas
from src.Helpers.serializer import serialize_data_set
from src.Helpers.stringHelper import StringHelper


class EmpresaService:
    def __init__(self):
        self.__sql_helper = MySqlHelper()
        self.__string_helper = StringHelper()

    def create_empresa(self, nombre, domicilio, telefono):
        if not nombre:
            raise ValueError("Missing names")
        nombre = self.__string_helper.build_string(nombre)
        domicilio = self.__string_helper.build_string(domicilio)
        telefono = self.__string_helper.build_string(telefono)
        args = (nombre, domicilio, telefono)
        self.__sql_helper.sp_set(SpEmpresas.Register, args)

    def validate_empresa(self, empresa_id):
        empresa_id = int(empresa_id)
        args = (str(empresa_id), )
        validation = self.__sql_helper.sp_get(SpEmpresas.Validate, args, True)
        if validation['count(*)'] == 1:
            return True

        return False

    def get_empresas(self):
        empresas = self.__sql_helper.sp_get(SpEmpresas.Get_all)
        return serialize_data_set(empresas, "Empresas")

