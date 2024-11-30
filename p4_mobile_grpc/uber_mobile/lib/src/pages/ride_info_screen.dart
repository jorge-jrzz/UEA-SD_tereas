import 'package:flutter/material.dart';
import '../widgets/button.dart';

class RideInfoScreen extends StatelessWidget {
  final String rideOption; // Recibe la opción del viaje seleccionado

  const RideInfoScreen({Key? key, required this.rideOption}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información del Viaje'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Tu viaje en $rideOption está en camino!',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Gracias por usar nuestro servicio. Puedes esperar la llegada del conductor o solicitar otro viaje. [Aqui va la informacion del viaje y de cuando acabe xd]',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ButtonFuntion(
                text: 'Solicitar otro viaje',
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