import 'package:flutter/material.dart';
import 'package:wdevproject/Themes/MyTheme.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String text;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed, // Disable button if loading
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 55), // Botón full width
        backgroundColor: MyTheme.buttonColor,
        foregroundColor: MyTheme.buttonTextColor, // Set text color here
      ),
      child: isLoading
          ? const CircularProgressIndicator(color: MyTheme.buttonTextColor)
          : Text(
              text, // This can be a variable
              style: const TextStyle(fontSize: 18), // Keep this constant
            ),
    );
  }
}