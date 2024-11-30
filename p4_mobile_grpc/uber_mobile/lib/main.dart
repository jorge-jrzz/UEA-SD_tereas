import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'src/pages/ride_info_screen.dart' show RideInfoScreen;
import 'src/pages/administrator_screen.dart' show AdministratorScreen;
import 'src/widgets/button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uber Clone',
      home: HomePage(),
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/uber_logo.png',
          height: 25.0,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Mapa en la mitad superior
          Expanded(
            flex: 1,
            child: FlutterMap(
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
              ],
            ),
          ),
          // Opciones de viaje en la mitad inferior
          Expanded(
            flex: 1,
            child: Column(
              children: [
                // const SizedBox(height: 10),
                _buildOptionButton(
                    'assets/images/uber_planet.png', 'UberPlanet', '\$10 x km'),
                _buildOptionButton(
                    'assets/images/uber_xl.png', 'Uber XL', '\$15 x km'),
                _buildOptionButton(
                    'assets/images/uber_black.png', 'Uber Black', '\$25 x km'),

                const Spacer(),

                Column(
                    // padding: const EdgeInsets.all(16.0),
                    children: [
                      if (selectedOption != null)
                        ButtonFuntion(
                          text: 'Solicitar viaje',
                          color: Colors.blue[600]!,
                          onPressed: () {
                            // Muestra el dialogo de confirmación
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirmación'),
                                  content: Text(
                                      'Has solicitado un viaje en $selectedOption'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Cerrar el diálogo
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RideInfoScreen(
                                                  rideOption:
                                                      selectedOption ?? 'N/A',
                                                ),
                                          ),
                                        );
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ButtonFuntion(
                          text: 'Información del servicio',
                          color: Colors.black,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdministratorScreen(
                                  rideOption:
                                    selectedOption ?? 'N/A',
                                  ),
                                ),
                            );
                          }),
                    ]),
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
