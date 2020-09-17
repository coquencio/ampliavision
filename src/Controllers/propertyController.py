from flask import Blueprint, Response, request
from src.Services.propertyService import PropertyService
from src.Services.usersService import UsersService

PropertyController = Blueprint('properties', __name__)
property_service = PropertyService()
user_service = UsersService()


@PropertyController.route('/api/propiedades/<string:name>', methods=['GET'])
def get_value(name):
    token = request.args.get('token')
    if not user_service.token_validation(token):
        return Response(status=401)

    value = property_service.get_property_value(name)

    if not property_service.get_property_value(name):
        return Response(status=400, response="Propiedad no encontrada")

    return value

@PropertyController.route('/api/propiedades/<string:name>/<string:value>', methods=['POST'])
def create_property(name, value):
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status = 401)

        property_service.create_property(name, value)
        return Response(status = 201, response = "Propiedad añadida")

    except ValueError as err:
        return Response(status = 400, response = err.args)

@PropertyController.route('/api/propiedades/<string:name>', methods=['DELETE'])
def delete_property(name):
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status = 401)

        property_service.delete_property(name)
        return Response(status = 200, response = "Propiedad eliminada")

    except ValueError as err:
        return Response(status = 400, response = err.args)

@PropertyController.route('/api/propiedades/<string:name>/<string:value>', methods=['PUT'])
def update_property(name, value):
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status = 401)

        property_service.update_property(name, value)
        return Response(status = 200, response = "Propiedad actualizada")

    except ValueError as err:
        return Response(status = 400, response = err.args)
