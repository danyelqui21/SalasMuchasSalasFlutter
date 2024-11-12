import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wdevproject/Themes/MyTheme.dart';
import 'package:wdevproject/utils/ui/buttons/CustomButton.dart';
import 'package:wdevproject/utils/ui/input/InputPassword.dart';
import 'package:wdevproject/utils/ui/input/SimpleInputPhone.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wdevproject/utils/ui/social/SocialButton.dart';
import 'package:wdevproject/utils/ui/some/OrDivider.dart';
import 'package:wdevproject/utils/ui/text/LinkText.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// #docregion Initialize
const List<String> scopes = <String>[
  'email',
  'profile'
  //'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientI// d
  serverClientId:
      '901881345005-k26vbbnr4pp0chnog8trq9bbg8khknoa.apps.googleusercontent.com',
  scopes: scopes,
);
// #enddocregion Initialize

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Set the status bar to black when this screen is first shown
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black, // Black status bar
      statusBarIconBrightness:
          Brightness.light, // Light icons for black background
    ));

    // Add observer to listen to lifecycle changes
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 0,
              backgroundColor: MyTheme.primaryColor,
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // Centra verticalmente
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // Centra horizontalmente
                  children: [
                    // Logo
                    const SizedBox(height: 1),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: MyTheme.borderColor),
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.all(5),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.0),
                          child: Image.asset('assets/images/logo2.png',
                              width: 150)),
                    ),

                    const SizedBox(height: 20),

                    // Campo de correo electrónico
                    SimpleInputPhone(),

                    const SizedBox(height: 20),

                    // Campo de correo electrónico
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
                    LinkText(
                        onPressed: () => {}, text: "¿Olvidaste tu contraseña?"),

                    // Texto de Registrarse
                    LinkText(
                        onPressed: () =>
                            {Navigator.pushNamed(context, '/register')},
                        text: "Registrarse"),

                    const SizedBox(height: 25),

                    OrDivider(),

                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SocialButton(
                                onPressed: () => {HandleSignIn()},
                                imagePath:
                                    AssetImage('assets/images/google_icon.png'),
                                text: "Login with Google"),
                            SocialButton(
                                onPressed: () => {},
                                imagePath: AssetImage(
                                    'assets/images/facebook_logo.png'),
                                text: "Login with Facenook"),
                          ],
                        )),
                  ],
                ),
              ),
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

      final ggAuth = await googleUser.authentication;

      // Obtén el correo electrónico
      final String email = googleUser.email;
      final String displayName = googleUser.displayName.toString();
      // final String idToken = ggAuth.idToken.toString();
      final String accessToken = ggAuth.accessToken.toString();
      // Envía el correo al backend para vincularlo
      // Desconectar al usuario de Google después de obtener el correo
      await _googleSignIn.signOut();

      print("Yeah baby");
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

  Future<void> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status == LoginStatus.success) {
      final AccessToken accessToken = loginResult.accessToken!;
      print("Token de acceso: ${accessToken.tokenString}");
    } else if (loginResult.status == LoginStatus.cancelled) {
      print("Inicio de sesión cancelado por el usuario");
    } else {
      print("Error en el inicio de sesión: ${loginResult.message}");
    }
  }
}
