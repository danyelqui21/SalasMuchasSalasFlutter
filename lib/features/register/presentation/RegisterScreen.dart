import 'package:flutter/material.dart';
import 'package:wdevproject/utils/ui/buttons/CustomButton.dart';
import 'package:wdevproject/utils/ui/dropdown/DropdownMenuApp.dart';
import 'package:wdevproject/utils/ui/input/InputPassword.dart';
import 'package:wdevproject/utils/ui/input/SimpleInput.dart';
import 'package:wdevproject/utils/ui/input/SimpleInputPhone.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wdevproject/utils/ui/social/SocialButton.dart';
import 'package:wdevproject/utils/ui/some/OrDivider.dart';
import 'package:wdevproject/utils/ui/text/FirstText.dart';
import 'package:wdevproject/utils/ui/text/LinkText.dart';
import 'package:go_router/go_router.dart';

// #docregion Initialize
const List<String> scopes = <String>[
  'email',
  'profile'
  //'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  clientId:
  '901881345005-k26vbbnr4pp0chnog8trq9bbg8khknoa.apps.googleusercontent.com',
  scopes: scopes,
);
// #enddocregion Initialize

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset('assets/images/logo2.png', width: 50),
              ),
              SizedBox(width: 40),

            ],
          ),
          ),
            body: SafeArea(
              child:
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // Centra verticalmente
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // Centra horizontalmente
                    children: [
                      // Logo
                      const SizedBox(height: 10),

                      FirstText(
                          text: "Regístrate con tus redes sociales"),

                      const SizedBox(height: 20),

                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SocialButton(
                                  onPressed: () => {},
                                  imagePath: AssetImage('assets/images/google_icon.png'),
                                  text: "Regístrate con Google"),
                           /*
                            TODO: Implement Facebook auth futher

                             SocialButton(
                                  onPressed: () => {},
                                  imagePath:
                                  AssetImage('assets/images/facebook_logo.png'),
                                  text: "Regístrate con Facebook"), */
                            ],
                          )),

                      OrDivider(),

                      FirstText(text: "Crear nueva cuenta"),

                      const SizedBox(height: 25),

                      // Campo de correo electrónico
                      SimpleInput(
                          controller: _nameController,
                          label : "Nombre (s) *",
                          placeholder: "Ingresa tu nombre"),

                      // Campo de correo electrónico
                      SimpleInput(
                          controller: _nameController,
                          label : "Apellido paterno  *",
                          placeholder: "Ingresa tu apellido paterno"),

                      // Campo de correo electrónico
                      SimpleInput(
                          controller: _nameController,
                          label : "Apellido materno",
                          placeholder: "Ingresa tu apellido materno"),

                      // Campo de correo electrónico
                      SimpleInput(
                          controller: _nameController,
                          label : "Género",
                          placeholder: "Ingresa tu apellido materno"),

                      DropdownClearText(
                          items: <String>['Masculino', 'Femenino'],
                          label : "Género",
                          controller: _genderController),

                      SimpleInputPhone(),

                      const SizedBox(height: 20),

                      // Campo de correo electrónico
                      InputPassword(controller: _passwordController),

                      const SizedBox(height: 20),

                      InputPassword(controller: _passwordController),
                      const SizedBox(height: 20),

                      // Botón de Iniciar Sesión
                      CustomButton(
                        onPressed: () {
                          if (!isLoading) {
                            _startSession(); // Aquí se llama el método correctamente
                          }
                        },
                        text: "Iniciar sesión",
                        isLoading: isLoading,
                      ),

                      const SizedBox(height: 10),

                      /*BiometricAuthButton(
              onAuthenticated: () {
                // Lógica que se ejecuta después de la autenticación exitosa
              },
            ),*/

                      // Texto de Registrarse
                      LinkText(onPressed: () => {}, text: "¿Ya tienes una cuenta?"),


                      const SizedBox(height: 25),


                    ],
                  ),
                ),
              )

            )));
  }

  void _login() {
    setState(() {
      isLoading = true;
    });

    // Simular un delay para login (esto lo cambias por tu lógica de login)
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
      // Aquí manejas la respuesta del login
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> HandleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // El usuario canceló el inicio de sesión
        return;
      }

      // Obtén el correo electrónico
      final String email = googleUser.email;
      final String displayName = googleUser.displayName.toString();
      // Envía el correo al backend para vincularlo
      // Desconectar al usuario de Google después de obtener el correo
      await _googleSignIn.signOut();
    } catch (error) {
      ShowErrorDialog(error.toString());
      print('Error dude: $error');
    }
  }

  void ShowErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Token? xd'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                context.push('/register');
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _startSession() {
    setState(() {
      isLoading = true; // Cambia el estado a cargando
    });

    // Simula una tarea asíncrona
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false; // Cambia el estado a no cargando
      });
      print("Session started");
    });
  }
}
