import 'package:flutter/material.dart';
import '../widgets/button.dart';
import 'package:grpc/grpc.dart';
//import 'package:grpc/grpc_web.dart';
import '../protos/ride_service.pbgrpc.dart';

//import 'package:ride_service/src/generated/ride_service.pbgrpc.dart'; // Asegúrate de que este sea el path correcto
/*
class AdministratorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información del Servicio'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Número de viajes realizados:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'numero de viajes aqui',
              style: TextStyle(fontSize: 17, backgroundColor: Colors.grey[300]),
            ),
            const Divider(),
            const Text(
              'Número de autos libres:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'numero de autos aqui',
              style: TextStyle(fontSize: 17, backgroundColor: Colors.grey[300]),
            ),
            const Divider(),
            const Text(
              'Ganancias totales:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '\$ ganancias aqui',
              style: TextStyle(fontSize: 17, backgroundColor: Colors.grey[300]),
            ),
            const Divider(),
            const Spacer(),
            ButtonFuntion(
                text: 'Volver',
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}*/
class AdministratorScreen extends StatefulWidget {
  @override
  _AdministratorScreenState createState() => _AdministratorScreenState();
}

class _AdministratorScreenState extends State<AdministratorScreen> {
  late RideServiceClient _client;
  String _totalTrips = "Cargando...";
  String _availableCars = "Cargando...";
  String _earnings = "Cargando...";

  @override
  void initState() {
    super.initState();
    _initializeClient();
    _fetchServiceInfo();
  }
  /*
  void _initializeClient() {
    final channel =
        GrpcWebClientChannel.xhr(Uri.parse('http://localhost:50051'));
    _client = RideServiceClient(channel);
  }*/

  void _initializeClient() {
    final channel = ClientChannel(
      'localhost', // Dirección del servidor
      port: 50051, // Puerto de gRPC
      options: const ChannelOptions(
        credentials:
            ChannelCredentials.insecure(), // Si no tienes SSL, usa esto
        idleTimeout: Duration(minutes: 1),
      ),
    );
    _client = RideServiceClient(channel);
  }

  /*
  Future<void> _fetchServiceInfo() async {
    try {
      final response = await _client.getServiceInfo(EmptyRequest());
      setState(() {
        _totalTrips = response.totalTrips.toString();
        _availableCars = response.availableCars.toString();
        _earnings = "\$${response.earnings.toStringAsFixed(2)}";
      });
    } catch (e) {
      setState(() {
        _totalTrips = "Error";
        _availableCars = "Error";
        _earnings = "Error";
      });
      print("Error fetching service info: $e");
    }
  }*/

  Future<void> _fetchServiceInfo() async {
    try {
      final response = await _client.getServiceInfo(EmptyRequest());
      setState(() {
        _totalTrips = response.totalTrips.toString();
        _availableCars = response.availableCars.toString();
        _earnings = "\$${response.earnings.toStringAsFixed(2)}";
      });
    } catch (e) {
      setState(() {
        _totalTrips = "Error";
        _availableCars = "Error";
        _earnings = "Error";
      });
      print("Error fetching service info: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información del Servicio'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Número de viajes realizados:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _totalTrips,
              style: TextStyle(fontSize: 17, backgroundColor: Colors.grey[300]),
            ),
            const Divider(),
            const Text(
              'Número de autos libres:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _availableCars,
              style: TextStyle(fontSize: 17, backgroundColor: Colors.grey[300]),
            ),
            const Divider(),
            const Text(
              'Ganancias totales:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _earnings,
              style: TextStyle(fontSize: 17, backgroundColor: Colors.grey[300]),
            ),
            const Divider(),
            const Spacer(),
            ButtonFuntion(
                text: 'Volver',
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
