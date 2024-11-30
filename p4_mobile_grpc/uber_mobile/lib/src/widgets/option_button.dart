import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final String imagePath;
  final String option;
  final String details;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionButton({
    Key? key,
    required this.imagePath,
    required this.option,
    required this.details,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Fondo blanco
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.black, // Borde dinámico
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
              // Texto del nombre del Uber
              Text(
                option,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Texto en negro
                ),
              ),
              const Spacer(), // Empuja el texto de detalles al final
              // Texto de los detalles (e.g., precio)
              Text(
                details,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey, // Texto gris
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}