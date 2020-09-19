from flask import Blueprint, Response, request
from src.Services.emailService import EmailService
from src.Services.usersService import UsersService

EmailController = Blueprint('mail', __name__)
mail_service = EmailService()
user_service = UsersService()


@EmailController.route('/api/mail/add', methods=['POST'])
def insert_mail():
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status=401)
        data = request.get_json()
        mail_service.save_email(data)
        return Response(status=201, response="Email añadido")
    except ValueError as err:
        return Response(status = 400, response = err.args)
    except KeyError as err:
        return Response(status=400, response="Campo faltante: " + err.args[0])


@EmailController.route('/api/mail/password', methods=['PUT'])
def update_password():
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status=401)
        data = request.get_json()
        mail_service.update_password(data)
        return Response(status=200, response="Contraseña actualizada")
    except ValueError as err:
        return Response(status = 400, response = err.args)
    except KeyError as err:
        return Response(status=400, response="Campo faltante: " + err.args[0])


@EmailController.route('/api/mail/send', methods=['POST'])
def send_mail():
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status=401)
        data = request.get_json()
        mail_service.validate_and_send_mail(data)
        return Response(status=200, response="Email enviado")
    except ValueError as err:
        return Response(status=400, response = err.args)
    except KeyError as err:
        return Response(status=400, response="Campo faltante: " + err.args[0])


@EmailController.route('/api/mail', methods=['GET'])
def get_mails():
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status=401)
        return mail_service.get_emails()
    except ValueError as err:
        return Response(status=400, response = err.args)
    except KeyError as err:
        return Response(status=400, response="Campo faltante:" + err.args)


@EmailController.route('/api/mail/<string:mail>', methods=['DELETE'])
def delete_mail(mail):
    try:
        token = request.args.get('token')
        if not user_service.token_validation(token):
            return Response(status=401)
        mail_service.delete_mail(mail)
        return Response(status=201, response="Email eliminado")
    except ValueError as err:
        return Response(status = 400, response = err.args)