# Compilacion

Para compilar el proyecto se usan los siguientes comandos:

### 1. Compilacion con rpcgen
rpcgen es una herramienta utilizada para generar código fuente en programas que implementan Remote Procedure Call (RPC). RPC permite que un programa ejecute procedimientos en otro sistema de forma remota, como si fueran llamadas locales.
```sh
rpcgen -C uber.x
```
Esto hace que rpcgen procese el archivo de interfaz RPC (uber.x) y genere varios archivos automáticamente. Estos archivos contienen el código necesario para manejar las llamadas RPC.

Archivos generados por rpcgen:
uber.h
Este archivo contiene las definiciones de estructuras y constantes derivadas de la especificación en uber.x.
Propósito: Es el punto de referencia para los programas cliente y servidor para usar los datos y funciones definidos en la interfaz RPC.

uber_clnt.c
Contiene las implementaciones de las funciones que el cliente utilizará para llamar a los procedimientos remotos.
Propósito: El cliente usa este archivo para comunicarse con el servidor.

uber_svc.c
Contiene el código del lado del servidor, que incluye la lógica para recibir y procesar las solicitudes RPC.
Propósito: El servidor usa este archivo para manejar las llamadas RPC.

uber_xdr.c
Contiene las funciones para serializar y deserializar los datos enviados entre el cliente y el servidor (codificación XDR - eXternal Data Representation).
Propósito: Permite enviar datos en un formato independiente de la arquitectura de las máquinas cliente y servidor.
