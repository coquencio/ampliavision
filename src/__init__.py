from flask import Flask
from src.Controllers.UserManagerController import UserController

app = Flask(__name__)
app.register_blueprint(UserController)


@app.route('/')
def hello_world():
    return 'Hello, World!'
