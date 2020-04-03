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
        if not token:
            return Response(status=401)
        if not user_service.token_validation(token):
            return Response(status=401)
        data = request.get_json()
        folio = data['Folio']
        beneficiario_id = data['BeneficiarioId']
        anterior_id = data['AnteriorId']
        total_id = data['TotalId']
        adaptacion_id = data['AdaptacionId']
        fecha_examen = data['FechaExamen']
        requiere_lentes = data['RequiereLentes']
        compro_lentes = data['ComproLentes']
        enfermedad_id = data['EnfermedadId']
        observaciones = data['Observaciones']
        examen_service.register(folio, beneficiario_id, anterior_id, total_id, adaptacion_id, fecha_examen, requiere_lentes,
                                compro_lentes, enfermedad_id, observaciones)
        return Response(status=201)
    except ValueError as err:
        return Response(status=400, response=err.args)
