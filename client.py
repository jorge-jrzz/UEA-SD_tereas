import socket
import time

if __name__ == '__main__':    
    socket_client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_address = ('localhost', 10000)
    print('Conectando a {} puerto {}'.format(*server_address))
    socket_client.connect(server_address)

    try:
        while True:
            # Enviar mensaje al servidor
            message = input("Introduzca el mensaje para el servidor: ") or "estado"
            socket_client.sendall(message.encode())
            
            # Recibir respuesta del servidor
            data = socket_client.recv(1024)
            print('Respuesta del servidor:', data.decode())
            
            # Pausa para no sobrecargar
            time.sleep(1)
    finally:
        # Cerrar conexión al finalizar
        socket_client.close()

