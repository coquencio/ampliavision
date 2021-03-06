from flask import Response, Blueprint, request
from src.Services.beneficiariosService import BeneficiariosService
from src.Services.usersService import UsersService

BeneficiarioController = Blueprint('beneficiario', __name__)
user_service = UsersService()
beneficiario_service = BeneficiariosService()


@BeneficiarioController.route('/api/empresas/<int:empresa_id>/beneficiarios/create', methods=['POST'])
def crea_beneficiario(empresa_id):
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status=401)

        data = request.get_json()
        beneficiario_service.create_beneficiario(empresa_id, data)
        return Response(status=201, response="Beneficiario creado satisfactoriamente")
    except ValueError as err:
        return Response(status=400, response=err.args)
    except KeyError as err:
        return Response(status=400, response=err.args)


@BeneficiarioController.route('/api/empresas/<int:empresa_id>/beneficiarios', methods=['GET'])
def get_by_empresa(empresa_id):
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status=401)
        return beneficiario_service.get_beneficiario_by_empresa(empresa_id)

    except ValueError as err:
        return Response(status=400, response=err.args)

    except KeyError as err:
        return Response(status=400, response=err.args)

@BeneficiarioController.route('/api/empresas/beneficiarios/<int:beneficiario_id>/nombres', methods=['GET'])
def get_names_by_id(beneficiario_id):
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status=401)
        return beneficiario_service.get_names_by_id (beneficiario_id)

    except ValueError as err:
        return Response(status=400, response=err.args)

    except KeyError as err:
        return Response(status=400, response=err.args)

@BeneficiarioController.route('/api/empresas/beneficiarios/<int:beneficiario_id>', methods=['PUT'])
def update_beneficiario(beneficiario_id):
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status=401)

        data = request.get_json()
        beneficiario_service.update_beneficiario(beneficiario_id, data)

        return Response(status=201, response="Beneficiario registrado satisfactoriamente")
    except ValueError as err:
        return Response(status=400, response=err.args)
    except KeyError as err:
        return Response(status=400, response=err.args)

