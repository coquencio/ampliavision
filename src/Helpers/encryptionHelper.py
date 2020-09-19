from cryptography.fernet import Fernet
from src.Helpers.sql import MySqlHelper
from src.Helpers.sql import MySqlHelper
from src.Helpers.stringHelper import StringHelper
from src.Core import propertyConstants as SpProperties


class EncryptionService:
    def __init__(self):
        self.__sql = MySqlHelper()
        self.__string_helper = StringHelper()
        self.__f = Fernet(self.__get_key())

    def encrypt(self, value):
        encoded_value = value.encode()
        return str(self.__f.encrypt(encoded_value).decode('utf-8'));

    def decrypt(self, value):
        value = bytes(value, 'utf-8')
        value = self.__f.decrypt(value)
        return str(value.decode())

    def __get_key(self):
        param = self.__string_helper.build_string("key")
        data = self.__sql.sp_get(SpProperties.Get_property_value, (param,), True)
        if not data:
            key = str(Fernet.generate_key().decode('utf-8'))
            key_param = self.__string_helper.build_string(key)
            name = self.__string_helper.build_string("key")
            self.__sql.sp_set(SpProperties.Create_property, (name, key_param))
            return bytes(key, 'utf-8')
        else:
            return bytes(data["propertyValue"], 'utf-8')