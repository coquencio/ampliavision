from src.Helpers.sql import MySqlHelper
from src.Core import chartsConstants as SpCharts
from src.Services.empresaService import EmpresaService
from src.Helpers.serializer import serialize_data_set
from src.Helpers.stringHelper import StringHelper


class ChartService:
    def __init__(self):
        self.__sql_helper = MySqlHelper()
        self.__empresa_servicio = EmpresaService()
        self.__string_helper = StringHelper()
        self.dictionary = {
            "ventas": SpCharts.chart1,
            "enfermedades": SpCharts.chart2,
            "isos": SpCharts.chart3,
        }

    def get_chart(self, empresa_id, chart):
        chart = self.dictionary[chart]
        empresa_id = (str(empresa_id), )
        data = self.__sql_helper.sp_get(chart, empresa_id)
        return serialize_data_set(data)
