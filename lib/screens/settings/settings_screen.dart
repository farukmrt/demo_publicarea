import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/screens/login/onboard_screen.dart';
import 'package:demo_publicarea/screens/settings/data_create.dart';
import 'package:demo_publicarea/screens/settings/profile_settings_screen.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    final size = MediaQuery.of(context).size;

    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
                'Sayın ${userProvider.user.name} ${userProvider.user.surname}'),
          ),
          body: Center(
            child: Container(
              height: size.height * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomMainButton(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                        context,
                        settings: RouteSettings(
                            name: ProfileSettingsScreen.routeName),
                        screen: const ProfileSettingsScreen(),
                        withNavBar: true,
                      );
                    },
                    text: 'Profil Ayarlar',
                    edgeInsets: const EdgeInsets.symmetric(horizontal: 40),
                  ),
                  CustomMainButton(
                    onTap: () {},
                    text: 'Dil Ayarları',
                    edgeInsets: const EdgeInsets.symmetric(horizontal: 38),
                  ),
                  CustomMainButton(
                    onTap: () {},
                    text: 'Yeni Siteye Kayıt Olma',
                    edgeInsets: const EdgeInsets.symmetric(horizontal: 36),
                  ),
                  CustomMainButton(
                    onTap: () {},
                    text: 'KVKK Metni',
                    edgeInsets: const EdgeInsets.symmetric(horizontal: 34),
                  ),
                  CustomMainButton(
                    onTap: () {},
                    text: 'Kullanıcı Sözleşmesi',
                    edgeInsets: const EdgeInsets.symmetric(horizontal: 32),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  CustomMainButton(
                    edgeInsets: const EdgeInsets.symmetric(horizontal: 30),
                    onTap: () async {
                      //TODO
                      //auth methods icine aktarılacak
                      await FirebaseAuth.instance.signOut();

                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const OnboardingScreen(),
                        withNavBar: false,
                      );
                    },
                    text: 'Hesaptan çıkış yap',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
