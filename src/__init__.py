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
