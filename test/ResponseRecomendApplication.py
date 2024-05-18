import queue

class ResponseRecomendApp:
    

    def __init__(self):
        self.__recv_queue = queue.Queue()
        self.__send_queue = queue.Queue()
        self.__empty_data = False
    
    def recvQueueEnque(self, msg):
        '''
        1. recvThread에 들어온 dict메세지를 recvQueue에 집어넣는다.

        '''
        self.__recv_queue.put(msg)
        
    def recvQueueDeque(self, msg):
        self.__recv_queue.get(msg)
        
    
    def sendQueueEnque(self,msg):
        '''
        1. sendQueue에 메세지를 집어넣음.
        '''
        self.__send_queue.put(msg)
    
    def isEmptySendQueue(self):
        '''
        1. sendQueue가 비어있는지 확인한다.
        2. 비어있다면 true, 비어있지 않다면 false를 반환한다.
        '''
        return self.__send_queue.empty()

    
    def sendQueueDeque(self, msg):
        '''
        1. sendQueue가 비어있지 않다면 진행
        2. dict메세지를 반환? 전송?한다.
        '''
        if self.__send_queue.isEmptySendQueue():
            print('큐가 비어있음')
        else:
            self.__send_queue.get(msg)
        return
    
    