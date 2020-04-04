from flask import Response, Blueprint, request
from src.Services.generalService import GeneralService
from src.Services.usersService import UsersService

GeneralController = Blueprint('general', __name__)
user_service = UsersService()


@GeneralController.route('/api/<string:entity>/create/<string:description>', methods=['POST'])
def register(entity, description):
    try:
        token = request.args.get('token')
        if not token:
            return Response(status=401)
        if not user_service.token_validation(token):
            return Response(status=401)

        general_service = GeneralService(entity)
        general_service.register(description)
        return Response(status=201, response="Creado registro en " + entity)

    except ValueError as err:
        return Response(status=400, response=err.args)
    except KeyError:
        return Response(status=400, response="Unexisting table with the name of:" + entity)


@GeneralController.route('/api/<string:entity>/<int:primary_key>/status/<int:status>', methods=['PUT'])
def activation(entity, status, primary_key):
    try:
        token = request.args.get('token')
        if not token:
            return Response(status=401)
        if not user_service.token_validation(token):
            return Response(status=401)

        if status != 1 and status != 0:
            return Response(status=400, response="Invalid status")
        general_service = GeneralService(entity)
        if status == 0:
            general_service.active_status(primary_key)
        else:
            general_service.active_status(primary_key, True)
        return Response(status=201, response="Se ha actualizado un registro en "+entity)

    except ValueError as err:
        return Response(status=400, response=err.args)
    except KeyError:
        return Response(status=400, response="Unexisting table with the name of:" + entity)


@GeneralController.route('/api/<string:entity>', methods=['GET'])
def get(entity):
    try:
        token = request.args.get('token')
        if not token:
            return Response(status=401)
        if not user_service.token_validation(token):
            return Response(status=401)

        general_service = GeneralService(entity)
        return general_service.get(entity)

    except ValueError as err:
        return Response(status=400, response=err.args)
    except KeyError:
        return Response(status=400, response="Unexisting table with the name of:" + entity)
