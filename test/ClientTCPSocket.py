from ResponseChattingProtocol import *

import threading
from socket import socket, _RetAddress

class ClientTCPSocket:
    def __init__(self, socket:socket, addr:_RetAddress):
        self.__socket:socket = socket
        self.__addr:_RetAddress = addr
        self.__rcp = ResponseChattingProtocol()
        self.__string_message = None
        self.__dict_message = None
    
    def recvData(self, msg):
        '''
        1. string을 dict로 변환하기
        2. recvThread로부터 메시지를 받는다.
        '''
        self.__dict_message = self.__rcp.__stringToDict(msg)        
        self.__socket.recv(self.__dict_message)

    def sendData(self, msg):
        '''
        1. dict를 string으로 변환하기
        2. sendThread로 메시지를 보낸다.
        '''
        self.__string_message = self.__rcp.__dictToString(msg)
        self.__socket.send(self.__string_message)
        