#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>

#define SERVER_IP "xxx.xxx.xxx.xxx"  // Dirección IP del servidor
#define SERVER_PORT 2020

int main() {
    int socket_client;
    struct sockaddr_in server_address;
    char message[1024];
    char buffer[1024];
    
    // Crear el socket
    socket_client = socket(AF_INET, SOCK_STREAM, 0);
    if (socket_client < 0) {
        perror("Error al crear el socket");
        exit(EXIT_FAILURE);
    }

    // Configuración de la dirección del servidor
    server_address.sin_family = AF_INET;
    server_address.sin_port = htons(SERVER_PORT);  // Puerto SERVER_PORT
    if (inet_pton(AF_INET, SERVER_IP, &server_address.sin_addr) <= 0) {
        perror("Dirección inválida o no soportada");
        close(socket_client);
        exit(EXIT_FAILURE);
    }

    printf("Conectando a %s puerto %d...\n", SERVER_IP, SERVER_PORT);
    if (connect(socket_client, (struct sockaddr *)&server_address, sizeof(server_address)) < 0) {
        perror("Error al conectar con el servidor");
        close(socket_client);
        exit(EXIT_FAILURE);
    }

    // Bucle principal
    while (1) {
        // Leer mensaje del usuario
        printf("Introduzca el mensaje para el servidor: ");
        fgets(message, 1024, stdin);

        message[strcspn(message, "\n")] = 0;
        
        // Si el mensaje está vacío, enviar "estado"
        if (strlen(message) == 0) {
            strcpy(message, "estado");
        }

        // Enviar mensaje al servidor
        if (send(socket_client, message, strlen(message), 0) < 0) {
            perror("Error al enviar el mensaje");
            break;
        }

        // Recibir respuesta del servidor
        int bytes_received = recv(socket_client, buffer, 1024, 0);
        if (bytes_received < 0) {
            perror("Error al recibir la respuesta");
            break;
        }
        buffer[bytes_received] = '\0';  // Añadir terminador nulo para imprimir
        printf("Respuesta del servidor: %s\n", buffer);

        // Pausa de 1 segundo
        sleep(1);
    }

    close(socket_client);
    return 0;
}
