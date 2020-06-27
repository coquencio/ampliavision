from flask import Response, Blueprint, request
from src.Services.examenService import ExamenService
from src.Services.usersService import UsersService

ExamenController = Blueprint('examen', __name__)
examen_service = ExamenService()
user_service = UsersService()


@ExamenController.route('/api/examenes', methods=['POST'])
def create_examen():
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status=401)
        data = request.get_json()

        examen_service.register(data)
        return Response(status=201)
    except ValueError as err:
        return Response(status=400, response=err.args)


@ExamenController.route('/api/examenes/folio/<string:folio>', methods=['GET'])
def get_by_folio(folio):
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status=401)
        data = examen_service.get_by_folio(folio)
        if not data:
            return Response(status=404, response="Examen not found")
        return data
    except ValueError as err:
        return Response(status=400, response=err.args)


@ExamenController.route('/api/examenes/beneficiario/<int:beneficiario_id>', methods=['GET'])
def get_by_beneficiario(beneficiario_id):
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status=401)
        data = examen_service.get_by_beneficiatio(beneficiario_id)
        if not data:
            return Response(status=404, response="Examen not found")
        return data
    except ValueError as err:
        return Response(status=400, response=err.args)


@ExamenController.route('/api/examenes/resumen/<int:empresa_id>', methods=['GET'])
def get_summary(empresa_id):
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status=401)
        data = examen_service.get_summary_by_empresa(empresa_id)
        if not data:
            return Response(status=404, response="Examenes not found")
        return data
    except ValueError as err:
        return Response(status=400, response=err.args)

@ExamenController.route('/api/examenes', methods=['PUT'])
def update_examen():
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status=401)
        data = request.get_json()
        examen_service.update(data)

        return Response(status=201)
    except ValueError as err:
        return Response(status=400, response=err.args)


@ExamenController.route('/api/empresas/<int:empresa_id>/examenes/folios', methods=['GET'])
def get_folios(empresa_id):
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status=401)

        data = examen_service.get_folios(empresa_id)
        if not data:
            return Response(status=404, response="Folios not found")
        return data
    except ValueError as err:
        return Response(status=400, response=err.args)

@ExamenController.route('/api/examenes/<string:folio>/beneficiario', methods=['GET'])
def get_beneficiario_by_folio(folio):
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status=401)
        return examen_service.get_beneficiario_by_folio(folio)
    except ValueError as err:
        return Response(status=400, response=err.args)

