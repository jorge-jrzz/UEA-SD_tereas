#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <math.h>
#include "uber.h" // Archivo generado por rpcgen

// Definiciones globales
#define NUM_AUTOS 8

typedef struct {
    int disponible;      // 1: Disponible, 0: Ocupado
    struct Posicion pos; // Posición del auto
    char tipoUber[15];   // Tipo de Uber (UberPlanet, UberXL, UberBlack)
    float tarifa;        // Tarifa por kilómetro
    char placa[10];      // Placa del auto
    float ganancias;     // Ganancias acumuladas
} UberAuto;

// Lista de autos
UberAuto autos[NUM_AUTOS];
int viajes_realizados = 0;
float ganancia_total = 0.0;
static bool cars_inicializados = false;

// Inicializar autos en el servidor
void inicializar_autos() {
    for (int i = 0; i < NUM_AUTOS; i++) {
        autos[i].disponible = 1;
        autos[i].pos.x = rand() % 51; // Coordenadas aleatorias [0, 50]
        autos[i].pos.y = rand() % 51;

        // Asignar tipo de Uber
        if (i % 3 == 0) {
            strncpy(autos[i].tipoUber, "UberBlack", sizeof(autos[i].tipoUber));
        } else if (i % 2 == 0) {
            strncpy(autos[i].tipoUber, "UberXL", sizeof(autos[i].tipoUber));
        } else {
            strncpy(autos[i].tipoUber, "UberPlanet", sizeof(autos[i].tipoUber));
        }
        autos[i].tipoUber[sizeof(autos[i].tipoUber) - 1] = '\0'; // Asegurar terminación

        // Asignar tarifa según tipo de Uber
        if (strcmp(autos[i].tipoUber, "UberBlack") == 0) {
            autos[i].tarifa = 25.0;
        } else if (strcmp(autos[i].tipoUber, "UberXL") == 0) {
            autos[i].tarifa = 15.0;
        } else {
            autos[i].tarifa = 10.0;
        }

        snprintf(autos[i].placa, sizeof(autos[i].placa), "%03dABC", i);
        autos[i].placa[sizeof(autos[i].placa) - 1] = '\0'; // Asegurar terminación
        autos[i].ganancias = 0.0;

        printf("%s %s (%d, %d) %.2f\n", autos[i].tipoUber, autos[i].placa,
               autos[i].pos.x, autos[i].pos.y, autos[i].tarifa);
    }
}

// Función auxiliar para calcular la distancia entre dos posiciones
float calcular_distancia(struct Posicion a, struct Posicion b) {
    return sqrtf(powf(b.x - a.x, 2) + powf(b.y - a.y, 2));
}

// Implementación de SolicitarViaje
InfoAuto *solicitarviaje_1_svc(Posicion *pos, struct svc_req *req) {
    static InfoAuto respuesta;
    static char tipoUber[15];
    static char placa[10];

    if (!cars_inicializados) {
        inicializar_autos();
        cars_inicializados = true;
    }

    printf("Solicitud de viaje desde posición: (%d, %d)\n", pos->x, pos->y);

    int encontrado = 0;
    float distancia_min = INFINITY;
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
        autos[auto_seleccionado].disponible = 0; // Marcar como ocupado

        // Copiar información al struct de respuesta
        respuesta.pos = autos[auto_seleccionado].pos;
        respuesta.tarifa = autos[auto_seleccionado].tarifa;

        // Usar variables estáticas para evitar fugas de memoria
        strncpy(tipoUber, autos[auto_seleccionado].tipoUber, sizeof(tipoUber));
        tipoUber[sizeof(tipoUber) - 1] = '\0';
        respuesta.tipoUber = tipoUber;

        strncpy(placa, autos[auto_seleccionado].placa, sizeof(placa));
        placa[sizeof(placa) - 1] = '\0';
        respuesta.placa = placa;

        return &respuesta;
    } else {
        return NULL; // No hay autos disponibles
    }
}

// Implementación de TerminarViaje
void *terminarviaje_1_svc(TerminarViajeArgs *args, struct svc_req *req) {
    static int resultado = 1;
    if (!cars_inicializados) {
        inicializar_autos();
        cars_inicializados = true;
    }

    for (int i = 0; i < NUM_AUTOS; i++) {
        if (strcmp(autos[i].placa, args->placas) == 0) {
            autos[i].disponible = 1;            // Marcar como disponible
            autos[i].pos = args->posicionFinal; // Actualizar posición
            autos[i].ganancias += args->costoViaje;
            ganancia_total += args->costoViaje;
            viajes_realizados++;
            break;
        }
    }

    return &resultado;
}

// Implementación de EstadoServicio
EstadoServicio *estadoservicio_1_svc(void *argp, struct svc_req *req) {
    static EstadoServicio estado;

    if (!cars_inicializados) {
        inicializar_autos();
        cars_inicializados = true;
    }

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
