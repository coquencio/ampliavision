from src.Core import casosIsosConstants as SpCasosIso
from src.Helpers.sql import MySqlHelper
from src.Helpers.serializer import serialize_data_set
from src.Services.beneficiariosService import BeneficiariosService


class IsoService:
    def __init__(self):
        self.__sql_helper = MySqlHelper()
        self.__beneficiario_service = BeneficiariosService()

    def get_active_ones(self):
        data = self.__sql_helper.sp_get(SpCasosIso.Get_active)
        return serialize_data_set(data, "Casos")

    def get_by_beneficiario(self, beneficiario_id):
        if not isinstance(beneficiario_id, int):
            raise ValueError("Invalid id")
        args = (str(beneficiario_id), )
        data = self.__sql_helper.sp_get(SpCasosIso.Get_by_beneficiario, args)
        if not data:
            return False
        return serialize_data_set(data, "Casos")

    def create_relation(self, beneficiario_id, caso_id):
        if not isinstance(beneficiario_id, int) or not isinstance(caso_id, int):
            raise ValueError("Invalid arguments")
        if not self.__beneficiario_service.validate_existance(beneficiario_id):
            return False
        args = (str(beneficiario_id), str(caso_id))
        self.__sql_helper.sp_set(SpCasosIso.Create_relation, args)
        return True

    def delete_relation(self, relation_id):
        if not isinstance(relation_id, int):
            raise valueError("Invalid arguments")
        args = (str(relation_id),)
        self.__sql_helper.sp_set(SpCasosIso.Delete_relation, args)

