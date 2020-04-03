from flask import Flask
from src.Controllers.UserManagerController import UserController
from src.Controllers.empresaController import EmpresaController
from src.Controllers.beneficiarioController import BeneficiarioController
from src.Controllers.ojosController import OjosController
from src.Controllers.examenController import ExamenController

app = Flask(__name__)
app.register_blueprint(UserController)
app.register_blueprint(EmpresaController)
app.register_blueprint(BeneficiarioController)
app.register_blueprint(OjosController)
app.register_blueprint(ExamenController)


@app.route('/')
def hello_world():
    return 'Hello, World, not released yet'
