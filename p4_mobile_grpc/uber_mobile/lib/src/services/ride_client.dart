/*import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_web.dart';
import '../protos/ride_service.pbgrpc.dart'; // Ajusta la ruta según donde tengas los archivos generados.


2
class RideClient {
  late RideServiceClient stub;
  late ClientChannel channel;

  Future<void> initialize() async {
    channel = ClientChannel(
      'localhost', // Cambia a la IP de tu servidor si no es local.
      port: 50051, // Puerto del servidor gRPC.
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    stub = RideServiceClient(channel);
  }

  Future<ServiceInfo> getServiceInfo() async {
    final emptyRequest = EmptyRequest();
    try {
      final response = await stub.getServiceInfo(emptyRequest);
      return response;
    } catch (e) {
      throw Exception('Error al obtener la información del servicio: $e');
    }
  }

  void close() async {
    await channel.shutdown();
  }
}*/

import 'package:flutter/material.dart';
import 'package:grpc/grpc_web.dart';
import '../protos/ride_service.pbgrpc.dart'; // Ajusta la ruta según donde tengas los archivos generados.

class RideClient {
  late RideServiceClient stub;

  late GrpcWebClientChannel channel;
  Future<void> initialize() async {
    // Utiliza GrpcWebClientChannel para conexiones compatibles con navegadores
    final channel = GrpcWebClientChannel.xhr(
      Uri.parse(
          'http://192.168.100.174:8080'), // Cambia a la URL de tu servidor gRPC-Web
    );
    stub = RideServiceClient(channel);
  }

  Future<ServiceInfo> getServiceInfo() async {
    final emptyRequest = EmptyRequest();
    try {
      final response = await stub.getServiceInfo(emptyRequest);
      return response;
    } catch (e) {
      throw Exception('Error al obtener la información del servicio: $e');
    }
  }

  // Método para "cerrar" o limpiar el cliente
  void close() {
    // Aunque GrpcWebClientChannel no necesita shutdown, lo dejamos para consistencia
    // En caso de futuras extensiones o cambios, puedes usar esto como punto de limpieza.
    stub = null as RideServiceClient;
    channel = null as GrpcWebClientChannel;
  }
}
