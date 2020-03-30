from flask import Response, Blueprint, request
from src.Services.beneficiariosService import BeneficiariosService
from src.Services.usersService import UsersService

BeneficiarioController = Blueprint('beneficiario', __name__)
user_service = UsersService()


@BeneficiarioController.route('/api/empresas/<int:empresa_id>/beneficiarios/create', methods=['POST'])
def crea_beneficiario(empresa_id):
    try:
        token = request.args.get('token')
        if not token:
            return Response(status=401)
        if not user_service.token_validation(token):
            return Response(status=401)

        data = request.get_json()
        nombre = data['nombres']
        apepat = data['apellidoPaterno']
        apemat = data['apellidoMaterno']
        fechanac = data['fechaNacimiento']
        ocupacion = data['ocupacion']
        beneficiario_service = BeneficiariosService()
        beneficiario_service.create_beneficiario(nombre, apepat, apemat, fechanac, ocupacion, empresa_id)
        return Response(status=201, response="Beneficiario creado satisfactoriamente")
    except ValueError as err:
        return Response(status=400, response=err.args)
    except KeyError as err:
        return Response(status=400, response=err.args)


@BeneficiarioController.route('/api/empresas/<int:empresa_id>/beneficiarios', methods=['GET'])
def get_by_empresa(empresa_id):
    try:
        beneficiario_service = BeneficiariosService()
        return beneficiario_service.get_beneficiario_by_empresa(empresa_id)

    except ValueError as err:
        return Response(status=400, response=err.args)

    except KeyError as err:
        return Response(status=400, response=err.args)
