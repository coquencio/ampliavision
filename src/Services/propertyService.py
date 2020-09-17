from src.Helpers.sql import MySqlHelper
from src.Core import propertyConstants as SpProperties
from src.Helpers.stringHelper import StringHelper
from src.Helpers.encryptionHelper import EncryptionService

class PropertyService:
    def __init__(self):
        self.__sql = MySqlHelper()
        self.__string_helper = StringHelper()
        self.__encryption = EncryptionService()

    def get_property_value(self, property_name):
        # Hardcoded rule, property is not encrypted
        if property_name == "key":
            return None

        property_name = self.__string_helper.build_string(property_name)
        data = self.__sql.sp_get(SpProperties.Get_property_value, (property_name,), True)

        if data:
            return self.__encryption.decrypt(data["propertyValue"])

        return data


    def create_property(self, name, value):
        # Hardcoded rule, user should not interact with this property
        if property_name == "key":
            raise ValueError("Nombre de Propiedad reservado para sistema")

        if self.get_property_value(name):
            raise ValueError("Ya existe una propiedad con este nombre")

        value = self.__encryption.encrypt(value)
        name = self.__string_helper.build_string(name)
        value = self.__string_helper.build_string(value)
        args = (name, value)
        self.__sql.sp_set(SpProperties.Create_property, args)

    def delete_property(self, name):
        # Hardcoded rule, user should not interact with this property
        if property_name == "key":
            raise ValueError("Propiedad no encontrada")

        if not self.get_property_value(name):
            raise ValueError("Propiedad no encontrada")
        name = self.__string_helper.build_string(name)
        self.__sql.sp_set(SpProperties.Delete_property, (name, ))

    def update_property(self, name, new_value):
        # Hardcoded rule, property is not encrypted
        if property_name == "key":
            raise ValueError("Propiedad no encontrada")

        if not self.get_property_value(name):
            raise ValueError("Propiedad no encontrada")
        value = self.__encryption.encrypt(new_value)
        name = self.__string_helper.build_string(name)
        value = self.__string_helper.build_string(value)
        args = (name, value)
        self.__sql.sp_set(SpProperties.Update_property_value, args)
