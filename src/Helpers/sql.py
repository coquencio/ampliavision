from src.Core.constants import Connection
from src.Helpers.serializer import *
import pymysql


class MySqlHelper:
    def __init__(self):
        self.host = Connection.SQL_HOST
        self.user = Connection.SQL_USER
        self.password = Connection.SQL_PASSWORD
        self.database = Connection.SQL_DB

    def __connect(self):
        return pymysql.Connect(
            host=self.host,
            user=self.user,
            passwd=self.password,
            db=self.database,
            cursorclass=pymysql.cursors.DictCursor)

    def execute_sp(self, sp_name, args=None):
        db = self.__connect()
        cursor = db.cursor()
        if not args:
            cursor.execute("call " + sp_name + "()")
        else:
            cursor.execute("call " + sp_name + self.__build_string_params(args))
        db.commit()
        db.close()

    def fetch_data_set(self, query, key):
        db = self.__connect()
        cursor = db.cursor()
        cursor.execute(query)
        data_set = cursor.fetchall()
        db.close()
        return JsonHelper.serialize_data_set(data_set, key)

    @staticmethod
    def __build_string_params(params):
        to_return = "("
        for arg in params:
            to_return += str(arg) + ", "

        to_return = to_return[0:(len(to_return) - 2)]
        to_return += ")"
        return to_return
