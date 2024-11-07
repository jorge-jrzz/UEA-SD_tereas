import os
import socket
import time
import random
from typing import Any


SERVER_IP = 'localhost'
SERVER_PORT = 2020

def connect_to_server() -> Any:
    socket_client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_address = (SERVER_IP, SERVER_PORT)
    print("------------------------------------------")
    print(f"Connecting to {server_address[0]} in the port {server_address[1]} ...")
    socket_client.connect(server_address)
    return socket_client

def get_response(conn: Any) -> Any:
    data = conn.recv(1024)
    return data.decode().split(',')

if __name__ == '__main__':
    os.system('clear')
    print("\n ****************** UBER CLIENT ****************** \n")

    try: 
        conn = connect_to_server()
    except Exception as e:
        print(f"Error connecting to server: {e}")
        exit()
    
    print(" * Connected to server *")
    print("------------------------------------------\n")
    while True:
        print("Select an option:")
        print("\t1. Check status")
        print("\t2. Request a ride")
        print("\t3. Exit\n")
        option = input("Option: ")
        match option:
            case "1":
                print("Checking status")
                conn.sendall("estado".encode())
                response = get_response(conn)
                print(f"* Response: {response} *\n")
                if int(response[0]) == 0:
                    print(f"\tEarnings: $ {response[1]} | Trips: {response[0]}\n")
                else:
                    print("\tNo information available")
                conn.close()
                break
            case "2":
                print("Requesting a ride")
                conn.sendall("viaje".encode())
                response = get_response(conn)
                print(f"* Response: {response} *\n")
                if int(response[0]) == 1:
                    print("\tRide in progress . . .\n")
                    time.sleep(random.randint(3, 8))
                    conn.sendall(f"terminar,{response[1]}".encode())
                    print("\tRide finished\n")
                elif int(response[0]) == -1:
                    print("\tNo cars available\n")
                conn.close()
                break
            case "3":
                print("Exiting")
                conn.close()
                break
            case _:
                print("Invalid option")
                time.sleep(1.5)
                os.system('clear')
                continue
