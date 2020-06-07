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
                         material_id, proteccion_id, lente_id, beneficiario_id, tipo_id):
        if not isinstance(armazon_id, int) or not isinstance(material_id, int) or not isinstance(proteccion_id, int) \
                or not isinstance(lente_id, int) or not isinstance(beneficiario_id, int)\
                or not isinstance(tipo_id, int):
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
        tipo_id =  str(beneficiario_id)
        args = (folio_examen, total_venta, anticipo, periodicidad, abonos, fecha_venta, armazon_id, material_id,
                proteccion_id, lente_id, beneficiario_id, tipo_id)
        data = self.__sql_helper.sp_get(SpVentas.Register_and_get, args, True)
        return serialize_data_set(data)

    def get_summary_by_company(self, empresa_id):
        if not isinstance(empresa_id, int):
            raise ValueError("Invalid id")
        if not self.__empresa_service.validate_empresa(empresa_id):
            return False
        args = (str(empresa_id), )
        data = self.__sql_helper.sp_get(SpVentas.Get_summary_by_empresa, args)
        if not data:
            return False
        data = serialize_data_set(data, "Ventas")
        return data

    def payment_register(self, venta_id, monto, fecha):
        if not isinstance(venta_id, int):
            raise ValueError("Invalid venta id")
        if not isinstance(monto, float):
            raise ValueError("Invalid value for monto")
        if not isinstance(fecha, str):
            raise ValueError("Invalid value for fecha")
        if not self.__can_make_payment(venta_id, monto):
            raise ValueError("No se pudo registrar abono, saldo negativo")

        fecha = self.__string_helper.build_string(fecha)
        args = (venta_id, monto, fecha)
        self.__sql_helper.sp_set(SpVentas.Bill_registration, args)

    def get_payments_by_venta(self, venta_id):
        if not isinstance(venta_id, int):
            raise ValueError("Invalid id")
        args = (str(venta_id), )
        data = self.__sql_helper.sp_get(SpVentas.Get_abono_by_venta,  args)
        if not data:
            return False
        return serialize_data_set(data, "Abonos de la venta "+str(venta_id))

    def __can_make_payment(self, venta_id, monto):
        args = (venta_id, )
        data = self.__sql_helper.sp_get(SpVentas.Get_total_of_sale, args, True)
        if not data:
            raise ValueError("Venta inexistente")
        total_venta = data['total']
        data = self.__sql_helper.sp_get(SpVentas.Get_abono_sum_by_venta, args, True)
        if not data:
            return True
        total_abonos = float(data['sum(Monto)'])
        total_abonos = total_abonos + monto
        if total_venta < total_abonos:
            return False
        return True
