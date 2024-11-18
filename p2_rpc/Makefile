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

# Regla para crear archivos con rpcgen
rpcgen:
	rpcgen -C $(IDL_FILE)

# Regla para compilar el servidor
gcc_server:
	@echo "compilando el servidor..."
	gcc uber_svc.c uber_xdr.c $(SERVER_IMPL) $(CFLAGS) -o $(SERVER_EXEC)

# Regla para compilar el cliente
gcc_client:
	@echo "compilando el cliente..."
	gcc uber_clnt.c uber_xdr.c $(CLIENT_IMPL) $(CFLAGS) -o $(CLIENT_EXEC)

# Regla para iniciar el servicio RPC y ejecutar el servidor
start_service:
	@echo "Iniciando rpcbind (si no está corriendo)..."
	sudo systemctl start rpcbind

# Limpieza de archivos generados y binarios
clean:
	rm -f $(CLIENT_EXEC) $(SERVER_EXEC) $(GEN_FILES)
