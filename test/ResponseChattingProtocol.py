class ResponseChattingProtocol:
    def __init__(self):
        self.__dict_message = None
        self.__str_message = None

    def __stringToDict(self, str_msg):
        '''
        1. client가 요청한 메세지를 dict형으로 변경한다.
        2. dict형 메세지를 반환한다.
        '''
        self.__dict_message = dict(str_msg)
        return self.__dict_message
        
    def __dictToString(self, dict_msg):
        '''
        1. dict메세지를 string형으로 바꾼다.
        2. string메세지를 반환한다.
        '''
        self.__str_message = str(dict_msg)
        return self.__str_message