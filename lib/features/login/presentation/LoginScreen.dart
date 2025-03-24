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

const List<String> scopes = <String>[
  'email',
  'profile',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  serverClientId: '901881345005-k26vbbnr4pp0chnog8trq9bbg8khknoa.apps.googleusercontent.com',
  scopes: scopes,
);

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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ));
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Si el ancho de la pantalla es mayor a 1024px, mostramos la imagen y el formulario
          if (constraints.maxWidth > 1000) {
            return Row(
              children: [
                // Imagen a la izquierda
                Expanded(
                  flex: 10,
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/cover.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Formulario a la derecha
                Expanded(
                  flex: 7,
                  child: _buildLoginForm(padding: EdgeInsets.symmetric(vertical: 100, horizontal: 80)),

                ),
              ],
            );
          }

          else if (constraints.maxWidth > 600){
            // En pantallas medianas y pequeñas, solo mostramos el formulario centrado
            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(0),
                child: _buildLoginForm(padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10)),
              ),
            );
          }
          else {
            // En pantallas medianas y pequeñas, solo mostramos el formulario centrado
            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(0),
                child: _buildLoginForm(padding: EdgeInsets.symmetric(vertical: 40, horizontal: 15)),
              ),
            );
          }
        },
      ),
    );
  }

  // Formulario de login (reutilizable)
  Widget _buildLoginForm({required EdgeInsets padding}) {
    return Card(
      color: MyTheme.white,
      elevation: 1, // Sombra de la tarjeta
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5), // Bordes redondeados
      ),
      child: Container(
        constraints: BoxConstraints(maxWidth: 650), // Limita el ancho del formulario
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 1),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: MyTheme.borderColor),
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.all(5),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Image.asset('assets/images/logo2.png',
                      width: 120)),
            ),

            const SizedBox(height: 20),
            SimpleInputPhone(),
            const SizedBox(height: 20),
            InputPassword(controller: _passwordController),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                if (!isLoading) {
                  _startSession();
                }
              },
              text: "Iniciar sesión",
              isLoading: isLoading,
            ),
            const SizedBox(height: 10),
            LinkText(onPressed: () {}, text: "¿Olvidaste tu contraseña?"),
            LinkText(onPressed: () => Navigator.pushNamed(context, '/register'), text: "Registrarse"),
            const SizedBox(height: 25),
            OrDivider(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SocialButton(onPressed: () => HandleSignIn(), imagePath: AssetImage('assets/images/google_icon.png'), text: "Iniciar con Google"),
                  SocialButton(onPressed: () => {}, imagePath: AssetImage('assets/images/facebook_logo.png'), text: "Iniciar con Facebook"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login() {
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
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
      if (googleUser == null) return;

      final ggAuth = await googleUser.authentication;
      final String email = googleUser.email;
      final String displayName = googleUser.displayName.toString();
      final String accessToken = ggAuth.accessToken.toString();
      await _googleSignIn.signOut();

      print("Google login successful");
    } catch (error) {
      ShowErrorDialog(error.toString());
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
      isLoading = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
      print("Session started");
    });
  }

  Future<void> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status == LoginStatus.success) {
      final AccessToken accessToken = loginResult.accessToken!;
      print("Access token: ${accessToken.tokenString}");
    } else if (loginResult.status == LoginStatus.cancelled) {
      print("Login canceled by the user");
    } else {
      print("Login error: ${loginResult.message}");
    }
  }
}