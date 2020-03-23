import flask
from flask import Flask
from src.Services.usersService import UsersService

app = Flask(__name__)


@app.route('/')
def hello_world():
    return 'Hello, World!'


@app.route('/api/users/create/<user_name>/<password>')
def create_user(user_name, password):
    try:
        user_service = UsersService()
        user_service.create_user(user_name, password)
        return flask.Response(status=201, response="user created")
    except ValueError as err:
        return flask.Response(status=400, response=err.args)


@app.route('/api/login/<user_name>/<password>')
def authenticate(user_name, password):
    try:
        user_service = UsersService()
        token = user_service.user_authentication(user_name, password)
        if token == "null":
            return flask.Response(status=404, response="User not found")

        return token
    except ValueError as err:
        return flask.Response(status=400, response=err.args)