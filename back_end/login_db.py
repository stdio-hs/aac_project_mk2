import requests
from urllib.parse import urlparse
import json
import back_end
from pymongo import MongoClient
import certifi

class Login():
    def __init__(self, phone, pw):
        self.phone = phone
        self.pw = pw

    def login(self):
        mongo_connect = back_end.constant.mongo_key
        client = MongoClient(mongo_connect, tlsCAFile=certifi.where())
        db = client.temp

        try:
            db_data = list(db.account.find({'phone':{'$regex': self.phone}}))
            user_data = dict(db_data[0])
            password_db = user_data['pw']

            if(self.pw == password_db):
                response = {"message":"login success"} #,"status": HTTPStatus.OK
                return response
            else:
                response = {"message":"login failed: passwrod wrong"} #,"status": HTTPStatus.OK
                return response

        except:
            response = {"message":"login failed: none phone number"}#,"status": HTTPStatus.OK
            return response 