from src.Helpers.sql import MySqlHelper
from src.Core.constants import SpArmazon
from src.Helpers.serializer import serialize_data_set
from src.Helpers.stringHelper import StringHelper


class ArmazonService:
    def __init__(self):
        self.__sql_helper = MySqlHelper()
        self.__string_helper = StringHelper()

    def register_and_get(self, args, detalle):
        for arg in args:
            if not isinstance(arg, int):
                raise ValueError("Invalid argument for ")
            # TODO Validate if all IDs exists

        if not isinstance(detalle, str):
            raise ValueError("Invalid argument for detalle")
        detalle = self.__string_helper.build_string(detalle)
        arguments = list(args)
        arguments.append(detalle)
        args = tuple(arguments)
        data = self.__sql_helper.sp_get(SpArmazon.Register_and_get, args, True)
        return serialize_data_set(data)

    def get_summary(self, venta_id):
        if not isinstance(venta_id, int):
            raise ValueError("Invalid Id")
        args = (str(venta_id), )
        data = self.__sql_helper.sp_get(SpArmazon.Get_summary, args, True)
        if not data:
            return False
        return serialize_data_set(data)

