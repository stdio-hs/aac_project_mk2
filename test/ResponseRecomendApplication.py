import queue
from threading import Thread
from back_end.category_ai import Classifier
import time

class ResponseRecomendApp:
    def __init__(self):
        self.__recv_queue = queue.Queue()
        self.__send_queue = queue.Queue()
        self.__empty_data = False
        self.classifier = Classifier()
        inter_thread = Thread(target=self.__interfaceThread)
        inter_thread.start()
    
    def __interfaceThread(self):
        # bool_data = self.__isEmptyRecvQueue()
        while True:
            result = self.recvQueueDeque()

            if(result):
                if(result['alis']=='analysis'):
                    result_anas, res, ans_list = self.classifier.classifier(result['text'])
                    self.sendQueueEnque(result_anas, res, ans_list)
                    print("이거 send 큐에 추가해   ", result_anas, res, ans_list)
        #res가 태그, result_anas가 {"key":9021}같은 딕셔너리
        # category = Classifier(result)

    def recvQueueEnque(self, dict_msg):
        # '''
        # 1. recvThread에 들어온 dict메세지를 recvQueue에 집어넣는다.

        # '''
        self.__recv_queue.put(dict_msg)
        
    def recvQueueDeque(self):
        if self.__isEmptyRecvQueue():
            time.sleep(3)
            print('recv 큐가 비어있음')
            return None
        else:
            result = self.__recv_queue.get()
            return result
        
    def __isEmptyRecvQueue(self):       
        return self.__recv_queue.empty()
    
    
    def sendQueueEnque(self,dict_msg, res, ans_list):
        # '''
        # 1. sendQueue에 메세지를 집어넣음.
        # '''
        self.__send_queue.put((dict_msg,res, ans_list))
    
    def isEmptySendQueue(self):
        # '''
        # 1. sendQueue가 비어있는지 확인한다.
        # 2. 비어있다면 true, 비어있지 않다면 false를 반환한다.
        # '''
        return self.__send_queue.empty()

    
    def sendQueueDeque(self):
        # '''
        # 1. sendQueue가 비어있지 않다면 진행
        # 2. dict메세지를 전송?한다.
        # '''
        if self.isEmptySendQueue():
            print('send 큐가 비어있음')
            return None
        else:
            result = self.__send_queue.get()
            return result

    
    
       