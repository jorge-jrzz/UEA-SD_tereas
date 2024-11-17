# Nombre del archivo IDL
IDL_FILE = uber.x

# Archivos generados por rpcgen
GEN_FILES = uber.h uber_clnt.c uber_svc.c uber_xdr.c

# Archivos de implementación
CLIENT_IMPL = client_implements.c
SERVER_IMPL = server_implements.c

# Ejecutables
CLIENT_EXEC = client
SERVER_EXEC = server

# Bandera de compilación
CFLAGS = -I/usr/include/tirpc -ltirpc -lm

# Reglas principales
all: $(CLIENT_EXEC) $(SERVER_EXEC)

# Regla para generar los archivos con rpcgen
$(GEN_FILES): $(IDL_FILE)
	rpcgen -C $(IDL_FILE)

# Regla para compilar el cliente
$(CLIENT_EXEC): $(GEN_FILES) $(CLIENT_IMPL)
	gcc uber_clnt.c uber_xdr.c $(CLIENT_IMPL) $(CFLAGS) -o $(CLIENT_EXEC)

# Regla para compilar el servidor
$(SERVER_EXEC): $(GEN_FILES) $(SERVER_IMPL)
	gcc uber_svc.c uber_xdr.c $(SERVER_IMPL) $(CFLAGS) -o $(SERVER_EXEC)

# Limpieza de archivos generados y binarios
clean:
	rm -f $(CLIENT_EXEC) $(SERVER_EXEC) $(GEN_FILES)


# Regla por defecto
.PHONY: all clean

