from src.Core.constants import SpVentas
from src.Helpers.sql import MySqlHelper
from src.Helpers.stringHelper import StringHelper
from src.Helpers.serializer import serialize_data_set
from src.Services.empresaService import EmpresaService
from src.Services.usersService import UsersService


class VentaService:
    def __init__(self):
        self.__sql_helper = MySqlHelper()
        self.__string_helper = StringHelper()
        self.__empresa_service = EmpresaService()
        self.__user_service = UsersService()

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

    def payment_register(self, venta_id, monto, fecha, name):
        if not isinstance(venta_id, int):
            raise ValueError("Invalid venta id")
        if not isinstance(monto, float) and not isinstance(monto, int) :
            raise ValueError("Invalid value for monto")
        if not isinstance(fecha, str):
            raise ValueError("Invalid value for fecha")
        if not isinstance(name, str):
            raise ValueError("Invalid value for name")
        if not self.__can_make_payment(venta_id, monto):
            raise ValueError("No se pudo registrar abono, saldo negativo")

        fecha = self.__string_helper.build_string(fecha)
        name = self.__string_helper.build_string(name)
        args = (venta_id, monto, fecha, name)
        self.__sql_helper.sp_set(SpVentas.Bill_registration, args)

    def get_payments_by_venta(self, venta_id):
        if not isinstance(venta_id, int):
            raise ValueError("Invalid id")
        args = (str(venta_id), )
        data = self.__sql_helper.sp_get(SpVentas.Get_abono_by_venta,  args)
        if not data:
            return False
        return serialize_data_set(data)

    def __can_make_payment(self, venta_id, monto):
        args = (venta_id, )
        data = self.__sql_helper.sp_get(SpVentas.Get_total_of_sale, args, True)
        if not data:
            raise ValueError("Venta inexistente")
        total_venta = data['total']
        data = self.__sql_helper.sp_get(SpVentas.Get_abono_sum_by_venta, args, True)
        if not data['sum(Monto)']:
            return True

        total_abonos = float(data['sum(Monto)'])
        total_abonos = total_abonos + monto
        if total_venta < total_abonos:
            return False
        return True

    def delete_payment(self, payment_id, token):
        if not isinstance(payment_id, int):
            raise ValueError("Id inválido")
        if not self.__user_service.is_admin(token):
            raise ValueError("No tienes los permisos para realizar esta acción")

        args = (str(payment_id),)
        self.__sql_helper.sp_set(SpVentas.Delete_abono, args)

    def is_folio_repeated(self, folio):
        folio = self.__string_helper.build_string(folio);
        args = (folio, )
        data = self.__sql_helper.sp_get(SpVentas.Validate_folio, args, True);
        if data['count(*)'] == 0:
            return False
        return True

    def paid_switch(self, venta_id, marking_as_paid=True):
        if not isinstance(venta_id, int) or venta_id == 0:
            raise ValueError("Invalid Id")
        args = (str(venta_id), )
        if marking_as_paid:
            self.__sql_helper.sp_set(SpVentas.Mark_as_paid, args)
        else:
            self.__sql_helper.sp_set(SpVentas.Mark_as_unpaid, args)

    def __can_be_deleted(self, venta_id):
        venta_id = str(venta_id)
        data = self.__sql_helper.sp_get(SpVentas.Can_delete, (venta_id,), True)
        print(data)
        return data["total"] == 0

    def delete_sale(self, venta_id):
        if not isinstance(venta_id, int):
            raise ValueError("Invalid venta id")
        if not self.__can_be_deleted(venta_id):
            raise AttributeError("Esta venta no puede ser borrada porque ya existen abonos registrados ligados a ella")

        venta_id = str(venta_id)
        self.__sql_helper.sp_set(SpVentas.Delete, (venta_id,))
