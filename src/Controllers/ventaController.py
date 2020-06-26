from flask import Response, Blueprint, request
from src.Services.usersService import UsersService
from src.Services.ventaService import VentaService

user_service = UsersService()
venta_service = VentaService()
VentaController = Blueprint('veta', __name__)


@VentaController.route('/api/venta', methods=['POST'])
def create_and_get():
    try:
        token = request.args.get('token')
        if not token:
            return Response(status=401)
        if not user_service.token_validation(token):
            return Response(status=401)
        data = request.get_json()
        folio = data['Folio']
        total = data['TotalVenta']
        anticipo = data['Anticipo']
        periodicidad = data['Periodicidad']
        abonos = data['Abonos']
        fecha_venta = data['FechaVenta']
        armazon_id = data['ArmazonId']
        material_id = data['MaterialId']
        proteccion_id = data['ProteccionId']
        lente_id = data['LenteId']
        beneficiario_id = data['BeneficiarioId']
        tipo_venta_id = data['TipoVentaId']
        if folio:
            if venta_service.is_folio_repeated(folio):
                return Response(status=400, response='Este Folio ya pertenece a una venta')

        return venta_service.register_and_get(folio, total, anticipo, periodicidad, abonos, fecha_venta, armazon_id,
                                              material_id, proteccion_id, lente_id, beneficiario_id, tipo_venta_id)
    except ValueError as err:
        return Response(status=400, response=err.args)
    except KeyError as err:
        return Response(status=400, response=err.args)


@VentaController.route('/api/empresas/<int:empresa_id>/ventas', methods=['GET'])
def get_summary_by_empresa(empresa_id):
    try:
        token = request.args.get('token')
        if not token:
            return Response(status=401)
        if not user_service.token_validation(token):
            return Response(status=401)
        data = venta_service.get_summary_by_company(empresa_id)
        if not data:
            return Response(status=404)
        return data
    except ValueError as err:
        return Response(status=400, response=err.args)


@VentaController.route('/api/ventas/<int:venta_id>/abonos', methods=['POST'])
def register_payment(venta_id):
    try:
        token = request.args.get('token')
        if not token:
            return Response(status=401)
        if not user_service.token_validation(token):
            return Response(status=401)
        data = request.get_json()
        monto = data['Monto']
        fecha = data['FechaAbono']
        name = user_service.get_name(token)
        venta_service.payment_register(venta_id, monto, fecha, name)
        return Response(status=201, response="Abono creado")
    except ValueError as err:
        return Response(status=400, response=err.args)


@VentaController.route('/api/ventas/<int:venta_id>/abonos', methods=['GET'])
def get_abonos(venta_id):
    try:
        token = request.args.get('token')
        if not token:
            return Response(status=401)
        if not user_service.token_validation(token):
            return Response(status=401)
        data = venta_service.get_payments_by_venta(venta_id)
        if not data:
            return Response(status=404, response="No hay abonos aún")
        return data
    except ValueError as err:
        return Response(status=400, response=err.args)

@VentaController.route('/api/ventas/<int:venta_id>/paid/<int:paying>', methods=['POST'])
def mark_as_paid(venta_id, paying):
    try:
        token = request.args.get('token')
        if not token:
            return Response(status=401)
        if not user_service.token_validation(token):
            return Response(status=401)
        if paying == 1:
            venta_service.paid_switch(venta_id)
        else:
            venta_service.paid_switch(venta_id, False)
        return Response(status=201, response="Venta actualizada")
    except ValueError as err:
        return Response(status=400, response=err.args)

@VentaController.route('/api/abono/<int:abono_id>', methods=['DELETE'])
def delete_payment (abono_id):
    try:
        token = request.args.get('token')
        if not token:
            return Response(status=401)
        if not user_service.token_validation(token):
            return Response(status=401)

        venta_service.delete_payment(abono_id, token)
        return Response(status=201, response="Pago eliminado")
    except ValueError as err:
        return Response(status=400, response=err.args)

@VentaController.route('/api/ventas/<int:venta_id>', methods=['DELETE'])
def delete_sale(venta_id):
    try:
        token = request.args.get('token')
        if not token:
            return Response(status=401)
        if not user_service.token_validation(token):
            return Response(status=401)

        venta_service.delete_sale(venta_id)
        return Response(status=201, response="Venta eliminada")
    except ValueError as err:
        return Response(status=400, response=err.args)
    except AttributeError as err:
        return Response(status=400, response=err.args)

@VentaController.route('/api/empresas/<int:empresa_id>/ventas/resumen', methods=['GET'])
def get_balance_summary(empresa_id):
    try:
        token = request.args.get('token')
        if not token:
            return Response(status=401)
        if not user_service.token_validation(token):
            return Response(status=401)
        return venta_service.get_balance_summary(empresa_id)

    except ValueError as err:
        return Response(status=400, response=err.args)

@VentaController.route('/api/ventas/abonos/<int:abono_id>', methods=['PUT'])
def update_payment(abono_id):
    try:
        token = request.args.get('token')
        if not token:
            return Response(status=401)
        if not user_service.token_validation(token):
            return Response(status=401)
        data = request.get_json()
        monto = data['Monto']
        fecha = data['FechaAbono']
        name = user_service.get_name(token)
        venta_service.payment_update(abono_id, monto, fecha, token)
        return Response(status=201, response="Abono actualizado")
    except ValueError as err:
        return Response(status=400, response=err.args)
