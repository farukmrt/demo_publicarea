import 'package:demo_publicarea/resources/auth_methods.dart';
import 'package:demo_publicarea/screens/tabs_screen.dart';
import 'package:demo_publicarea/widgets/custom_button.dart';
import 'package:demo_publicarea/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();

  loginUser() async {
    bool res = await _authMethods.loginUser(
      context,
      _emailController.text,
      _passwordController.text,
    );
    if (res) {
      Navigator.pushReplacementNamed(context, TabsScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş Yap'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.1),
              CustomTextField(
                controller: _emailController,
                labelText: 'Email Adresinizi girin',
              ),
              CustomTextField(
                controller: _passwordController,
                labelText: 'Parolanızı girin',
              ),
              const SizedBox(height: 15),
              CustomButton(onTap: loginUser, text: 'Giriş yap')
            ],
          ),
        ),
      ),
    );
  }
}
