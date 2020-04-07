from src.Core.constants import SpVentas
from src.Helpers.sql import MySqlHelper
from src.Helpers.stringHelper import StringHelper
from src.Helpers.serializer import serialize_data_set
from src.Services.empresaService import EmpresaService

class VentaService:
    def __init__(self):
        self.__sql_helper = MySqlHelper()
        self.__string_helper = StringHelper()
        self.__empresa_service = EmpresaService()

    def register_and_get(self, folio_examen, total_venta, anticipo, periodicidad, abonos, fecha_venta, armazon_id,
                         material_id, proteccion_id, lente_id, beneficiario_id):
        if not isinstance(armazon_id, int) or not isinstance(material_id, int) or not isinstance(proteccion_id, int) \
                or not isinstance(lente_id, int) or not isinstance(beneficiario_id, int):
            raise ValueError("Missing reference from product")

        folio_examen = self.__string_helper.build_string(folio_examen)
        fecha_venta = self.__string_helper.build_string(fecha_venta)
        total_venta = str(total_venta)
        anticipo = str(anticipo)
        periodicidad = str(periodicidad)
        abonos = str(abonos)
        armazon_id = str(armazon_id)
        material_id = str(material_id)
        proteccion_id = str(proteccion_id)
        lente_id = str(lente_id)
        beneficiario_id = str(beneficiario_id)
        args = (folio_examen, total_venta, anticipo, periodicidad, abonos, fecha_venta, armazon_id, material_id,
                proteccion_id, lente_id, beneficiario_id)
        data = self.__sql_helper.sp_get(SpVentas.Register_and_get, args, True)
        return serialize_data_set(data)

    def get_summary_by_company(self, empresa_id):
        if not isinstance(empresa_id, int):
            raise ValueError("Invalid id")
        if not self.__empresa_service.validate_empresa(empresa_id):
            return False
        args =(str(empresa_id), )
        data = self.__sql_helper.sp_get(SpVentas.Get_summary_by_empresa, args)
        if not data:
            return False
        print(data)
        data = serialize_data_set(data, "Ventas")
        return data


