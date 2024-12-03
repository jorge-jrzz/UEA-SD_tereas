import 'package:flutter/material.dart';
import 'dart:async';
import 'package:grpc/grpc.dart';
import '../protos/ride_service.pbgrpc.dart';

class RideInfoScreen extends StatefulWidget {
  final String userId;
  final String rideType;
  final String pickupLocation;
  final String dropoffLocation;

  RideInfoScreen({
    this.userId = 'Unknown User',
    this.rideType = 'Standard',
    this.pickupLocation = 'Unknown Pickup',
    this.dropoffLocation = 'Unknown Dropoff',
  });

  @override
  _RideInfoScreenState createState() => _RideInfoScreenState();
}

class _RideInfoScreenState extends State<RideInfoScreen> {
  late RideServiceClient _client;
  String _rideMessage = "Buscando conductor...";
  String _ridePlate = "Cargando...";
  String _pickupLocation = "Cargando...";
  String _dropoffLocation = "Cargando...";
  int _rideTime = 0; // Tiempo restante en segundos
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _initializeClient();
    _requestRide();
  }

  void _initializeClient() {
    final channel = ClientChannel(
      'localhost',
      port: 50051,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        idleTimeout: Duration(minutes: 1),
      ),
    );
    _client = RideServiceClient(channel);
  }

  Future<void> _requestRide() async {
    try {
      RideRequest rideRequest = RideRequest(
        userId: widget.userId,
        rideType: widget.rideType,
        pickupLocation: widget.pickupLocation,
        dropoffLocation: widget.dropoffLocation,
      );
      final response = await _client.requestRide(rideRequest);
      setState(() {
        _rideMessage = response.message;
        _ridePlate =
            response.plate.isNotEmpty ? response.plate : "No disponible";
        _rideTime = int.parse(response.estimatedTime); // Convertir a segundos
        _pickupLocation = widget.pickupLocation;
        _dropoffLocation = widget.dropoffLocation;
      });
      _startTimer();
    } catch (e) {
      setState(() {
        _rideMessage = "Error en la solicitud";
        _ridePlate = "N/A";
        _rideTime = 0;
      });
      print("Error al solicitar el viaje: $e");
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_rideTime > 0) {
        setState(() {
          _rideTime--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  Future<void> _endRide() async {
    try {
      EndRideRequest endRideRequest = EndRideRequest(plate: _ridePlate);
      final response = await _client.endRide(endRideRequest);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.message),
      ));
      Navigator.pop(context);
    } catch (e) {
      print("Error al finalizar el viaje: $e");
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo oscuro que simula un mapa
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/map_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Tarjeta flotante con la información del viaje
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _rideMessage,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Desde: $_pickupLocation',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Hacia: $_dropoffLocation',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Placa: $_ridePlate',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Tiempo estimado: ${_rideTime > 0 ? "${(_rideTime ~/ 60).toString().padLeft(2, '0')}:${(_rideTime % 60).toString().padLeft(2, '0')}" : "Finalizado"}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_rideTime == 0)
                            ElevatedButton(
                              onPressed: _endRide,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 24),
                              ),
                              child: const Text(
                                'Finalizar Viaje',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            )
                          else
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 24),
                              ),
                              child: const Text(
                                'Esperando...',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
