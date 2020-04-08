import hashlib
from datetime import datetime
from src.Core.constants import SpUsers
from src.Helpers.serializer import serialize_data_set
from src.Helpers.sql import MySqlHelper
from src.Helpers.stringHelper import StringHelper


class UsersService:
    def __init__(self):
        self.__sql_helper = MySqlHelper()
        self.hash = hashlib.new("ripemd160")
        self.__string_helper = StringHelper()

    def create_user(self, user_name, password):
        if not self.__validate_string(user_name):
            raise ValueError("Invalid username")
        if not self.__validate_string(password):
            raise ValueError("Username must contain more than 5 letters")

        user_name = self.__string_helper.build_string(user_name)
        password = self.__string_helper.build_string(self.__encrypt(password))
        token = self.__string_helper.build_string(self.__encrypt(password + str(datetime.now())))
        args = (user_name, password, token)
        self.__sql_helper.sp_set(SpUsers.Register, args)

    def user_authentication(self, user_name, password):
        if not self.__validate_string(user_name):
            raise ValueError("Invalid username")
        if not self.__validate_string(password):
            raise ValueError("Username must contain more than 5 letters")

        password = self.__string_helper.build_string(self.__encrypt(password))
        user_name = self.__string_helper.build_string(user_name)
        args = (user_name, password)
        token = self.__sql_helper.sp_get(SpUsers.Authenticate, args, True)
        return serialize_data_set(token)

    def token_validation(self, token):
        if len(str(token)) != 40:
            return False

        token = self.__string_helper.build_string(token)
        args = (token, )
        result = self.__sql_helper.sp_get(SpUsers.Authorize, args, True)
        if result['Result'] == 1:
            return True

        return False

    def __encrypt(self, string):
        self.hash.update(string.encode('utf-8'))
        return self.hash.hexdigest()

    @staticmethod
    def __validate_string(string):
        if len(str(string)) < 5:
            return False
        if not string:
            return False
        return True
