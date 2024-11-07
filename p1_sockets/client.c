#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h> 
#include <time.h> 

#define SERVER_IP "localhost"
#define SERVER_PORT 2020


void pause_sleep(float seconds) {
    usleep((int)(seconds * 1000000));  // microsegundos
}

int connect_to_server(int *socket_client) {
    struct sockaddr_in server_address;

    // Crear el socket
    *socket_client = socket(AF_INET, SOCK_STREAM, 0);
    if (*socket_client < 0) {
        perror("Error al crear el socket");
        return -1;
    }

    // Configuración de la dirección del servidor
    server_address.sin_family = AF_INET;
    server_address.sin_port = htons(SERVER_PORT);
    if (strcmp(SERVER_IP, "localhost") == 0) {
        server_address.sin_addr.s_addr = inet_addr("127.0.0.1");
    } else {
        server_address.sin_addr.s_addr = inet_addr(SERVER_IP);
    }

    printf("------------------------------------------\n");
    printf("Conectando a %s en el puerto %d...\n", SERVER_IP, SERVER_PORT);
    if (connect(*socket_client, (struct sockaddr *)&server_address, sizeof(server_address)) < 0) {
        perror("Error al conectar con el servidor");
        close(*socket_client);
        return -1;
    }

    return 0;
}

int get_response(int socket_client, char *response) {
    char buffer[1024];
    int bytes_received = recv(socket_client, buffer, sizeof(buffer) - 1, 0);
    if (bytes_received < 0) {
        perror("Error al recibir la respuesta");
        return -1;
    }
    buffer[bytes_received] = '\0';
    strcpy(response, buffer);
    return 0;
}

int main() {
    int socket_client;
    char response[1024];
    char option[10];

    // Random
    srand(time(NULL));

    system("clear");
    printf("\n ****************** UBER CLIENT ****************** \n");

    // Conectar al servidor
    if (connect_to_server(&socket_client) < 0) {
        printf("Error al conectar con el servidor.\n");
        return 1;
    }
    printf(" * Conectado al servidor *\n");
    printf("------------------------------------------\n\n");

    while (1) {
        printf("Seleccione una opción:\n");
        printf("\t1. Verificar estado\n");
        printf("\t2. Solicitar un viaje\n");
        printf("\t3. Salir\n\n");
        printf("Opción: ");
        fgets(option, sizeof(option), stdin);
        option[strcspn(option, "\n")] = 0;

        // Manejo de opciones
        if (strcmp(option, "1") == 0) {
            printf("Verificando estado\n");
            send(socket_client, "estado", strlen("estado"), 0);
            if (get_response(socket_client, response) == 0) {
                printf("* Respuesta: [%s] *\n\n", response);
                int viajes;
                int status;
                char ganancias[50];
                sscanf(response, "%d,%49[^,]s,%d", &status, ganancias, &viajes);
                if (viajes == 0) {
                    printf("\tGanancias: $%s | Viajes: %d\n\n", ganancias, viajes);
                } else {
                    printf("\tNo hay información disponible\n");
                }
            }
            close(socket_client);
            break;
        } else if (strcmp(option, "2") == 0) {
            printf("Solicitando un viaje\n");
            send(socket_client, "viaje", strlen("viaje"), 0);
            if (get_response(socket_client, response) == 0) {
                printf("* Respuesta: [%s] *\n\n", response);
                int status;
                char viaje_id[50];
                sscanf(response, "%d,%s", &status, viaje_id);
                if (status == 1) {
                    printf("\tViaje en progreso . . .\n\n");
                    pause_sleep((rand() % 6) + 3);
                    char terminar_msg[1024];
                    sprintf(terminar_msg, "terminar,%s", viaje_id);
                    send(socket_client, terminar_msg, strlen(terminar_msg), 0);
                    printf("\tViaje terminado\n\n");
                } else if (status == -1) {
                    printf("\tNo hay autos disponibles\n\n");
                }
            }
            close(socket_client);
            break;
        } else if (strcmp(option, "3") == 0) {
            printf("Saliendo\n");
            close(socket_client);
            break;
        } else {
            printf("Opción inválida\n");
            pause_sleep(1.5);
            system("clear");
            continue;
        }
    }

    return 0;
}