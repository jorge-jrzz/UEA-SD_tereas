#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "uber.h" // Archivo generado por rpcgen

// Definiciones globales
#define NUM_AUTOS 8

typedef struct {
    int disponible;       // 1: Disponible, 0: Ocupado
    struct Posicion pos;  // Posición del auto
    char tipoUber[10];    // Tipo de Uber (UberPlanet, UberXL, UberBlack)
    float tarifa;         // Tarifa por kilómetro
    char placa[10];       // Placa del auto
    float ganancias;      // Ganancias acumuladas
} UberAuto;

// Lista de autos
UberAuto autos[NUM_AUTOS];
int viajes_realizados = 0;
float ganancia_total = 0.0;

// Inicializar autos en el servidor
void inicializar_autos() {
    for (int i = 0; i < NUM_AUTOS; i++) {
        autos[i].disponible = 1;
        autos[i].pos.x = rand() % 51;  // Coordenadas aleatorias [0, 50]
        autos[i].pos.y = rand() % 51;
        snprintf(autos[i].tipoUber, sizeof(autos[i].tipoUber), (i % 3 == 0) ? "UberBlack" : (i % 2 == 0) ? "UberXL" : "UberPlanet");
        autos[i].tarifa = (strcmp(autos[i].tipoUber, "UberBlack") == 0) ? 25.0 : (strcmp(autos[i].tipoUber, "UberXL") == 0) ? 15.0 : 10.0;
        snprintf(autos[i].placa, sizeof(autos[i].placa), "%03dABC", i);
        autos[i].ganancias = 0.0;
    }
}

// Función auxiliar para calcular la distancia entre dos posiciones
float calcular_distancia(struct Posicion a, struct Posicion b) {
    return sqrt(pow(b.x - a.x, 2) + pow(b.y - a.y, 2));
}

// Implementación de SolicitarViaje
InfoAuto *solicitarviaje_1_svc(Posicion *pos, struct svc_req *req) {
    static InfoAuto respuesta;
    int encontrado = 0;
    float distancia_min = 1e9;
    int auto_seleccionado = -1;

    // Buscar el auto más cercano disponible
    for (int i = 0; i < NUM_AUTOS; i++) {
        if (autos[i].disponible) {
            float distancia = calcular_distancia(autos[i].pos, *pos);
            if (distancia < distancia_min) {
                distancia_min = distancia;
                auto_seleccionado = i;
                encontrado = 1;
            }
        }
    }

    if (encontrado) {
        autos[auto_seleccionado].disponible = 0;  // Marcar como ocupado
        respuesta.pos = autos[auto_seleccionado].pos;
        respuesta.tarifa = autos[auto_seleccionado].tarifa;
        strcpy(respuesta.tipoUber, autos[auto_seleccionado].tipoUber);
        strcpy(respuesta.placa, autos[auto_seleccionado].placa);
        return &respuesta;
    } else {
        return NULL;  // No hay autos disponibles
    }
}

// Implementación de TerminarViaje
void *terminarviaje_1_svc(TerminarViajeArgs *args, struct svc_req *req) {
    for (int i = 0; i < NUM_AUTOS; i++) {
        if (strcmp(autos[i].placa, args->placas) == 0) {
            autos[i].disponible = 1;  // Marcar como disponible
            autos[i].pos = args->posicionFinal;  // Actualizar posición
            autos[i].ganancias += args->costoViaje;
            ganancia_total += args->costoViaje;
            viajes_realizados++;
            break;
        }
    }
    return NULL;
}

// Implementación de EstadoServicio
EstadoServicio *estadoservicio_1_svc(void *argp, struct svc_req *req) {
    static EstadoServicio estado;
    int autos_libres = 0;

    for (int i = 0; i < NUM_AUTOS; i++) {
        if (autos[i].disponible) {
            autos_libres++;
        }
    }

    estado.viajesRealizados = viajes_realizados;
    estado.autosLibres = autos_libres;
    estado.gananciaTotal = ganancia_total;
    return &estado;
}
