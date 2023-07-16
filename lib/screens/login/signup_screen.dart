import 'package:demo_publicarea/resources/auth_methods.dart';
import 'package:demo_publicarea/screens/main/tabs_screen.dart';
import 'package:demo_publicarea/widgets/custom_image_input.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/widgets/custom_textfield.dart';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/sign';
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();
  void signUpUser() async {
    bool res = await _authMethods.signUpUser(
      context,
      _emailController.text,
      _usernameController.text,
      _passwordController.text,
      _nameController.text,
      _surnameController.text,
      _buildingController.text,
    );
    if (res) {
      PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
        context,
        settings: RouteSettings(name: TabsScreen.routeName),
        screen: const TabsScreen(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Üye Ol'),
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
                labelText: 'Parolanızı oluşturun',
              ),
              CustomTextField(
                controller: _usernameController,
                labelText: 'Kullanıcı adınızı oluşturun',
              ),
              CustomTextField(
                controller: _nameController,
                labelText: 'Adınızı girin',
              ),
              CustomTextField(
                controller: _surnameController,
                labelText: 'Soyadınızı girin',
              ),
              CustomTextField(
                controller: _buildingController,
                labelText: 'Bina adını girin',
              ),
              ImageInput(
                onPickImage: (image) {
                  // _selectedImage = image;
                },
              ),
              const SizedBox(height: 15),
              CustomMainButton(
                  onTap: signUpUser,
                  text: 'Üye ol..',
                  edgeInsets: const EdgeInsets.symmetric(vertical: 8))
            ],
          ),
        ),
      ),
    );
  }
}
