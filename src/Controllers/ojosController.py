from flask import Blueprint, Response, request
from src.Services.ojoService import OjoService

OjosController = Blueprint('ojos', __name__)
ojos_service = OjoService()


@OjosController.route('/api/empresas/beneficiarios/ojos/<string:lado>', methods=['POST'])
def create_and_get(lado):
    try:
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
