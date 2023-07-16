import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/screens/login/onboard_screen.dart';
import 'package:demo_publicarea/screens/settings/data_create.dart';
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

    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomListItem(
              subtitle: 'İsim Soyisim',
              title: '${userProvider.user.name} ${userProvider.user.surname}',
            ),
            CustomListItem(
              title: userProvider.user.building,
              subtitle: 'Bina',
            ),
            CustomListItem(
              title: userProvider.user.email,
              subtitle: 'E-Mail',
            ),
            CustomListItem(
              title: userProvider.user.username,
              subtitle: 'Kullanıcı Adı',
            ),
            const SizedBox(
              height: 55,
            ),
            CustomMainButton(
              edgeInsets: const EdgeInsets.symmetric(horizontal: 30),
              onTap: () async {
                //TODO
                //auth methods icine aktarılacak
                await FirebaseAuth.instance.signOut();
                // Navigator.of(context, rootNavigator: false).push(
                //     MaterialPageRoute(
                //         builder: (context) => const OnboardingScreen(),
                //         maintainState: true));
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const OnboardingScreen(),
                  withNavBar: false,
                );
              },
              text: 'Hesaptan çıkış yap',
            ),
            IconButton(
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(context,
                      screen: MyWidgetScreen());
                },
                icon: Icon(Icons.abc))
          ],
        ),
      ),
    );
  }
}
