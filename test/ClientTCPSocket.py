from .ResponseChattingProtocol import *

import threading
from socket import socket

class ClientTCPSocket:
    def __init__(self, socket:socket, addr):
        self.__socket:socket = socket
        self.__addr = addr
        self.__rcp = ResponseChattingProtocol()
        self.__string_message = None
        self.__dict_message = None
    
    def recvData(self):
        '''
        1. string을 dict로 변환하기
        2. recvThread로부터 메시지를 받는다.
        '''
        self.__string_message = self.__socket.recv(1024)
        self.__dict_message = self.__rcp.stringToDict(self.__string_message.decode()) 
        return self.__dict_message
  

    def sendData(self, msg):
        '''
        1. dict를 string으로 변환하기
        2. sendThread로 메시지를 보낸다.
        '''

        self.__string_message = self.__rcp.dictToString(msg.encode('utf-8'))
        self.__socket.send(b'self.__string_message')

        
        