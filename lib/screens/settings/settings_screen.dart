import 'package:demo_publicarea/screens/settings/kvkk_screen.dart';
import 'package:demo_publicarea/screens/settings/user_agreement.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:demo_publicarea/screens/settings/profile_settings_screen.dart';

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
                    edgeInsets: const EdgeInsets.symmetric(horizontal: 30),
                  ),
                  CustomMainButton(
                    onTap: () {},
                    text: 'Dil Ayarları',
                    edgeInsets: const EdgeInsets.symmetric(horizontal: 30),
                  ),
                  CustomMainButton(
                    onTap: () {},
                    text: 'Yeni Siteye Kayıt Olma',
                    edgeInsets: const EdgeInsets.symmetric(horizontal: 30),
                  ),
                  CustomMainButton(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                        context,
                        settings: RouteSettings(name: KvkkScreen.routeName),
                        screen: const KvkkScreen(),
                        withNavBar: true,
                      );
                    },
                    text: 'KVKK Metni',
                    edgeInsets: const EdgeInsets.symmetric(horizontal: 30),
                  ),
                  CustomMainButton(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                        context,
                        settings:
                            RouteSettings(name: UserAgreementScreen.routeName),
                        screen: const UserAgreementScreen(),
                        withNavBar: true,
                      );
                    },
                    text: 'Kullanıcı Sözleşmesi',
                    edgeInsets: const EdgeInsets.symmetric(horizontal: 30),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomMainButton(
                    edgeInsets: const EdgeInsets.symmetric(horizontal: 30),
                    onTap: () async {
                      await userProvider.signOut(context);
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
