import 'package:flutter/material.dart';
import 'package:wdevproject/Themes/MyTheme.dart';

class LinkText extends StatelessWidget {
  final VoidCallback onPressed; // Función que se ejecuta al presionar el enlace
  final String text; // Texto que se muestra en el enlace

  const LinkText({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // Llama a la función cuando se toca
      child: Container(
        margin: const EdgeInsets.only(top: 10), // Margen superior
        child: Text(
          text,
          style: const TextStyle(
            color: MyTheme.primaryColor, // Color del texto
            fontSize: 15, // Tamaño del texto
            fontWeight: FontWeight.normal, // Peso de la fuente
          ),
        ),
      ),
    );
  }
}
