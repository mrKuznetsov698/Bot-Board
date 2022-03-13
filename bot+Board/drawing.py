import socket

class Draw:
    def __init__(self, port: int, addr: str = '127.0.0.1'):
        self.cl = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.cl.connect((addr, port))

    def set(self, x, y):
        self.cl.send((f'1 {x} {y}\n').encode('utf-8'))

    def clear(self, x, y):
        self.cl.send((f'0 {x} {y}\n').encode('utf-8'))

