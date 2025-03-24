import 'package:flutter/material.dart';
import 'colors.dart'; // Asegúrate de importar tu archivo de colores

class MyTheme {
  // Define colors for the theme
  static const Color primaryColor = AppColors.primaryColor; // Ahora se usa AppColors
  static const Color secondaryColor = AppColors.secondaryColor;
  static const Color buttonColor = AppColors.buttonColor; // Button background color
  static const Color buttonTextColor = AppColors.buttonTextColor; // Button text color
  static const Color textColor = AppColors.textColor; // Regular text color
  static const Color lightGray = AppColors.lightGray; // Regular text color
  static const Color hintTextColor = AppColors.hintTextColor;
  static const Color linkColor = AppColors.linkColor;
  static const Color borderColor = AppColors.borderColor;
  static const Color unselectedBoderColor = AppColors.unselectedBorderColor;
  static const Color white = Colors.white;

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: secondaryColor,
      background: const Color(0xFFFFFFFF), // Background color for the app
    ),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF), // Background color for the entire app

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white ,
      foregroundColor: Colors.black, // AppBar text and icon color
    ),

    // Text Theme
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: textColor), // Regular text color
      bodyLarge: TextStyle(color: Color(0xFF333333)), // Secondary text color
      titleLarge: TextStyle(color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold), // Headline style
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor, // Button background color
        foregroundColor: buttonTextColor, // Button text color
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: secondaryColor, // Text button text color
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: secondaryColor, // Outlined button text color
        side: const BorderSide(color: secondaryColor), // Outline color
      ),
    ),
  );
}
