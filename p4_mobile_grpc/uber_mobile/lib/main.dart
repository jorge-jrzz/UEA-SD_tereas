import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uber Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedOption; // Para rastrear la opción seleccionada

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uber Clone'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Mapa en la mitad superior
          Expanded(
            flex: 1,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(19.432608, -99.133209), // Ciudad de México
                initialZoom: 12.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
              ],
            ),
          ),
          // Opciones de viaje en la mitad inferior
          Expanded(
            flex: 1,
            child: Column(
              children: [
                const SizedBox(height: 10),
                _buildOptionButton('UberPlanet'),
                _buildOptionButton('UberXL'),
                _buildOptionButton('UberBlack'),
                const Spacer(),
                if (selectedOption != null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Aquí manejas la confirmación del viaje
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Has seleccionado $selectedOption'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        'Confirmar viaje',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget para un botón de opción
  Widget _buildOptionButton(String option) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedOption = option;
          });
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          backgroundColor: selectedOption == option ? Colors.blue : Colors.grey,
        ),
        child: Text(
          option,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}