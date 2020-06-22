from flask import Response, request, Blueprint
from src.Services.isoService import IsoService
from src.Services.usersService import UsersService

user_service = UsersService()
iso_service = IsoService()
IsoController = Blueprint('iso', __name__)


@IsoController.route('/api/iso/active', methods=['GET'])
def get_active():
    try:
        token = request.args.get('token')
        if not token:
            return Response(status=401)
        if not user_service.token_validation(token):
            return Response(status=401)
        return iso_service.get_active_ones()
    except ValueError as err:
        return Response(status=400, response=err.args)


@IsoController.route('/api/iso/active/<int:beneficiario_id>', methods=['GET'])
def get_active_by_beneficiario(beneficiario_id):
    try:
        token = request.args.get('token')
        if not token:
            return Response(status=401)
        if not user_service.token_validation(token):
            return Response(status=401)
        data = iso_service.get_by_beneficiario(beneficiario_id)
        if not data:
            return Response(status=404, response="Relationships not found")
        return data
    except ValueError as err:
        return Response(status=400, response=err.args)


@IsoController.route('/api/iso/create/<int:beneficiario_id>/<int:caso_id>', methods=['POST'])
def create_relation(beneficiario_id, caso_id):
    try:
        token = request.args.get('token')
        if not token:
            return Response(status=401)
        if not user_service.token_validation(token):
            return Response(status=401)
        data = iso_service.create_relation(beneficiario_id, caso_id)
        if not data:
            return Response(status=404, response="Beneficiario not found")
        return Response(status=201, response="Relationship created")
    except ValueError as err:
        return Response(status=400, response=err.args)

@IsoController.route('/api/iso/delete/<int:relation_id>', methods=['DELETE'])
def delete_relation(relation_id):
    try:
        token = request.args.get('token')
        if not token:
            return Response(status=401)
        if not user_service.token_validation(token):
            return Response(status=401)
        iso_service.delete_relation(relation_id);
        return Response(status=200)
    except ValueError as err:
        return Response(status=400, response=err.args)
