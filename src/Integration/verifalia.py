from src.Services.propertyService import PropertyService
import requests


class VerifaliaService:
    def __init__(self):
        self.__property_service = PropertyService()
        self.__user = self.__property_service.get_property_value("VerifaliaUser")
        self.__password = self.__property_service.get_property_value("VerifaliaPassword")
        self.__auth_enpoint = self.__property_service.get_property_value("VerifaliaAuth")
        self.__validation_endpoint = self.__property_service.get_property_value("VerifaliaCreate")
        self.__token = self.get_token()

    def get_token(self):
        credentials = {
            "username": self.__user,
            "password": self.__password
        }
        resp = requests.post(self.__auth_enpoint, json=credentials)
        if resp.status_code == 200:
            return resp.json()["accessToken"]
        else:
            return ""

    def create_validation(self, email):
        body = {"entries": [{"inputData": email}]}
        resp = requests.post(self.__validation_endpoint, json=body, headers={"Authorization": "Bearer " + self.__token})
        if resp.status_code == 202:
            return resp.json()["overview"]["id"]
        return None

    def get_validation_status(self, id):
        resp = requests.get(self.__validation_endpoint + "/" + id, headers={"Authorization": "Bearer " + self.__token})
        if resp.status_code == 200:
            while resp.json()["overview"]["status"] == "InProgress" and resp.status_code == 200:
                resp = requests.get(self.__validation_endpoint + "/" + id,
                                    headers={"Authorization": "Bearer " + self.__token})
            return resp.json()["entries"]["data"][0]["classification"]

        elif resp.status_code == 402:
            return "Unpaid"

        return "Unknown"

    def validate(self, email):
        validation_id = self.create_validation(email)
        if not validation_id:
            print("Couldn't validate email")
            return True
        status = self.get_validation_status(validation_id)

        return status != "Undeliverable"
