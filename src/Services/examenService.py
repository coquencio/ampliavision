from src.Helpers.sql import MySqlHelper
from src.Core.constants import SpExamen
from src.Helpers.stringHelper import StringHelper


class ExamenService:
    def __init__(self):
        self.__sql_helper = MySqlHelper()
        self.__string_helper = StringHelper()

    def register(self, folio, beneficiario_id, anterior_id, total_id, adaptacion_id, fecha_examen, requiere_lentes, compro_lentes, enfermedad_id, observaciones):
        if not int(requiere_lentes) or not int(compro_lentes):
            raise ValueError("Missing values")

        folio = self.__string_helper.build_string(folio)
        fecha_examen = self.__string_helper.build_string(fecha_examen)
        if observaciones:
            observaciones = self.__string_helper.build_string(observaciones)
        args = (folio, beneficiario_id, anterior_id, total_id, adaptacion_id, fecha_examen, requiere_lentes, compro_lentes, enfermedad_id, observaciones)
        self.__sql_helper.sp_set(SpExamen.Register, args)
