// import 'package:provider/provider.dart';
// import 'package:demo_publicarea/providers/building_provider.dart';
// import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/screens/login/login_screen.dart';
import 'package:demo_publicarea/screens/login/signup_screen.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = '/onboarding';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var trnslt = AppLocalizations.of(context)!;
    // UserProvider userProvider = Provider.of<UserProvider>(context);

    // BuildingProvider buildingProvider = Provider.of<BuildingProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                trnslt.lcod_lbl_welcome,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              const SizedBox(height: 30),
              CustomMainButton(
                edgeInsets: const EdgeInsets.symmetric(vertical: 8),
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                    context,
                    settings: const RouteSettings(name: LoginScreen.routeName),
                    screen: const LoginScreen(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                text: trnslt.lcod_lbl_login,
              ),
              CustomMainButton(
                edgeInsets: const EdgeInsets.symmetric(vertical: 8),
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                    context,
                    settings: const RouteSettings(name: SignupScreen.routeName),
                    screen: const SignupScreen(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                text: trnslt.lcod_lbl_signup,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
