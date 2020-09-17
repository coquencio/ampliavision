from flask import Flask
from flask_cors import CORS
from src.Controllers.UserManagerController import UserController
from src.Controllers.empresaController import EmpresaController
from src.Controllers.beneficiarioController import BeneficiarioController
from src.Controllers.ojosController import OjosController
from src.Controllers.examenController import ExamenController
from src.Controllers.generalController import GeneralController
from src.Controllers.armazonController import ArmazonController
from src.Controllers.ventaController import VentaController
from src.Controllers.isoController import IsoController
from src.Controllers.chartsController import ChartController
from src.Controllers.propertyController import PropertyController
from src.Controllers.mailController import EmailController

app = Flask(__name__)
app.register_blueprint(UserController)
app.register_blueprint(EmpresaController)
app.register_blueprint(BeneficiarioController)
app.register_blueprint(OjosController)
app.register_blueprint(ExamenController)
app.register_blueprint(GeneralController)
app.register_blueprint(ArmazonController)
app.register_blueprint(VentaController)
app.register_blueprint(IsoController)
app.register_blueprint(ChartController)
app.register_blueprint(PropertyController)
app.register_blueprint(EmailController)
# CORS
CORS(app)


@app.route('/')
def hello_world():
    return 'Release of July'
