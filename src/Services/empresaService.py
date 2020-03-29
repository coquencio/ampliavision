from src.Helpers.sql import MySqlHelper
from src.Core.constants import SpEmpresas


class EmpresaService:
    def __init__(self):
        self.__sql_helper = MySqlHelper()

    def create_empresa(self, description):
        if not description:
            raise ValueError("Missing description")

        args = (description)
        self.__sql_helper.sp_set(SpEmpresas.Register, args)
