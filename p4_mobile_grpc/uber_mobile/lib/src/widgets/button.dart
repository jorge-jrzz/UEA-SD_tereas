import 'package:flutter/material.dart';

class ButtonFuntion extends StatelessWidget {
  final String text; // Recibe el uso del botón
  final Color color; // Recibe el color del botón
  final Function()
      onPressed; // Recibe la función a ejecutar al presionar el botón

  const ButtonFuntion(
      {Key? key,
      required this.text,
      required this.color,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15 ,left: 20, right: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            onPressed();
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(15.0),
            backgroundColor: color,
          ),
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
