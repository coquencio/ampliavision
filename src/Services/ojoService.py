from src.Helpers.sql import MySqlHelper
from src.Core.constants import SpOjos
from src.Helpers.serializer import serialize_data_set


class OjoService:
    def __init__(self):
        self.lado_dictionary = {
            "izquierdo": 1,
            "derecho": 2
        }
        self.tipo_dictionary = {
            "anterior": 1,
            "total": 2,
            "adaptacion": 3,
        }
        self.__sql_helper = MySqlHelper()

    def register_and_get_single(self, lado_id, esfera, cilindro, eje, adiccion):
        args = (lado_id, esfera, cilindro, eje, adiccion)
        for arg in args:
            arg = str(arg)
            if not int(arg):
                raise ValueError("Missing arguments or invalid data type")

        data = serialize_data_set(self.__sql_helper.sp_get(SpOjos.Register_and_get_Single, args, True))
        return data

    def register_and_get_pair(self, izquierdo_id, derecho_id, tipo_id, dp_lejos, obl):
        args = (izquierdo_id, derecho_id, tipo_id, dp_lejos, obl)
        for arg in args:
            arg = str(arg)
            if not int(arg):
                raise ValueError("Missing arguments or invalid data type")
        data = serialize_data_set(self.__sql_helper.sp_get(SpOjos.Register_and_get_pair, args, True))
        return data

    def get_single(self, ojo_id):
        if not isinstance(ojo_id, int):
            raise ValueError("Invalid ojo id")
        args = (ojo_id, )
        data = self.__sql_helper.sp_get(SpOjos.Get_single, args, True)
        if not data:
            return False

        return serialize_data_set(data)

    def get_pair(self, pair_id):
        if not isinstance(pair_id, int):
            raise ValueError("Invalid ojo id")
        args = (pair_id,)
        data = self.__sql_helper.sp_get(SpOjos.Get_pair, args, True)
        if not data:
            return False

        return serialize_data_set(data)
