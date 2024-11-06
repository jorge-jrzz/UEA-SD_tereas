import socket
import time
import random

SERVER_IP = 'xxx.xxx.xxx.xxx'
SERVER_PORT = 2020

if __name__ == '__main__':    
    socket_client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_address = (SERVER_IP, SERVER_PORT)
    print('Conectando a {} puerto {}'.format(*server_address))
    socket_client.connect(server_address)

    try:
        while True:
            # Enviar mensaje al servidor
            message = input("Introduzca el mensaje para el servidor: ")
            socket_client.sendall(message.encode())
            
            # Recibir respuesta del servidor
            data = socket_client.recv(1024)
            request = data.decode().split(',')

            print('Respuesta del servidor:', request)
            if int(request[0]) == -1:
                print('No hay autos disponibles')
            else:
                print('Viaje en curso . . .')
                time.sleep(random.randint(3, 8))
                socket_client.sendall(f'terminar,{request[0]}'.encode())

            # Pausa para no sobrecargar
            time.sleep(1)
    finally:
        # Cerrar conexión al finalizar
        socket_client.close()

