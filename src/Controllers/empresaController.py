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
        nombre = data['nombre']
        domicilio = data['domicilio']
        telefono = data['telefono']
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
