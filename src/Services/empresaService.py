from src.Helpers.sql import MySqlHelper
from src.Core import empresasConstants as SpEmpresas, reglasConstants
from src.Helpers.serializer import serialize_data_set
from src.Helpers.stringHelper import StringHelper


class EmpresaService:
    def __init__(self):
        self.__sql_helper = MySqlHelper()
        self.__string_helper = StringHelper()

    def create_empresa(self, data):
        nombre = data['Nombre']
        domicilio = data['Domicilio']
        telefono = data['Telefono']
        if not nombre:
            raise ValueError("Missing names")
        nombre = self.__string_helper.build_string(nombre)
        domicilio = self.__string_helper.build_string(domicilio)
        telefono = self.__string_helper.build_string(telefono)
        args = (nombre, domicilio, telefono)
        self.__sql_helper.sp_set(SpEmpresas.Register, args)

    def update_empresa(self,empresa_id, data):
        nombre = data['NombreEmpresa']
        domicilio = data['Domicilio']
        telefono = data['Telefono']
        if not nombre:
            raise ValueError("Missing names")
        nombre = self.__string_helper.build_string(nombre)
        domicilio = self.__string_helper.build_string(domicilio)
        telefono = self.__string_helper.build_string(telefono)
        args = (str(empresa_id), nombre, domicilio, telefono)
        self.__sql_helper.sp_set(SpEmpresas.Update, args)

    def validate_empresa(self, empresa_id):
        empresa_id = int(empresa_id)
        args = (str(empresa_id), )
        validation = self.__sql_helper.sp_get(SpEmpresas.Validate, args, True)
        if validation['count(*)'] == 1:
            return True

        return False

    def get_empresas(self, token):
        empresas = self.__sql_helper.sp_get(SpEmpresas.Get_all)
        empresas = self.__filter_empresas(empresas, token)
        return serialize_data_set(empresas, "Empresas")

    def get_by_folio(self, folio):
        folio = self.__string_helper.build_string(folio)
        args = (folio, )
        data = self.__sql_helper.sp_get(SpEmpresas.Get_by_folio, args, True)
        if not data:
            return "Empresa not found"
        return serialize_data_set(data)

    def get_by_venta(self, venta_id):
        args = (str(venta_id), )
        data = self.__sql_helper.sp_get(SpEmpresas.Get_by_sale, args, True)
        if not data:
            return "Empresa not found"
        return serialize_data_set(data)

    def __filter_empresas(self, empresas, token):
        restricted = self.__load_user_restrictions(token)
        if restricted:
            founded = []
            for empresa in empresas:
                retriction = {"Empresa": empresa["NombreEmpresa"]}
                if  retriction in restricted:
                    founded.append(empresa)
            if founded:
                for item in founded:
                    empresas.remove(item)

        return empresas

    def __load_user_restrictions(self, token):
        token = self.__string_helper.build_string(token)
        args = (token, )
        return self.__sql_helper.sp_get(reglasConstants.Get_Empresas_restrictions, args)

