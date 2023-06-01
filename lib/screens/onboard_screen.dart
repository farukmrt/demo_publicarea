import 'package:demo_publicarea/screens/login_screen.dart';
import 'package:demo_publicarea/screens/signup_screen.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = '/onboarding';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "PublicArea'ya \nHoşgeldiniz",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              onTap: () {
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
              text: 'Giriş yap',
            ),
            CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, SignupScreen.routeName);
                },
                text: 'Üye ol'),
          ],
        ),
      ),
    );
  }
}
