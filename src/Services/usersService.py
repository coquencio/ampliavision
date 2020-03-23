import hashlib
from datetime import datetime
from src.Core.constants import SpUsers
from src.Helpers.serializer import JsonHelper
from src.Helpers.sql import *


class UsersService:
    def __init__(self):
        self.__sql_helper = MySqlHelper()
        self.hash = hashlib.new("ripemd160")
        self.json_helper = JsonHelper

    def create_user(self, user_name, password):
        if not self.__validate_string(user_name):
            raise ValueError("Invalid username")
        if not self.__validate_string(password):
            raise ValueError("Username must contain more than 5 letters")

        user_name = "'" + user_name + "'"
        password = "'" + self.__encrypt(password) + "'"
        token = "'" + self.__encrypt(password + str(datetime.now())) + "'"
        args = (user_name, password, token)
        self.__sql_helper.sp_set(SpUsers.Register, args)

    def user_authentication(self, user_name, password):
        if not self.__validate_string(user_name):
            raise ValueError("Invalid username")
        if not self.__validate_string(password):
            raise ValueError("Username must contain more than 5 letters")

        password = "'"+self.__encrypt(password)+"'"
        user_name = "'"+user_name+"'"
        args = (user_name, password)
        token = self.__sql_helper.sp_get(SpUsers.Authenticate, args, True)
        return self.json_helper.serialize_data_set(token)

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
