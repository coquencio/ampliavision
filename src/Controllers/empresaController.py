from flask import Response, Blueprint
from src.Services.empresaService import EmpresaService

EmpresaController = Blueprint('empresa', __name__)

@EmpresaController.route('/api/empresa/create/<description>')
def create_empresa(description):
    try:
        empresa_service = EmpresaService()
        empresa_service.create_empresa(description)
        return Response(status=201, response="Empresa created")
    except ValueError as err:
        return Response(status=400, response=err.args)
