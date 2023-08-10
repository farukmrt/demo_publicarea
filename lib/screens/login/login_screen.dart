import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';
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
  bool changing = false;
  @override
  void initState() {
    super.initState();
    _emailController.addListener(_mailControllerListener);
    _passwordController.addListener(_mailControllerListener);
    _mailControllerListener();
  }

  void _mailControllerListener() {
    String mailValue = _emailController.text;
    String passValue = _passwordController.text;
    print('Yeni e-posta değeri: $mailValue');
    print('Yeni şifre değeri: $passValue');

    setState(() {
      if (mailValue.endsWith('.com') &&
          mailValue.contains('@') &&
          passValue.length > 5) {
        print('$changing');
        changing = true;
      } else {
        print('$changing');
        changing = false;
      }
    });
  }

  @override
  void dispose() {
    _emailController.removeListener(_mailControllerListener);
    _passwordController.removeListener(_mailControllerListener);
    super.dispose();
  }

  void loginUser(UserProvider userProvider) async {
    bool res = await userProvider.loginUser(
      context,
      _emailController.text,
      _passwordController.text,
    );

    if (res) {
      setState(() {});

      PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
        context,
        settings: RouteSettings(name: TabsScreen.routeName),
        screen: const TabsScreen(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    var trnslt = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(trnslt.lcod_lbl_login),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: size.height * 0.1),
                CustomTextField(
                  controller: _emailController,
                  labelText: trnslt.lcod_lbl_email,
                  maxLength: 33,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.endsWith('.com') ||
                        !value.contains('@') ||
                        value.characters.length < 9) {
                      return trnslt.lcod_lbl_control_email;
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: _passwordController,
                  labelText: trnslt.lcod_lbl_password,
                  obscore: true,
                  maxLength: 20,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.characters.length < 6) {
                      return trnslt.lcod_lbl_control_password;
                    }
                    return null; // Herhangi bir hata yoksa null döndürün.
                  },
                ),
                const SizedBox(height: 15),
                CustomMainButton(
                  text: trnslt.lcod_lbl_login,
                  edgeInsets: const EdgeInsets.symmetric(vertical: 8),
                  onTap: (() {
                    setState(() {
                      changing;
                    });

                    if (_formKey.currentState!.validate() && changing)
                      loginUser(userProvider);
                  }),
                  color:
                      changing ? primaryColor : primaryColor.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
