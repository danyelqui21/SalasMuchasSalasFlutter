import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:local_auth_platform_interface/local_auth_platform_interface.dart';
import 'package:local_auth_windows/local_auth_windows.dart';

class BiometricAuthButton extends StatelessWidget {

  final VoidCallback onAuthenticated; // Función que se ejecuta al autenticar

  BiometricAuthButton({required this.onAuthenticated});

  final LocalAuthentication auth = LocalAuthentication();

  Future<void> handleBiometricAuth() async {
    try {
      final bool authenticated = await auth.authenticate(
        localizedReason: 'Usa tus biométricos para ingresar',
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Fishers',
            biometricHint: '',
            cancelButton: 'No thanks',
          ),
          IOSAuthMessages(
            cancelButton: 'No thanks',
          ),
        ],
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false, // Solo permite biometría
        ),
      );

      if (authenticated) {
        onAuthenticated(); // Llama a la función en caso de autenticación exitosa
      }
    } catch (e) {
      print('Error de autenticación: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: PlatformWidget(
        material: (_, __) => IconButton(
          icon: Icon(Icons.fingerprint), // Para Android
          onPressed: handleBiometricAuth, // Llama a la función de autenticación
          iconSize: 50,
        ),
        cupertino: (_, __) => GestureDetector(
          onTap: handleBiometricAuth, // Llama a la función de autenticación
          child: Icon(
            Icons.face, // Para iOS
            size: 50,
          ),
        ),
      ),
    );
  }
}
