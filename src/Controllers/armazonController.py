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
        if not token:
            return Response(status=401)
        if not user_service.token_validation(token):
            return Response(status=401)
        data = request.get_json()
        marca_id = data['MarcaId']
        color_id = data['ColorId']
        tamanio_id = data['TamanioId']
        modelo_id = data['ModeloId']

        args = (marca_id, color_id, tamanio_id, modelo_id)
        return armazon_service.register_and_get(args)
    except ValueError as err:
        return Response(status=400, response=err.args)