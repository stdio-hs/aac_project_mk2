import threading
from socket import socket, _RetAddress

class ClientTCPSocket:
    def __init__(self, socket:socket, addr:_RetAddress):
        self.__socket:socket = socket
        self.__addr:_RetAddress = addr
    
    def recv(self, msg):
        '''
        1. recvThread로부터 메시지를 받는다.
        '''
        self.__socket.recv()

    def send(self, msg):
        '''
        1. sendThread로 메시지를 보낸다.
        '''
        self.__socket.send()