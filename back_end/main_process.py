import back_end

class MainFunction():
    def __init__(self):
        self.status = 0
        self.recognizer = back_end.Recognizer()
    
    def __call__(self):
        if self.status == 0:
            print("Init") 
        elif self.status == 1:
            print("Working")
        else:
            print("Error")

    #wav 분석
    #라벨을 반환
    def recog_wav(self, txt):
        self.status = 1
        self()
        try:
            result = self.recognizer.recognizer(txt)
        except Exception as e:
            print("ERROR_main : ", e)
            result = {'key' : "ERROR" }
            self.status == -1
            self()

        self.status = 0
        self()
        return result

    def recog_gps(self, x, y):
        self.status = 1
        self.gps = back_end.GPS(x,y)
        self()

        #---------------
        #분석기 생성
        #recognizer = back_end.GPS(x, y)
        # 분석
        result = self.gps.gps_analyzer()
        # 분석기 메모리 반환 
        recognizer = None

        self.status = 0
        self()
        return result

    # def login_req(self, phone, pw):
    #     self.status = 1
    #     self.login = back_end.Login(phone, pw)
    #     self()

    #     result = self.login.login()

    #     self.status = 0
    #     self()
    #     return result

    # def register_req(self, name, phone, pw):
    #     self.status = 1
    #     self.register = back_end.Register(name, phone, pw)
    #     self()

    #     result = self.register.register()


    #     self.status = 0
    #     self()
        
    #     return result
    
    # def update_user_fav_data(self, phone, fav_data):
    #     self.status = 1
    #     self.update_fav = back_end.UpdateFav(phone, fav_data)
    #     self()

    #     result = self.update_fav.update_fav()


    #     self.status = 0
    #     self()
        
    #     return result
    
    # def get_user_fav_data(self,phone):
        self.status = 1
        self.get_fav = back_end.GetFav(phone)
        self()

        result = self.get_fav.get_fav()


        self.status = 0
        self()
        
        return result



