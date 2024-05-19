import time
from threading import Thread
from socket import socket, AF_INET, SOCK_STREAM

def main2():
    head = "INIT"
    route = "/handover"

    HOST = "127.0.0.1"
    PORT = 5000
    client_socket = socket(AF_INET, SOCK_STREAM)
    client_socket.connect((HOST, PORT))
    #head = "POST /test HTTP/1.1\r\n"
    
    flag = [True]
    send_thread = Thread(target=send, args=(client_socket,flag, ))
    recv_thread = Thread(target=recv, args=(client_socket,flag, ))

    send_thread.start()
    recv_thread.start()

    send_thread.join()
    recv_thread.join()

def send(client_socket:socket, flag):
    while flag[0]:
        time.sleep(1)
        data = "hi hello afdfaf faaffa"
        client_socket.send(data.encode())

        

def recv(client_socket:socket, flag):
    while flag[0]:
        data = client_socket.recv(1024)
        print(data.decode())

if __name__ == "__main__":
    main2()