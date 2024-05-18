from socket import socket
# import threading
from _thread import *


class ASGI:
    def __init__(self):
        self.__socket = socket()
        self.__send_thread = start_new_thread()

    def start(self):
        return
    
    def clientHandleThread(self):
        return
    def sendThread(self):
        
        return 
    def recvThread(self):
        
        return 