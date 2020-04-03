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
        if not token:
            return Response(status=401)
        if not user_service.token_validation(token):
            return Response(status=401)
        if not lado:
            return Response(status=400)
        if lado == "izquierdo":
            lado_id = 1
        elif lado == "derecho":
            lado_id = 2
        else:
            return Response(status=400)

        data = request.get_json()
        esfera = data['Esfera']
        cilindro = data['Cilindro']
        eje = data['Eje']
        adiccion = data['Adiccion']

        return ojos_service.register_and_get_single(lado_id, esfera, cilindro, eje, adiccion)
    except ValueError as err:
        return Response(status=400, response=err.args)


@OjosController.route('/api/empresas/beneficiarios/ojos/conjunto/<string:tipo>', methods=['POST'])
def create_and_get_pair(tipo):
    token = request.args.get('token')
    if not token:
        return Response(status=401)
    if not user_service.token_validation(token):
        return Response(status=401)
    if not tipo:
        return Response(status=400)
    if tipo == "anterior":
        tipo_id = 1
    elif tipo == "total":
        tipo_id = 2
    elif tipo == "adaptacion":
        tipo_id = 3
    else:
        return Response(status=400)

    data = request.get_json()
    izquierdo_id = data['IzquierdoId']
    derecho_id = data['DerechoId']
    dp_lejos = data['DpLejos']
    obl = data['Obl']
    return ojos_service.register_and_get_pair(izquierdo_id, derecho_id, tipo_id, dp_lejos, obl)


