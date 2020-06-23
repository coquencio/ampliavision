from flask import Response, Blueprint, request
from src.Services.chartService import ChartService
from src.Services.usersService import UsersService

ChartController = Blueprint('charts', __name__)
user_service = UsersService()
chart_service = ChartService()


@ChartController.route('/api/empresas/<int:empresa_id>/grafico/<string:chart>', methods=['GET'])
def get_sales_chart(empresa_id, chart):
    token = request.args.get('token')
    if not token:
        return Response(status=401)
    if not user_service.token_validation(token):
        return Response(status=401)
    data = chart_service.get_chart(empresa_id, chart)
    if data:
        return data

    return Response(status=404, response = "Aún no hay datos")
