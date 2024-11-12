import 'package:flutter/material.dart';
import 'package:wdevproject/Themes/MyTheme.dart';

class SocialButton extends StatelessWidget {
  final VoidCallback onPressed; // Callback for when the button is pressed
  final AssetImage imagePath; // Path to the social media icon
  final String text; // Text to display below the icon

  // Constructor with required parameters
  const SocialButton({super.key,
    required this.onPressed,
    required this.imagePath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed, // Call the onPressed callback when tapped
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Image(image: imagePath, height: 45),
          ),
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 120), // Limita el ancho para que el texto se ajuste
          child: Text(
            text,
            style: TextStyle(
              color: MyTheme.textColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center, // Alinea el texto al centro
            maxLines: null, // Permite que el texto se ajuste a más de una línea
          ),
        ),
      ],
    );
  }
}
