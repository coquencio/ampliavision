from flask import Response, Blueprint, request
from src.Services.beneficiariosService import BeneficiariosService

BeneficiarioController = Blueprint('beneficiario', __name__)


@BeneficiarioController.route('/api/beneficiarios/create', methods=['POST'])
def crea_beneficiario():
    try:
        data = request.get_json()
        nombre = data['nombres']
        apepat = data['apellidoPaterno']
        apemat = data['apellidoMaterno']
        fechanac = data['fechaNacimiento']
        ocupacion = data['ocupacion']
        empresa_id = data['empresaId']
        beneficiario_service = BeneficiariosService()
        beneficiario_service.create_beneficiario(nombre, apepat, apemat, fechanac, ocupacion, empresa_id)
        return Response(status=201, response="Beneficiario creado satisfactoriamente")
    except ValueError as err:
        return Response(status=400, response=err.args)
    except KeyError as err:
        return Response(status=400, response=err.args)

