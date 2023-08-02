import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/screens/main/tabs_screen.dart';
import 'package:demo_publicarea/widgets/custom_textfield.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //final AuthMethods _authMethods = AuthMethods();

  void loginUser() async {
    bool res = await UserProvider().loginUser(
      context,
      _emailController.text,
      _passwordController.text,
    );
    if (res) {
      //dispose(); //

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

    var trnslt = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(trnslt.lcod_lbl_login),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.1),
              CustomTextField(
                controller: _emailController,
                labelText: trnslt.lcod_lbl_email,
              ),
              CustomTextField(
                controller: _passwordController,
                labelText: trnslt.lcod_lbl_password,
              ),
              const SizedBox(height: 15),
              CustomMainButton(
                onTap: loginUser,
                text: trnslt.lcod_lbl_login,
                edgeInsets: const EdgeInsets.symmetric(vertical: 8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
