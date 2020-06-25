from flask import Response, Blueprint, request
from src.Services.empresaService import EmpresaService
from src.Services.usersService import UsersService

EmpresaController = Blueprint('empresa', __name__)
empresa_service = EmpresaService()
user_service = UsersService()


@EmpresaController.route('/api/empresas/create', methods=['POST'])
def create_empresa():
    try:
        token = request.args.get('token')
        if not token:
            return Response(status=401)
        if not user_service.token_validation(token):
            return Response(status=401)

        data = request.get_json()
        nombre = data['Nombre']
        domicilio = data['Domicilio']
        telefono = data['Telefono']
        empresa_service.create_empresa(nombre, domicilio, telefono)
        return Response(status=201, response="Empresa creada")
    except ValueError as err:
        return Response(status=400, response=err.args)


@EmpresaController.route('/api/empresas', methods=['GET'])
def get_all_empresas():
    token = request.args.get('token')
    if not token:
        return Response(status=401)
    if not user_service.token_validation(token):
        return Response(status=401)

    return empresa_service.get_empresas()

@EmpresaController.route('/api/empresas/folio/<string:folio>', methods=['GET'])
def get_by_folio(folio):
    token = request.args.get('token')
    if not token:
        return Response(status=401)
    if not user_service.token_validation(token):
        return Response(status=401)

    return empresa_service.get_by_folio(folio)

@EmpresaController.route('/api/empresas/ventas/<int:venta_id>', methods=['GET'])
def get_by_sale(venta_id):
    token = request.args.get('token')
    if not token:
        return Response(status=401)
    if not user_service.token_validation(token):
        return Response(status=401)

    return empresa_service.get_by_venta(venta_id)
