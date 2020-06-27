from flask import Response, request, Blueprint
from src.Services.armazonService import ArmazonService
from src.Services.usersService import UsersService

user_service = UsersService()
armazon_service = ArmazonService()
ArmazonController = Blueprint('armazon', __name__)


@ArmazonController.route('/api/armazones', methods=['POST'])
def register_and_get():
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status=401)
        data = request.get_json()

        return armazon_service.register_and_get(data)
    except ValueError as err:
        return Response(status=400, response=err.args)


@ArmazonController.route('/api/ventas/<int:venta_id>/armazon', methods=['GET'])
def get_by_venta(venta_id):
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status=401)
        data = armazon_service.get_summary(venta_id)
        if not data:
            return Response(status=404)
        return data
    except ValueError as err:
        return Response(status=400, response=err.args)
