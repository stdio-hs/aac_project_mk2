from back_end.category_ai import Classifier

class ResponseChattingProtocol:
    def __init__(self):
        self.__dict_message = None
        self.__str_message = None
        self.classifier = Classifier()

    def stringToDict(self, str_msg):
        '''
        1. client가 요청한 메세지를 dict형으로 변경한다.
        2. dict형 메세지를 반환한다.
        '''
        data_list = str_msg.split(' ', 3)

        data = {}
        #데이터 타입
        data['head'] = data_list[0]
        #날짜
        data['body'] = data_list[1]
        #분석
        data['alis'] = data_list[2]
        #내용
        data['text'] = data_list[3]
        
        if(data['alis']=='analysis'):
            result = self.classifier.classifier(data['text'])
            return result
        else:
            return data
        # 프로토콜

        #self.__dict_message = dict(str_msg)
        # return data
        
    def dictToString(self, dict_msg):
        '''
        1. dict메세지를 string형으로 바꾼다.
        2. string메세지를 반환한다.
        '''
        
        # data = []
        # data = dict_msg['head'] + dict_msg['body']
        # print(dict_msg)
        
        self.__str_message = str(dict_msg)
        return self.__str_message