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
        return venta_service.register_and_get(folio, total, anticipo, periodicidad, abonos, fecha_venta, armazon_id,
                                              material_id, proteccion_id, lente_id, beneficiario_id)
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
