#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>
#include <time.h>
#include <string.h> // Añadido para usar strdup
#include "uber.h"

float calcularDistancia(Posicion origen, Posicion destino) {
    float deltaX = destino.x - origen.x;
    float deltaY = destino.y - origen.y;
    return sqrtf(deltaX * deltaX + deltaY * deltaY);
}

void pasajero(CLIENT *clnt) {
    srand(time(NULL) ^ getpid()); // Mejor semilla para múltiples clientes
    Posicion origen = {rand() % 51, rand() % 51};
    Posicion destino = {rand() % 51, rand() % 51};

    InfoAuto *info = solicitarviaje_1(&origen, clnt);
    if (info == NULL) {
        printf("No hay autos disponibles.\n");
        return;
    }

    float distancia = calcularDistancia(origen, destino);
    float costo = distancia * info->tarifa;
    printf("Auto asignado: Placa=%s, Tipo=%s, Costo estimado=%.2f\n",
           info->placa, info->tipoUber, costo);

    // Usar usleep para manejar fracciones de segundo
    usleep((useconds_t)(distancia * 1000000)); // Convertir a microsegundos

    TerminarViajeArgs args;
    args.posicionFinal = destino;
    args.costoViaje = costo;
    args.placas = strdup(info->placa);

    int *result = terminarviaje_1(&args, clnt);
    if (result == NULL || *result == 0) {
        printf("Error al terminar el viaje.\n");
    } else {
        printf("Viaje terminado exitosamente.\n");
    }

    // Liberar memoria asignada
    free(args.placas);
    xdr_free((xdrproc_t)xdr_InfoAuto, (char *)info);
}

void administrador(CLIENT *clnt) {
    while (1) {
        EstadoServicio *estado = estadoservicio_1(NULL, clnt);
        if (estado != NULL) {
            printf("Viajes Realizados: %d, Autos Libres: %d, Ganancia Total: %.2f\n",
                   estado->viajesRealizados, estado->autosLibres, estado->gananciaTotal);
            xdr_free((xdrproc_t)xdr_EstadoServicio, (char *)estado);
        } else {
            printf("Error al obtener el estado del servicio.\n");
        }
        sleep(2);
    }
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Uso: %s <host> <rol>\n", argv[0]);
        exit(1);
    }

    CLIENT *clnt = clnt_create(argv[1], UBER_PROG, UBER_VERS, "udp");
    if (clnt == NULL) {
        clnt_pcreateerror(argv[1]);
        exit(1);
    }

    if (strcmp(argv[2], "passenger") == 0) {
        pasajero(clnt);
    } else if (strcmp(argv[2], "admin") == 0) {
        administrador(clnt);
    } else {
        printf("Rol desconocido. Use 'passenger' o 'admin'.\n");
    }

    clnt_destroy(clnt);
    return 0;
}
