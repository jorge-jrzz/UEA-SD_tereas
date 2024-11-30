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
        title: Image.asset('assets/images/uber_logo.png', height: 30.0,), 
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Mapa en la mitad superior
          Expanded(
            flex: 1,
            child: FlutterMap(
              options: MapOptions(
                initialCenter:
                    LatLng(19.432608, -99.133209), // Ciudad de México
                initialZoom: 12.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
                _buildOptionButton(
                  'assets/images/uber_planet.png',
                  'UberPlanet', 
                  'Viaje compartido'),
                _buildOptionButton(
                  'assets/images/uber_xl.png', 
                  'UberXL', 
                  'Viaje compartido'),
                _buildOptionButton(
                  'assets/images/uber_black.png', 
                  'UberBlack', 
                  'Viaje compartido'),
                const Spacer(),
                if (selectedOption != null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Muestra el dialogo de confirmación
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirmación'),
                                  content: Text('Has seleccionado $selectedOption'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Cerrar el diálogo
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                            backgroundColor: Colors.blue[600],
                          ),
                          child: const Text(
                            'Solicitar viaje',
                            style: TextStyle(
                              fontSize: 16, 
                              fontWeight: FontWeight.bold, 
                              color: Colors.white),
                          ),
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
  Widget _buildOptionButton(String imagePath, String option, String details) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedOption = option;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Fondo blanco
            border: Border.all(
              color: selectedOption == option
                  ? Colors.blue
                  : Colors.black, // Borde negro (o azul si está seleccionado)
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            children: [
              // Imagen a la izquierda
              Image.asset(
                imagePath,
                width: 50.0,
              ),
              const SizedBox(width: 30), // Espacio entre imagen y texto
              // Texto a la derecha
              Text(
                option,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Texto en negro
                ),
              ),
              const Spacer(), // Espacio entre el nombre del Uber y texto de los detalles
              // Texto de los detalles del precio del servicio
              Text(
                details,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey, // Texto en negro
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
