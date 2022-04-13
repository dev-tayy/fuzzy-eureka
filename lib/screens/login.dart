import 'package:firebase_demo/components/custom_button.dart';
import 'package:firebase_demo/components/custom_textfield.dart';
import 'package:firebase_demo/components/snackbar.dart';
import 'package:firebase_demo/core/authentication_service.dart';
import 'package:firebase_demo/core/firebase_exceptions.dart';
import 'package:firebase_demo/screens/home_screen.dart';
import 'package:firebase_demo/screens/reset_password.dart';
import 'package:firebase_demo/screens/sign_up.dart';
import 'package:firebase_demo/utils/loader.dart';
import 'package:firebase_demo/utils/validator.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthenticationService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      width: size.width,
      height: size.height,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close),
              ),
              const Expanded(child: SizedBox(height: 70)),
              const Text(
                'Sign into your Account',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Log into your account.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Email address',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: 'abc@example.com',
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                validator: (value) => Validator.validateEmail(value ?? ""),
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: '********',
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 6,
                controller: _passwordController,
                textCapitalization: TextCapitalization.none,
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                child: Text(
                  'Have you forgotten your password?',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, ResetPasswordScreen.id),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 0.0),
                ),
                child: const Text(
                  'Click here to recover it.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
CustomButton(
  label: 'LOG IN',
  color: Colors.black,
  onPressed: () async {
    if (_key.currentState!.validate()) {
      LoaderX.show(context);
      final _status = await _authService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (_status == AuthStatus.successful) {
        LoaderX.hide();
        Navigator.pushNamed(context, HomeScreen.id);
      } else {
        LoaderX.hide();
        final error =
            AuthExceptionHandler.generateErrorMessage(_status);
        CustomSnackBar.showErrorSnackBar(
          context,
          message: error,
        );
      }
    }
  },
                size: size,
                textColor: Colors.white,
                borderSide: BorderSide.none,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, SignUpScreen.id),
                child: RichText(
                  textScaleFactor: 0.8,
                  text: const TextSpan(
                    text: "Don't have an acccount? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign up here',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
