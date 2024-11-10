import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wdevproject/Themes/MyTheme.dart';
import 'package:wdevproject/features/login/presentation/LoginScreen.dart';
import 'package:wdevproject/features/register/presentation/RegisterScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final router = GoRouter(
    initialLocation: '/',
    //redirect: (context, state) {
     // if(true) {
      //  return '/';
      //}else{
       // return '/login';
      //}
   // },
      navigatorKey: GlobalKey<NavigatorState>(),
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
    ],
    routerNeglect: false //Ignore paths on mobile devices
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muebles De Éxito',
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}
