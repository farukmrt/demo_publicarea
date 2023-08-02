import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/screens/settings/kvkk_screen.dart';
import 'package:demo_publicarea/screens/settings/language_settings.dart';
import 'package:demo_publicarea/screens/settings/user_agreement.dart';
import 'package:demo_publicarea/utils/languages/language.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:demo_publicarea/screens/settings/profile_settings_screen.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../main.dart';
import '../../utils/languages/lang.dart';

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
    var trnslt = AppLocalizations.of(context)!;
    return Container(
      color: primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: primaryColor,
            //elevation: 50.0,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            leading: IconButton(
              iconSize: 40,
              icon: Icon(Icons.settings, color: mainBackgroundColor),
              onPressed: () {
                PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                  context,
                  settings:
                      RouteSettings(name: ProfileSettingsScreen.routeName),
                  screen: const ProfileSettingsScreen(),
                  withNavBar: true,
                );
              },
            ),
            // Row(
            //   children: [
            //     const SizedBox(
            //       width: 15,
            //     ),
            //     // CircleAvatar(
            //     //   foregroundImage: NetworkImage(userProvider.user.imageUrl),
            //     //   radius: 25,
            //     // ),
            //   ],
            // ),
            //toolbarHeight: 80,
            centerTitle: true,
            title: Text(
                '${trnslt.lcod_lbl_dear_username_surname(userProvider.user.name, userProvider.user.surname)} \n${userProvider.user.building}',
                //textAlign: TextAlign.center,
                // 'Sayın ${userProvider.user.name} ${userProvider.user.surname}\n${userProvider.user.building}',
                style: TextStyle(color: mainBackgroundColor)),
          ),
          body: Center(
            child: Container(
              height: size.height * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // CustomMainButton(
                  //   onTap: () {
                  //     PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                  //       context,
                  //       settings: RouteSettings(
                  //           name: ProfileSettingsScreen.routeName),
                  //       screen: const ProfileSettingsScreen(),
                  //       withNavBar: true,
                  //     );
                  //   },
                  //   text: trnslt.lcod_lbl_profile_settings,
                  //   edgeInsets: const EdgeInsets.symmetric(horizontal: 30),
                  // ),
                  // DropdownButton<Language>(
                  //   iconSize: 30,
                  //   hint: Text(translation(context).changeLanguage),
                  //   onChanged: (Language? language) async {
                  //     if (language != null) {
                  //       Locale _locale = await setLocale(language.languageCode);
                  //       MyApp.setLocale(context, _locale);
                  //     }
                  //   },
                  //   items: Language.languageList()
                  //       .map<DropdownMenuItem<Language>>(
                  //         (e) => DropdownMenuItem<Language>(
                  //           value: e,
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //             children: <Widget>[
                  //               Text(
                  //                 e.flag,
                  //                 style: const TextStyle(fontSize: 30),
                  //               ),
                  //               Text(e.name)
                  //             ],
                  //           ),
                  //         ),
                  //       )
                  //       .toList(),
                  // ),
                  // CustomMainButton(
                  //   text: 'Dil Ayarları',
                  //   onTap: () {
                  //     showDialog(context: context, builder: (context) {return });

                  //   },
                  //   edgeInsets: const EdgeInsets.symmetric(horizontal: 30),
                  // ),
                  CustomMainButton(
                    onTap: () {},
                    text: trnslt.lcod_lbl_new_building,
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
                    text: trnslt.lcod_lbl_kvkk,
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
                    text: trnslt.lcod_lbl_user_agreement,
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
                    text: trnslt.lcod_lbl_logout,
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
