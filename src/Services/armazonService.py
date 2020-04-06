from src.Helpers.sql import MySqlHelper
from src.Core.constants import SpArmazon
from src.Helpers.serializer import serialize_data_set


class ArmazonService:
    def __init__(self):
        self.__sql_helper = MySqlHelper()

    def register_and_get(self, args):
        for arg in args:
            if not isinstance(arg, int):
                raise ValueError("Invalid argument for ")
            arg = str(arg)
            # TODO Validate if all IDs exists

        data = self.__sql_helper.sp_get(SpArmazon.Register_and_get, args, True)
        return serialize_data_set(data)

