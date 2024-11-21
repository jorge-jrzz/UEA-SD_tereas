import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:client/src/generated/shooting.pbgrpc.dart';
import 'package:client/src/generated/google/protobuf/empty.pb.dart';

Future<void> main(List<String> args) async {
  print("Hello Human 🗿");

  final channel = ClientChannel(
    'localhost',
    port: 50051,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
    ),
  );

  final stub = ShootingClient(channel);

  try {
    // DimeCentroDiana
    final distanceResponse = await stub.dimeCentroDiana(Empty());
    print("Distancia random ${distanceResponse.distance}");

    // DisparaCannon - juanito
    var response = await stub.disparaCannon(DisparaRequest()
      ..username = 'juanito'
      ..angle = 45
      ..speed = 100);
    print("Respuesta: ${response.shootDistance.toStringAsFixed(2)}");

    // DisparaCannon - jorge
    response = await stub.disparaCannon(DisparaRequest()
      ..username = 'jorge'
      ..angle = 5
      ..speed = 12);
    print("Respuesta: ${response.shootDistance.toStringAsFixed(2)}");

    // DisparaCannon - octavio
    response = await stub.disparaCannon(DisparaRequest()
      ..username = 'octavio'
      ..angle = 19
      ..speed = 20);
    print("Respuesta: ${response.shootDistance.toStringAsFixed(2)}");

    // MejorDisparo
    final bestShotResponse = await stub.mejorDisparo(Empty());
    print("Mejor disparo realizado por: ${bestShotResponse.username}");
  } catch (e) {
    print('Caught error: $e');
  } finally {
    await channel.shutdown();
  }
}