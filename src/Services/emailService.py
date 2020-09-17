import smtplib, ssl
from src.Services.propertyService import PropertyService
from src.Helpers.sql import MySqlHelper
from src.Core import mailConstants as SpMail
from src.Helpers.stringHelper import StringHelper
from src.Helpers.encryptionHelper import EncryptionService
from src.Helpers.serializer import serialize_data_set
from nslookup import Nslookup

class EmailService:

    def __init__(self):
        self.__propertyService = PropertyService()
        self.__smtp_server = self.__propertyService.get_property_value("MailServer")
        self.__port = self.__propertyService.get_property_value("MailPort")
        # Create a secure SSL context
        self.__context = ssl.create_default_context()
        self.__sql = MySqlHelper()
        self.__str_helper = StringHelper()
        self.__encryption = EncryptionService()

    def __open_connection(self):
        self.__server =  smtplib.SMTP_SSL(self.__smtp_server +":"+ self.__port)

    def __close_connection(self):
        self.__server.quit()

    def __are_credentials_valid(self, email, password):
        try:
            self.__open_connection()
            self.__server.login(email, password)
            return True
        except Exception:
            return False
        finally:
            self.__close_connection()

    def send_mail(self, data):
        if not data["sender"]:
            raise KeyError("sender")

        if not data["reciever"]:
            raise KeyError("reciever")

        if not data["message"]:
            raise KeyError("message")

        sender_mail = data["sender"]
        reciever_mail = data["reciever"]
        message = data["message"]
        password = self.get_password(sender_mail)

        if not password:
            raise ValueError("Email no registrado")

        if not self.__are_credentials_valid(sender_mail, password):
            raise ValueError("Es necesario actualizar la contraseña para mail: " + sender_mail)

        if not self.is_domain_valid(reciever_mail):
            raise ValueError("La dirección a la que se trata de enviar el correo es inválida")

        self.__open_connection()
        self.__server.login(sender_mail, password)
        self.__server.sendmail(sender_mail, reciever_mail, message)
        self.__close_connection()

    def get_password(self, mail):
        mail = self.__str_helper.build_string(mail)
        data = self.__sql.sp_get(SpMail.Get_password, (mail, ), True)
        if data:
            return self.__encryption.decrypt(data["pswd"])

        return data

    def save_email(self, data):
        if not data["email"]:
            raise KeyError("email")

        if not data["password"]:
            raise KeyError("password")

        if not self.__are_credentials_valid(data["email"], data["password"]):
            raise ValueError("Credenciales inválidas")
        mail = data["email"]
        mail = self.__str_helper.build_string(mail)
        password = self.__encryption.encrypt(data["password"])
        password = self.__str_helper.build_string(password)

        args = (mail, password)

        if self.__sql.sp_get(SpMail.Get_password, (mail, ), True):
            raise ValueError("Ya hay un email registrado con la misma dirección")

        self.__sql.sp_set(SpMail.Insert_mail, args)

    def get_emails(self):
        data = self.__sql.sp_get(SpMail.Get_emails_registered)
        return serialize_data_set(data, "Emails")

    def delete_mail(self, mail):
        if not self.get_password(mail):
            raise ValueError("Email no encontrado")
        mail = self.__str_helper.build_string(mail)
        self.__sql.sp_set(SpMail.Delete_mail, (mail, ))

    def update_password(self, data):
        if not data["email"]:
            raise KeyError("email")

        if not data["password"]:
            raise KeyError("password")

        if not self.get_password(data["email"]):
            raise ValueError("Email no encontrado")

        if not self.__are_credentials_valid(data["email"], data["password"]):
            raise ValueError("Credenciales inválidas")

        mail = data["email"]
        mail = self.__str_helper.build_string(mail)

        password = self.__encryption.encrypt(data["password"])
        password = self.__str_helper.build_string(password)

        args = (mail, password)
        self.__sql.sp_set(SpMail.Update_password, args)

    @staticmethod
    def is_domain_valid(email):
        if not "@" in email:
            return False
        domain = email.split("@")
        domain = domain[1]
        dns_query = Nslookup(dns_servers=["1.1.1.1"])

        ips_record = dns_query.dns_lookup(domain)
        print(ips_record.response_full, ips_record.answer)
        if not ips_record.response_full or not ips_record.answer:
            return False

        return True
