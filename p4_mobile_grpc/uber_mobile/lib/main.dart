import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'src/pages/ride_info_screen.dart';
import 'src/pages/administrator_screen.dart';
import 'src/widgets/button.dart';
import 'src/widgets/option_button.dart';

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
          // Opciones de viaje con scroll
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OptionButton(
                    imagePath: 'assets/images/uber_planet.png',
                    option: 'UberPlanet',
                    details: '\$9.99',
                    isSelected: selectedOption == 'UberPlanet',
                    onTap: () {
                      setState(() {
                        selectedOption = 'UberPlanet';
                      });
                    },
                  ),
                  OptionButton(
                    imagePath: 'assets/images/uber_xl.png',
                    option: 'UberXL',
                    details: '\$14.99',
                    isSelected: selectedOption == 'UberXL',
                    onTap: () {
                      setState(() {
                        selectedOption = 'UberXL';
                      });
                    },
                  ),
                  OptionButton(
                    imagePath: 'assets/images/uber_black.png',
                    option: 'UberBlack',
                    details: '\$14.99',
                    isSelected: selectedOption == 'UberBlack',
                    onTap: () {
                      setState(() {
                        selectedOption = 'UberBlack';
                      });
                    },
                  ),
                  const SizedBox(height: 10),
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
                                    Navigator.of(context).pop(); // Cerrar el diálogo
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RideInfoScreen(),
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
                  // Botón de información del servicio (siempre aparece)
                  ButtonFuntion(
                    text: 'Información del servicio',
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdministratorScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}