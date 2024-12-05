import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:grpc/grpc.dart';
import '../protos/ride_service.pbgrpc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RideInfoScreen extends StatefulWidget {
  final String userId;
  final String rideType;
  //final String pickupLocation;
  //final String dropoffLocation;

  RideInfoScreen({
    this.userId = 'Unknown User',
    this.rideType = 'Standard',
    //this.pickupLocation = 'Unknown Pickup',
    //this.dropoffLocation = 'Unknown Dropoff',
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

  final Map<String, String> locationLabels = {
    "UAM Cuajimalpa": "19.352914157905914, -99.28245393774077",
    "KidZania Santa Fe": "19.360598566916305, -99.27469939680084",
    "Sams Club Santa Fe": "19.354582788310037, -99.27779629642161",
    "Hyatt House Mexico City/Santa Fe": "19.35739850095666, -99.28375422038327",
  };

  List<LatLng> _route = [];
  LatLng _currentPosition =
      LatLng(19.352914157905914, -99.28245393774077); // UAM Cuajimalpa

  final List<Map<String, dynamic>> _routes = [
    {
      "pickup": "UAM Cuajimalpa",
      "dropoff": "KidZania Santa Fe",
      "points": [
        LatLng(19.352914157905914, -99.28245393774077),
        LatLng(19.355, -99.28),
        LatLng(19.360598566916305, -99.27469939680084),
      ],
    },
    {
      "pickup": "UAM Cuajimalpa",
      "dropoff": "Hyatt House Mexico City/Santa Fe",
      "points": [
        LatLng(19.352914157905914, -99.28245393774077),
        LatLng(19.354, -99.285),
        LatLng(19.357618190837886, -99.2778010149107),
      ],
    },
    {
      "pickup": "UAM Cuajimalpa",
      "dropoff": "Sams Club Santa Fe",
      "points": [
        LatLng(19.352914157905914, -99.28245393774077),
        LatLng(19.355, -99.28),
        LatLng(19.360598566916305, -99.27469939680084),
      ],
    },
  ];

  int _currentRouteIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeClient();
    _setRouteInfo();
    _requestRide();
  }

  final String host = dotenv.env['SERVER_HOST'] ?? 'localhost';

  void _initializeClient() {
    final channel = ClientChannel(
      host,
      port: 50051,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        idleTimeout: Duration(minutes: 1),
      ),
    );
    _client = RideServiceClient(channel);
  }

  void _setRouteInfo() {
    setState(() {
      _pickupLocation = "${_routes[_currentRouteIndex]['pickup']}";
      _dropoffLocation = "${_routes[_currentRouteIndex]['dropoff']}";
      //_route = _routes[_currentRouteIndex]['points'];
    });
  }

  Future<void> _requestRide() async {
    try {
      RideRequest rideRequest = RideRequest(
        userId: widget.userId,
        rideType: widget.rideType,
        //pickupLocation: widget.pickupLocation,
        //dropoffLocation: widget.dropoffLocation,
      );
      final response = await _client.requestRide(rideRequest);
      setState(() {
        _rideMessage = response.message;
        _ridePlate =
            response.plate.isNotEmpty ? response.plate : "No disponible";
        _rideTime = int.parse(response.estimatedTime); // Convertir a segundos
        //_pickupLocation = widget.pickupLocation;
        //_dropoffLocation = widget.dropoffLocation;
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
    _simulateVehicleMovement();
  }

  void _simulateVehicleMovement() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      if (_rideTime <= 0) {
        timer.cancel();
        return;
      }

      setState(() {
        // Simula un desplazamiento a coordenadas cercanas
        _currentPosition = LatLng(
          _currentPosition.latitude + 0.0001,
          _currentPosition.longitude + 0.0001,
        );
        _route.add(_currentPosition);
      });
    });
  }

  Future<void> _endRide() async {
    try {
      EndRideRequest endRideRequest = EndRideRequest(plate: _ridePlate);
      final response = await _client.endRide(endRideRequest);
      print(response.message);
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
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(
                  19.352914157905914, -99.28245393774077), // UAM Cuajimalpa
              initialZoom: 16.7,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _route,
                    strokeWidth: 4.0,
                    color: Colors.blue,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  /*Marker(
                    point: _currentPosition,
                    builder: (context) => Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),*/

                  Marker(
                    point: _currentPosition,
                    child: const Icon(
                      Icons.directions_car,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Tarjeta flotante con la INFORMACION del viaje
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
                        'From: $_pickupLocation',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'To: $_dropoffLocation',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Plate: $_ridePlate',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Estimated Time: ${_rideTime > 0 ? "${(_rideTime ~/ 60).toString().padLeft(2, '0')}:${(_rideTime % 60).toString().padLeft(2, '0')}" : "Finalizado"}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(
                          width: 16), // Espacio entre contenido y la foto
                      // Apartado para la foto del conductor
                      CircleAvatar(
                        radius: 30, // Ajusta el tamaño del círculo
                        backgroundImage: AssetImage(
                            'assets/images/car1.jpg'), // Ruta de la foto
                        backgroundColor:
                            Colors.grey[800], // Color de fondo si no hay imagen
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Dodge Attitude',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_rideTime == 0)
                            ElevatedButton(
                              onPressed: _endRide,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 45, 224, 36),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 24),
                              ),
                              child: const Text(
                                'End Ride',
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
                                'Ride in Progress...',
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
