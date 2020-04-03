from src.Helpers.sql import MySqlHelper
from src.Core.constants import SpOjos
from src.Helpers.serializer import serialize_data_set


class OjoService:
    def __init__(self):
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
