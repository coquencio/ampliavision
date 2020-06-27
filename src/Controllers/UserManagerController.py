from flask import Response, Blueprint
from src.Services.usersService import UsersService

UserController = Blueprint('users', __name__)
user_service = UsersService()


@UserController.route('/api/users/create/<user_name>/<password>', methods=['POST'])
def create_user(user_name, password):
    try:
        token = request.args.get('token')
        if not token:
            return Response(status=401)
        if not user_service.token_validation(token):
            return Response(status=401)
        user_service.create_user(user_name, password, token)
        return Response(status=201, response="user created")
    except ValueError as err:
        return Response(status=400, response=err.args)
    except AssertionError as err:
        return Response(status=401, response=err.args)

@UserController.route('/api/login/<user_name>/<password>', methods=['GET'])
def authenticate(user_name, password):
    try:
        token = user_service.user_authentication(user_name, password)
        if token == "null":
            return Response(status=404, response="User not found")

        return token
    except ValueError as err:
        return Response(status=400, response=err.args)
