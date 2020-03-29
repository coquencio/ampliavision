from flask import Response, Blueprint, request
from src.Services.empresaService import EmpresaService

EmpresaController = Blueprint('empresa', __name__)


@EmpresaController.route('/api/empresas/create', methods=['POST'])
def create_empresa():
    try:
        data = request.get_json()
        nombre = data['nombre']
        domicilio = data['domicilio']
        telefono = data['telefono']

        empresa_service = EmpresaService()
        empresa_service.create_empresa(nombre, domicilio, telefono)
        return Response(status=201, response="Empresa creada")
    except ValueError as err:
        return Response(status=400, response=err.args)
