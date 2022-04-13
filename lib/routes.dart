import 'package:firebase_demo/screens/home_screen.dart';
import 'package:firebase_demo/screens/login.dart';
import 'package:firebase_demo/screens/reset_password.dart';
import 'package:firebase_demo/screens/sign_up.dart';
import 'package:flutter/material.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SignUpScreen.id:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case LoginScreen.id:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case ResetPasswordScreen.id:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());

      case HomeScreen.id:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      // case VerifyAccountScreen.id:
      //   dynamic args = settings.arguments;
      //   return MaterialPageRoute(
      //       builder: (_) => VerifyAccountScreen(
      //             token: args['token'],
      //             uid: args['uid'],
      //           ));

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(child: Text('Something went wrong')),
                ));
    }
  }
}
