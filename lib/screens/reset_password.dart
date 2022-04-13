import 'package:firebase_demo/components/custom_button.dart';
import 'package:firebase_demo/components/custom_textfield.dart';
import 'package:firebase_demo/components/snackbar.dart';
import 'package:firebase_demo/core/authentication_service.dart';
import 'package:firebase_demo/core/firebase_exceptions.dart';
import 'package:firebase_demo/screens/login.dart';
import 'package:firebase_demo/utils/loader.dart';
import 'package:firebase_demo/utils/validator.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String id = 'reset_password';
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _authService = AuthenticationService();

  @override
  void dispose() {
    _emailController.dispose();
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
                const SizedBox(height: 70),
                const Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please enter your email address to recover your password.',
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
                  controller: _emailController,
                  validator: (value) => Validator.validateEmail(value ?? ""),
                ),
                const SizedBox(height: 16),
                const Expanded(child: SizedBox()),
                CustomButton(
                  label: 'RECOVER PASSWORD',
                  color: Colors.black,
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      LoaderX.show(context);
                      final _status = await _authService.resetPassword(
                          email: _emailController.text.trim());
                      if (_status == AuthStatus.successful) {
                        LoaderX.hide();
                        Navigator.pushNamed(context, LoginScreen.id);
                      } else {
                        LoaderX.hide();
                        final error =
                            AuthExceptionHandler.generateErrorMessage(_status);
                        CustomSnackBar.showErrorSnackBar(context,
                            message: error);
                      }
                    }
                  },
                  size: size,
                  textColor: Colors.white,
                  borderSide: BorderSide.none,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
