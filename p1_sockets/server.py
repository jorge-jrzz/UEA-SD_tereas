import socket


SERVER_IP = 'xxx.xxx.xxx.xxx'
SERVER_PORT = 2020


class Uber:
    def __init__(self, plate: int, available: bool):
        """
        Initializes the Uber instance with a license plate and availability status.
        
        Parameters:
        plate (int): The license plate number of the Uber.
        is_available (bool): Whether the Uber is available or not. Default is True.
        """
        self._plate = plate
        self._available = available

    def set_availability(self, available):
        """Sets the availability status of the Uber."""
        self._available = available
    
    def is_available(self) -> bool:
        """Returns current status of the UBer """
        return self._available 




if __name__ == '__main__': 
    ganancia_total = 0.0
    num_viajes = 0
    
    uber1 = Uber(0, True)
    uber2 = Uber(1, True)
    uber3 = Uber(2, True)
    uber4 = Uber(3, True)
    uber5 = Uber(4, True)
    print(uber1.is_available()) 
    available_uber = [uber1, uber2, uber3, uber4, uber5]

    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_address = (SERVER_IP, SERVER_PORT)
    print('Iniciando en {} puerto {}'.format(*server_address))
    sock.bind(server_address)

    sock.listen(10)

    print('Esperando una conexion...')
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
                respuesta = f'Ganancias: {ganancia_total}, Viajes realizados: {num_viajes}'
                connection.sendall(respuesta.encode())
            else:
                respuesta = "Comando no reconocido"
                connection.sendall(respuesta.encode())

    finally:
        connection.close()

