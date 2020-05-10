class Connection:
    SQL_HOST = "localhost"
    SQL_USER = "root"
    SQL_PASSWORD = "MyNewPass"
    SQL_DB = "ampliavision"


class SpUsers:
    Register = "UserRegistration"
    Authenticate = "GetToken"

    # Token
    Authorize = 'validaToken'


class SpEmpresas:
    # Nombre
    # Domicilio
    # Telefono
    Register = "RegistraEmpresa"

    # Empresa ID
    Validate = "ValidaEmpresa"

    Get_all = "seleccionaEmpresas"


class SpBeneficiario:
    # Nombres
    # Apellido paterno
    # Apellido materno
    # Fecha de nacimiento
    # Ocupacion
    # Empresa Id
    Register = "RegistraBeneficiario"

    # Beneficiario Id
    # Nombres
    # Apellido paterno
    # Apellido materno
    # Fecha de nacimiento
    # Ocupacion
    Update = "ActualizaBeneficiario"

    # Empresa Id
    get_by_empresa = "seleccionaBeneficiariosPorEmpresa"

    # Beneficiario Id
    Validate = "validaBeneficiario"

    # Beneficiario Id
    get_name_by_id = "GetBeneficiarioNombrePorId"


class SpOjos:
    # Lado Id
    # Esfera
    # Cilindro
    # Eje
    # Adiccion
    Register_and_get_Single = "RegistraYSeleccionaOjo"

    # Izquierdo id
    # Derecho id
    # Tipo Id
    # Dp lejos
    # Obl
    Register_and_get_pair = "RegistraYSeleccionaConjuntoOjos"

    # Conjunto id
    Get_pair = "conjuntoOjosPorId"

    # Ojo id
    Get_single = "ojoPorId"


class SpExamen:
    # Folio
    # Beneficiario ID
    # Anterior ID
    # Total ID
    # Adaptacion ID
    # Fecha examen
    # Requiere lentes
    # Compró lentes
    # Enfermedad ID
    # Observaciones

    Register = "RegistraExamen"

    # Beneficiario id
    Get_by_beneficiario = "seleccionaExamenPorBeneficiario"

    # Folio
    Get_by_folio = "seleccionaExamenPorFolio"

    # Empresa Id
    Get_summary_by_empresa = "GetResumenExamenesPorEmpresa"

    # Folio
    Update_by_folio = "ActualizaExamen"


class SpMarcas:
    # Descripcion
    Register = "RegistraMarcaArmazon"

    # Marca ID
    Deactivate = "DesactivaMarca"

    # Marca ID
    Activate = "ActivaMarca"

    GetAll = "SeleccionaMarcas"


class SpColores:
    # Descripcion
    Register = "RegistraColor"

    # Color ID
    Deactivate = "DesactivaColor"

    # Color ID
    Activate = "ActivaColor"

    GetAll = "SeleccionaColores"


class SpTamanios:
    # Descripcion
    Register = "RegistraTamanio"

    # Tamanio ID
    Deactivate = "DesactivaTamanio"

    # Tamanio ID
    Activate = "ActivaTamanio"

    GetAll = "SeleccionaTamanios"


class SpModelos:
    # Descripcion
    Register = "RegistraModelo"

    # Modelo ID
    Deactivate = "DesactivaModelo"

    # Modelo ID
    Activate = "ActivaModelo"

    GetAll = "SeleccionaModelos"


class SpArmazon:
    # Marca ID
    # Color ID
    # Tamanio ID
    # Modelo ID
    # Detalle En Armazon
    Register_and_get = "RegistraYSeleccionaArmazon"

    # Venta Id
    Get_summary = "seleccionaDetallesDeArmazonPorVenta"


class SpMaterial:
    # Descripcion
    Register = "RegistraMaterial"

    # Material ID
    Deactivate = "DesactivaMaterial"

    # Material ID
    Activate = "ActivaMaterial"

    GetAll = "SeleccionaMateriales"


class SpProteccion:
    # Descripcion
    Register = "RegistraProteccion"

    # Proteccion ID
    Deactivate = "DesactivaProteccion"

    # Proteccion ID
    Activate = "ActivaProteccion"

    GetAll = "SeleccionaProtecciones"


class SpLentes:
    # Descripcion
    Register = "RegistraLente"

    # Lente ID
    Deactivate = "DesactivaLente"

    # Lente ID
    Activate = "ActivaLente"

    GetAll = "SeleccionaLentes"


class SpVentas:
    # Folio examen
    # Total venta
    # Anticipo
    # Periodicidad días
    # Abonos
    # Fecha de la venta
    # Armazon ID
    # Material ID
    # ProteccionID
    # LenteID
    # Beneficiario ID
    Register_and_get = "RegistraYSeleccionaVenta"

    # Empresa Id
    Get_summary_by_empresa = "seleccionaResumenVentasPorEmpresa"

    # Venta Id
    # Monto
    # Fecha abono
    Bill_registration = "registraAbono"

    # Venta Id
    Get_abono_by_venta = "seleccionaAbonosPorVenta"

    # Venta Id
    Get_abono_sum_by_venta = "seleccionaSumAbonosPorVenta"

    # Abono Id
    Delete_abono = "borraAbono"

    # Venta Id
    Get_total_of_sale = "SelectSaldoVenta"


class SpCasosIso:

    Get_active = "SeleccionaCasosActivos"

    # Beneficiario Id
    Get_by_beneficiario = "SeleccionaCasosPorBeneficiario"

    # Beneficiario Id
    # Caso Id
    Create_relation = "RegistraCasosPorBeneficiario"

    # Relation Id
    Delete_relation = "DeleteIsoRelation"

