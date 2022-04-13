import 'package:firebase_demo/components/custom_button.dart';
import 'package:firebase_demo/core/authentication_service.dart';
import 'package:firebase_demo/screens/login.dart';
import 'package:firebase_demo/utils/loader.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/blank-dp.png'),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Hi ${AuthenticationService.auth.currentUser!.displayName}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Welcome to your profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Email: ${AuthenticationService.auth.currentUser!.email}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 100,
                child: CustomButton(
                  label: 'LOGOUT',
                  color: Colors.black,
                  onPressed: () async {
                    LoaderX.show(context);
                    await AuthenticationService.auth.signOut().then((value) {
                      LoaderX.hide();
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginScreen.id, (route) => false);
                    });
                  },
                  size: size,
                  textColor: Colors.white,
                  borderSide: BorderSide.none,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
