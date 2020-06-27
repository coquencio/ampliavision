from flask import Blueprint, Response, request
from src.Services.ojoService import OjoService
from src.Services.usersService import UsersService

OjosController = Blueprint('ojos', __name__)
ojos_service = OjoService()
user_service = UsersService()


@OjosController.route('/api/empresas/beneficiarios/ojos/<string:lado>', methods=['POST'])
def create_and_get(lado):
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status=401)
        data = request.get_json()

        return ojos_service.register_and_get_single(lado, data)
    except ValueError as err:
        return Response(status=400, response=err.args)
    except KeyError:
        return Response(status=400, response="Invalid lado")


@OjosController.route('/api/empresas/beneficiarios/ojos/conjunto/<string:tipo>', methods=['POST'])
def create_and_get_pair(tipo):
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status=401)
        if not tipo:
            return Response(status=400)

        data = request.get_json()

        return ojos_service.register_and_get_pair(data, tipo)
    except ValueError as err:
        return Response(status=400, response=err.args)
    except KeyError:
        return Response(status=400, response="Invalid tipo")


@OjosController.route('/api/ojos/conjuntos/<int:conjunto_id>', methods=['GET'])
def get_pair(conjunto_id):
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status=401)
        data = ojos_service.get_pair(conjunto_id)
        if not data:
            return Response(status=404, response="Not found")
        return data
    except ValueError as err:
        return Response(status=400, response=err.args)


@OjosController.route('/api/ojos/<int:ojo_id>', methods=['GET'])
def get_single(ojo_id):
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status=401)

        data = ojos_service.get_single(ojo_id)
        if not data:
            return Response(status=404, response="Not found")

        return data
    except ValueError as err:
        return Response(status=400, response=err.args)
