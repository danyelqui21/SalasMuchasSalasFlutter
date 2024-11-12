import 'package:flutter/material.dart';
import 'package:wdevproject/Themes/MyTheme.dart';

class FirstText extends StatelessWidget {
  final String text; // Texto que se muestra en el componente

  const FirstText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: MyTheme.textColor,
        fontWeight: FontWeight.bold,
        fontSize: 20
      ),
    );
  }
}
