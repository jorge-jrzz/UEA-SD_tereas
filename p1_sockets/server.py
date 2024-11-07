from uber import Uber

import socket
import random

SERVER_IP = '0.0.0.0'
SERVER_PORT = 2020

if __name__ == '__main__': 
    ganancia_total = 0.0
    num_viajes = 0
    
    available_uber = [Uber(i, True) for i in range(0, 5)]
    
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_address = (SERVER_IP, SERVER_PORT)
    print('Iniciando en {} puerto {}'.format(*server_address))
    sock.bind(server_address)

    sock.listen(10)

    print('Esperando una conexion...')
    # connection, client_address = sock.accept()
    # print('Conectado a', client_address)

    

    while True:
        print('Esperando conexion . . .')
        connection, client_address = sock.accept()
        print('Conectado a', client_address)

        try:
            while True:
                data = connection.recv(1024)
                if not data:
                    print("El cliente se ha desconectado.")
                    break

                print('Mensaje recibido:', data.decode())
    
                if data.decode() == 'estado':
                    respuesta = f'0,{ganancia_total},{num_viajes}'
                    connection.sendall(respuesta.encode())
                elif data.decode() == 'viaje':
                    current_plate = -1
                    for uber in available_uber:
                        if uber.is_available():
                            uber.set_availability(False)
                            current_plate = uber.get_plate()
                            break
                    respuesta = f'1,{current_plate},{random.randint(23, 100)}'
                    connection.sendall(respuesta.encode())
                elif data.decode().split(',')[0] == 'terminar':
                    available_uber[int(data.decode().split(',')[1])].set_availability(True)
                else:
                    respuesta = "Comando no reconocido"
                    connection.sendall(respuesta.encode())
        except Exception as e:
            print('Error con el cliente: ', e)
        finally:
            connection.close()
        
