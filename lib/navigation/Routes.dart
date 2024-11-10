import 'package:flutter/cupertino.dart';
import 'package:wdevproject/features/login/presentation/LoginScreen.dart';
import 'package:wdevproject/features/register/presentation/RegisterScreen.dart';

class Routes{
  static const String homeScreen = '/';
  static const String registerScreen = '/register';

  static final Map<String, WidgetBuilder> allRoutes = {
    homeScreen: (context) => const LoginScreen(),
    registerScreen: (context) => const RegisterScreen()
  };
}