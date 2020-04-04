from src.Helpers.sql import MySqlHelper
from src.Helpers.serializer import serialize_data_set
from src.Helpers.stringHelper import StringHelper
from src.Core.constants import *


class GeneralService:
    def __init__(self, entity):
        self.__sql_helper = MySqlHelper()
        self.__string_helper = StringHelper()
        self.__constant = self.__entity_helper(entity)
        self.dictionary = {
            "marcas": SpMarcas,
            "colores": SpColores,
            "tamanios": SpTamanios,
            "modelos": SpModelos,
            "armazones": SpArmazon,
            "materiales": SpMaterial,
            "protecciones": SpProteccion,
            "lentes": SpLentes,
        }

    def register(self, descripcion):
        if not descripcion:
            raise ValueError("Missing description")
        descripcion = self.__string_helper.build_string(descripcion)
        args = (descripcion, )
        self.__sql_helper.sp_set(self.__constant.Register, args)

    def active_status(self, primary_key, is_deactivation=False):
        if not primary_key:
            raise ValueError("Missing argument")
        if not isinstance(primary_key, int):
            raise ValueError("Invalid type")
        primary_key = str(primary_key)
        args = (primary_key, )
        if is_deactivation:
            self.__sql_helper.sp_set(self.__constant.Deactivate, args)
        else:
            self.__sql_helper.sp_set(self.__constant.Activate, args)

    def get(self, key):
        return serialize_data_set(self.__sql_helper.sp_get(self.__constant.GetAll), key)

    def __entity_helper(self, entity):
        if not isinstance(entity, str):
            raise ValueError("Invalid type")

        return self.dictionary[entity]







