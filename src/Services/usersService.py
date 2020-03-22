import hashlib
from datetime import datetime
from src.Core.constants import SpUsers

from src.Helpers.sql import *


class UsersService:
    def __init__(self):
        self.__sql_helper = MySqlHelper()
        self.hash = hashlib.new("ripemd160")

    def create_user(self, user_name, password):
        if not self.__validate_string(user_name):
            raise ValueError("Invalid username")
        if not self.__validate_string(password):
            raise ValueError("Username must contain more than 5 letters")

        user_name = "'" + user_name + "'"
        password = "'" + self.encrypt(password) + "'"
        token = "'" + self.encrypt(password + str(datetime.now())) + "'"
        args = (user_name, password, token)
        self.__sql_helper.execute_sp(SpUsers.Register, args)

    def encrypt(self, string):
        self.hash.update(string.encode('utf-8'))
        return self.hash.hexdigest()

    @staticmethod
    def __validate_string(string):
        if len(str(string)) < 5:
            return False
        if not string:
            return False
        return True
