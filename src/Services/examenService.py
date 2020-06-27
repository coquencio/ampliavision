from src.Helpers.sql import MySqlHelper
from src.Core.constants import SpExamen
from src.Helpers.stringHelper import StringHelper
from src.Helpers.serializer import serialize_data_set


class ExamenService:
    def __init__(self):
        self.__sql_helper = MySqlHelper()
        self.__string_helper = StringHelper()

    def register(self, data):
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

        if not isinstance(requiere_lentes, int) or not isinstance(compro_lentes, int) or not folio or not isinstance(beneficiario_id, int) or not isinstance(enfermedad_id, int):
            raise ValueError("Incorrect type values")
        
        folio = self.__string_helper.build_string(folio)
        fecha_examen = self.__string_helper.build_string(fecha_examen)
        if observaciones:
            observaciones = self.__string_helper.build_string(observaciones)
        args = (folio, beneficiario_id, anterior_id, total_id, adaptacion_id, fecha_examen, requiere_lentes,
                compro_lentes, enfermedad_id, observaciones)
        self.__sql_helper.sp_set(SpExamen.Register, args)

    def get_by_beneficiatio(self, beneficiario_id):
        if not isinstance(beneficiario_id, int):
            raise ValueError("Invalid beneficiario")
        args = (str(beneficiario_id), )
        data = self.__sql_helper.sp_get(SpExamen.Get_by_beneficiario, args)
        if not data:
            return False
        data = serialize_data_set(data)
        return data

    def get_by_folio(self, folio):
        if not folio:
            raise ValueError("Missing folio")
        if len(folio) > 10:
            raise ValueError("Invalid folio")
        args = (self.__string_helper.build_string(folio), )
        data = self.__sql_helper.sp_get(SpExamen.Get_by_folio, args, True)
        if not data:
            return False
        data = serialize_data_set(data)
        return data

    def get_summary_by_empresa(self, empresa_id):
        if not isinstance(empresa_id, int):
            raise ValueError("Invalid Id")
        args = (str(empresa_id), )
        data = self.__sql_helper.sp_get(SpExamen.Get_summary_by_empresa, args)
        print(data)
        return serialize_data_set(data, "Examenes")

    def update(self, data):
        folio = data['Folio']
        beneficiario_id = data['BeneficiarioId']
        anterior_id = data['AnteriorId']
        total_id = data['TotalId']
        adaptacion_id = data['AdaptacionId']
        requiere_lentes = data['RequiereLentes']
        compro_lentes = data['ComproLentes']
        enfermedad_id = data['EnfermedadId']
        observaciones = data['Observaciones']

        if not isinstance(requiere_lentes, int) or not isinstance(compro_lentes, int) or not folio or not isinstance(
                beneficiario_id, int) or not isinstance(enfermedad_id, int):
            raise ValueError("Incorrect type values")

        folio = self.__string_helper.build_string(folio)
        if observaciones:
            observaciones = self.__string_helper.build_string(observaciones)
        args = (folio, beneficiario_id, anterior_id, total_id, adaptacion_id, requiere_lentes,
                compro_lentes, enfermedad_id, observaciones)
        self.__sql_helper.sp_set(SpExamen.Update_by_folio, args)

    def get_folios (self, empresa_id):
        if not isinstance(empresa_id, int):
            raise ValueError("Invalid Id")
        args = (empresa_id, )
        data = self.__sql_helper.sp_get(SpExamen.Get_folios, args)
        return serialize_data_set(data, "Folios")

    def get_beneficiario_by_folio(self, folio):
        folio = self.__string_helper.build_string(folio)
        args = (folio, )
        data = self.__sql_helper.sp_get(SpExamen.Get_beneficiario_by_folio, args, True)
        return serialize_data_set(data)

