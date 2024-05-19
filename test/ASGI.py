from .ResponseRecomendApplication import *
from .ResponseChattingProtocol import *
from .ClientTCPSocket import *

from socket import socket, AF_INET, SOCK_STREAM
from threading import Thread
from _thread import *
import time


HOST = '127.0.0.1'
PORT = 5000

class ASGI:
    def __init__(self):
        #self.__socket = ClientTCPSocket()
        #self.__recomment_app = ResponseRecomendApp()
        #self.__send_thread = Thread(send_thread, "send Thread입니다.")
        #self.__recv_thread = Thread(recv_thread, "recv Thread입니다.")
        return 
    
    # 서버 소켓을 실행하는 부분(바인드)
    def __set_server_socket(self):
        server_socket = socket(AF_INET, SOCK_STREAM)
        server_socket.bind((HOST, PORT))
        server_socket.listen()
        print(f"[:     Server Start with {HOST} | {str(PORT)}")
        return server_socket

    # 새로운 클라이언트를 받아내는 부분
    def start(self):
        server_socket = self.__set_server_socket()
        while True:
            client_socket, addr = server_socket.accept()
            client_tcp_socket = ClientTCPSocket(socket=client_socket,
                                                addr= addr,)
            rra = ResponseRecomendApp()
            thread = Thread(target=self.__clientHandleThread,
                            args=(client_tcp_socket,rra))
            thread.start()
    
    def __clientHandleThread(self, client_tcp_socket, rra):
        # send와 recv하는 스레드로 분기
        send_thread = Thread(target=self.__sendThread,
                             args= (client_tcp_socket,rra))
        recv_thread = Thread(target=self.__recvThread,
                             args= (client_tcp_socket,rra))
        send_thread.start()
        recv_thread.start()


    def __sendThread(self, client_tcp_socket:ClientTCPSocket, rra:ResponseRecomendApp):
        data = "Hello my server"
        while True:
            time.sleep(1)
            # client_tcp_socket.sendData(data)
            
            if not rra.isEmptySendQueue():
                data = rra.sendQueueDeque()
                client_tcp_socket.sendData(data)
            

    def __recvThread(self, client_tcp_socket:ClientTCPSocket, rra:ResponseRecomendApp):
        while True:
            data = client_tcp_socket.recvData()
            print(data)
            rra.recvQueueEnque(data)

if __name__ == "__main__":
    asgi = ASGI()
    asgi.start()