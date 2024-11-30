import 'package:flutter/material.dart';
import '../widgets/button.dart';

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
}
