struct Posicion {
    int x;
    int y;
};

struct InfoAuto {
    Posicion pos;
    string tipoUber<15>;
    float tarifa;
    string placa<10>;
};

struct EstadoServicio {
    int viajesRealizados;
    int autosLibres;
    float gananciaTotal;
};

struct TerminarViajeArgs {
    Posicion posicionFinal;
    float costoViaje;
    string placas<10>;
};

program UBER_PROG {
    version UBER_VERS {
        InfoAuto SolicitarViaje(Posicion) = 1;
        int TerminarViaje(TerminarViajeArgs) = 2;
        EstadoServicio EstadoServicio(void) = 3;
    } = 1;
} = 0x20000001;
