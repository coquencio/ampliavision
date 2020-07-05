from src.Helpers.sql import MySqlHelper
from src.Core import ojosConstants as SpOjos
from src.Helpers.serializer import serialize_data_set
from src.Helpers.stringHelper import StringHelper


def are_characters_valid(argument):
    if isinstance(argument, int):
        return True
    allowed_characters = "1234567890-.+"
    for letter in argument:
        if not letter in allowed_characters:
            return False
    return True


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
        self.__string_helper = StringHelper()

    def register_and_get_single(self, lado, data):
        lado_id =self.lado_dictionary[lado]
        esfera = data['Esfera']
        cilindro = data['Cilindro']
        eje = data['Eje']
        adiccion = data['Adiccion']

        args = (lado_id, esfera, cilindro, eje, adiccion)
        for arg in args:
            if not are_characters_valid(arg):
                raise ValueError("Sólo pueden añadirse datos númericos")
        esfera = self.__string_helper.build_string(str(esfera))
        cilindro= self.__string_helper.build_string(str(cilindro))
        eje = self.__string_helper.build_string(str(eje))
        adiccion = self.__string_helper.build_string(str(adiccion))

        args = (lado_id, esfera, cilindro, eje, adiccion)
        data = serialize_data_set(self.__sql_helper.sp_get(SpOjos.Register_and_get_Single, args, True))
        return data

    def register_and_get_pair(self, data, tipo):
        tipo_id = self.tipo_dictionary[tipo]

        izquierdo_id = data['IzquierdoId']
        derecho_id = data['DerechoId']
        dp_lejos = data['DpLejos']
        obl = data['Obl']
        args = (izquierdo_id, derecho_id, tipo_id, dp_lejos, obl)
        for arg in args:
            if not are_characters_valid(arg):
                raise ValueError("Sólo pueden añadirse datos númericos")

        dp_lejos = self.__string_helper.build_string(str(dp_lejos))
        obl = self.__string_helper.build_string(str(obl))
        args = (izquierdo_id, derecho_id, tipo_id, dp_lejos, obl)

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
