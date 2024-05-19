import requests
from urllib.parse import urlparse
import json
import back_end
from pymongo import MongoClient
import certifi

class Register():
    def __init__(self, name, phone, pw):
        self.name = name
        self.phone = phone
        self.pw = pw

    def __check_valid(self):
        mongo_connect = back_end.constant.mongo_key
        client = MongoClient(mongo_connect, tlsCAFile=certifi.where())
        db = client.temp

        try: 
            db_data = list(db.account.find({'phone':{'$regex': self.phone}}))
           
            if(len(self.phone)!=11):
                return False #아래랑 상관은 없지만 전화번호 길이가 잘못됨
            elif not db_data:
                return True #리스트가 비어있음 ( 데이터 없음 )
            else:
                return False #리스트에 정보가 있음
        except: 
            return True # 못찾음

    def register(self):
        #db 연결
        mongo_connect = back_end.constant.mongo_key
        client = MongoClient(mongo_connect, tlsCAFile=certifi.where())
        db = client.temp

        #db에 넘길 데이터
        user_account_info={
            'name': self.name,
            'phone': self.phone,
            'pw': self.pw
            }
        user_data={
            'phone': self.phone,
            'fav': []
        }
        
        #중복확인
        check_reg = self.__check_valid()

        if(check_reg==False): #이미 있거나 전화번호 길이가 잘못됨
            response = {"message":"register failed phone already exists or invalid number"}
            return response
        
        else:
            try: #없으면 추가
                db.account.insert_one(user_account_info)
                db.user_data.insert_one(user_data)
                response = {"message":"register success"} #,"status": HTTPStatus.OK
                return response

            except: #없지만 뭔가 문제가 생김 (잘못된? 데이터)
                response = {"message":"register failed"} #,"status": HTTPStatus.OK
                return response
        
        
