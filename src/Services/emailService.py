import smtplib, ssl
from src.Services.propertyService import PropertyService
from src.Helpers.sql import MySqlHelper
from src.Core import mailConstants as SpMail
from src.Helpers.stringHelper import StringHelper
from src.Helpers.encryptionHelper import EncryptionService
from src.Helpers.serializer import serialize_data_set
from email.mime.text import MIMEText
import urllib.request
from email.mime.multipart import MIMEMultipart
from email import encoders
from email.mime.base import MIMEBase
from src.Helpers import validators
from src.Integration.verifalia import VerifaliaService
from src.Core import resourcesConstants
import threading


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

    def validate_and_send_mail(self, data):
        if not data:
            raise ValueError("Datos faltantes")

        if not data["sender"]:
            raise KeyError("sender")

        if not data["receiver"]:
            raise KeyError("receiver")

        if not data["message"]:
            raise KeyError("message")

        if not data["subject"]:
            raise KeyError("subject")

        sender_mail = data["sender"]
        receiver_mail = data["receiver"]
        message = data["message"]
        subject = data["subject"]
        password = self.get_password(sender_mail)

        if not password:
            raise ValueError("Email no registrado")

        if not self.__are_credentials_valid(sender_mail, password):
            raise ValueError("Es necesario actualizar la contraseña para mail: " + sender_mail)

        if not validators.is_email_valid(receiver_mail):
            raise ValueError("La dirección a la que se trata de enviar el correo es inválida")

        # Class instance at run time due to bearer token request
        verifalia = VerifaliaService()
        if not verifalia.validate(receiver_mail):
            raise ValueError("La dirección a la que se trata de enviar el correo es inválida")

        threading.Thread(target=self.__send_email,
                         args=(sender_mail, receiver_mail, message, subject, password),
                         daemon=True).start()

    def __send_email(self, sender_mail, receiver_mail, message, subject, password):
        self.__open_connection()
        self.__server.login(sender_mail, password)
        template = MIMEText(self.get_email_template(), "html")
        message = MIMEText(message, "plain")
        mail = MIMEMultipart()
        mail['Subject'] = subject
        mail['From'] = sender_mail
        mail['To'] = receiver_mail

        mail.attach(message)
        mail.attach(template)
        mail.attach(self.get_pdf_attachment())
        self.__server.sendmail(sender_mail, receiver_mail, mail.as_string())
        self.__close_connection()

    def get_password(self, mail):
        mail = self.__str_helper.build_string(mail)
        data = self.__sql.sp_get(SpMail.Get_password, (mail, ), True)
        if data:
            return self.__encryption.decrypt(data["pswd"])

        return data

    def save_email(self, data):
        if not data:
            raise ValueError("Datos incompletos")

        if not data["email"]:
            raise KeyError("email")

        if not data["password"]:
            raise KeyError("password")

        if not validators.is_email_valid(data["email"]):
            raise ValueError("Correo inválido")

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
        if not data:
            raise ValueError("Datos incompletos")

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
    def get_email_template():
        url = resourcesConstants.email_template
        fp = urllib.request.urlopen(url)
        mybytes = fp.read()

        mystr = mybytes.decode("utf8")
        fp.close()
        return mystr

    @staticmethod
    def get_pdf_attachment():
        url = resourcesConstants.pdf_attachment
        fp = urllib.request.urlopen(url)
        # Add file as application/octet-stream
        # Email client can usually download this automatically as attachment
        part = MIMEBase("application", "octet-stream")
        part.set_payload(fp.read())
        # Encode file in ASCII characters to send by email
        encoders.encode_base64(part)

        # Add header as key/value pair to attachment part
        part.add_header(
            "Content-Disposition",
            "attachment; filename= BrochureAmpliaVision.pdf",
        )
        return part
