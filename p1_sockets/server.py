from uber import Uber
import socket
import random

SERVER_IP = '0.0.0.0'
SERVER_PORT = 2020

if __name__ == '__main__': 
    ganancia_total = 0.0
    num_viajes = 0
    
    available_uber = [Uber(i, True) for i in range(5)]
    
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_address = (SERVER_IP, SERVER_PORT)
    print('Iniciando en {} puerto {}'.format(*server_address))
    sock.bind(server_address)
    sock.listen(10)

    while True:
        print('Esperando conexión...')
        connection, client_address = sock.accept()
        print('Conectado a', client_address)
        try:
            while True:
                data = connection.recv(1024)
                if not data:
                    print("El cliente se ha desconectado.")
                    break
                message = data.decode()
                print('Mensaje recibido:', message)
                if message == 'estado':
                    respuesta = f'0,{ganancia_total},{num_viajes}'
                    connection.sendall(respuesta.encode())
                elif message == 'viaje':
                    current_plate = -1
                    for uber in available_uber:
                        if uber.is_available():
                            uber.set_availability(False)  # Marcar el Uber como ocupado
                            current_plate = uber.get_plate()
                            break
                    if current_plate == -1:
                        respuesta = "-1,No hay autos disponibles"
                    else:
                        precio_viaje = random.randint(23, 100)
                        respuesta = f'1,{current_plate},{precio_viaje}'
                        ganancia_total += precio_viaje
                        num_viajes += 1
                        connection.sendall(respuesta.encode())
                elif message.startswith('terminar'):
                    plate_to_free = int(message.split(',')[1])
                    available_uber[plate_to_free].set_availability(True)  # Liberar el Uber
                    respuesta = f'Uber {plate_to_free} está disponible nuevamente.'
                    print(respuesta)
                    connection.sendall(respuesta.encode())  # Enviar confirmación al cliente
                else:
                    respuesta = "Comando no reconocido"
                    connection.sendall(respuesta.encode())
        except Exception as e:
            print('Error con el cliente:', e)
        finally:
            connection.close()

