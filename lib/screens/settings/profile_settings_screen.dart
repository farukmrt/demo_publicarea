import 'dart:io';

import 'package:demo_publicarea/screens/settings/custom_update_email.dart';
import 'package:demo_publicarea/screens/settings/custom_update_password.dart';
import 'package:demo_publicarea/screens/settings/custom_update_phonenumber.dart';
import 'package:demo_publicarea/screens/settings/custom_update_profilphoto.dart';
import 'package:demo_publicarea/screens/settings/custom_update_username.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:demo_publicarea/main.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/utils/languages/lang.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:demo_publicarea/utils/languages/language.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';

class ProfileSettingsScreen extends StatefulWidget {
  static String routeName = '/profilesettings';
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  // @override
  // Color getButtonColor() {
  //   return Function() ? primaryColor : primaryColor.withOpacity(0.5);
  // }

  File? selectedImage;
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var trnslt = AppLocalizations.of(context)!;
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(trnslt.lcod_lbl_profile_screen),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onLongPress: () {
                    CupertinoAlertDialog(
                      content: CircleAvatar(
                        foregroundImage:
                            NetworkImage(userProvider.user.imageUrl),
                        radius: 160,
                      ),
                    );
                  },
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                      context,
                      settings: RouteSettings(
                          name: CustomUpdateProfilphoto.routeName),
                      screen: const CustomUpdateProfilphoto(),
                      withNavBar: true,
                    );
                  },
                  child: CustomListItem(
                    title:
                        '${userProvider.user.name} ${userProvider.user.surname}',
                    subtitle: trnslt.lcod_lbl_name_surname,
                    leading: CircleAvatar(
                      foregroundImage: NetworkImage(userProvider.user.imageUrl),
                      radius: 35,
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          PersistentNavBarNavigator
                              .pushNewScreenWithRouteSettings(
                            context,
                            settings: RouteSettings(
                                name: CustomUpdateProfilphoto.routeName),
                            screen: const CustomUpdateProfilphoto(),
                            withNavBar: true,
                          );
                        },
                        icon: const Icon(Icons.change_circle_outlined)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                      context,
                      settings:
                          RouteSettings(name: CustomUpdateEmail.routeName),
                      screen: const CustomUpdateEmail(),
                      withNavBar: true,
                    );
                  },
                  child: CustomListItem(
                    title: userProvider.user.email,
                    subtitle: trnslt.lcod_lbl_email_text,
                    leading: const Icon(
                      Icons.email_outlined,
                      size: 40,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.change_circle_outlined),
                      onPressed: () {
                        PersistentNavBarNavigator
                            .pushNewScreenWithRouteSettings(
                          context,
                          settings:
                              RouteSettings(name: CustomUpdateEmail.routeName),
                          screen: const CustomUpdateEmail(),
                          withNavBar: true,
                        );
                      },
                    ),
                  ),
                ),
                //EMAİL-OK
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                      context,
                      settings:
                          RouteSettings(name: CustomUpdateUsername.routeName),
                      screen: const CustomUpdateUsername(),
                      withNavBar: true,
                    );
                  },
                  child: CustomListItem(
                    title: userProvider.user.username,
                    subtitle: trnslt.lcod_lbl_username,
                    leading: const Icon(
                      Icons.account_circle_outlined,
                      size: 40,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.change_circle_outlined),
                      onPressed: () {
                        PersistentNavBarNavigator
                            .pushNewScreenWithRouteSettings(
                          context,
                          settings: RouteSettings(
                              name: CustomUpdateUsername.routeName),
                          screen: const CustomUpdateUsername(),
                          withNavBar: true,
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                      context,
                      settings: RouteSettings(
                          name: CustomUpdatePhonenumber.routeName),
                      screen: const CustomUpdatePhonenumber(),
                      withNavBar: true,
                    );
                  },
                  child: CustomListItem(
                    title: userProvider.user.phoneNumber,
                    subtitle: trnslt.lcod_lbl_phone_number,
                    leading: const Icon(
                      Icons.call,
                      size: 40,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.change_circle_outlined),
                      onPressed: () {
                        PersistentNavBarNavigator
                            .pushNewScreenWithRouteSettings(
                          context,
                          settings: RouteSettings(
                              name: CustomUpdatePhonenumber.routeName),
                          screen: const CustomUpdatePhonenumber(),
                          withNavBar: true,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomListItem(
                  title: userProvider.user.building,
                  subtitle: trnslt.lcod_lbl_building,
                  leading: const Icon(
                    Icons.apartment_outlined,
                    size: 40,
                  ),
                ),
                DropdownButton<Language>(
                  iconSize: 30,
                  hint: Text(translation(context).changeLanguage),
                  onChanged: (Language? language) async {
                    if (language != null) {
                      Locale _locale = await setLocale(language.languageCode);
                      MyApp.setLocale(context, _locale);
                    }
                  },
                  items: Language.languageList()
                      .map<DropdownMenuItem<Language>>(
                        (e) => DropdownMenuItem<Language>(
                          value: e,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                e.flag,
                                style: const TextStyle(fontSize: 30),
                              ),
                              Text(e.name)
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 35,
                ),

                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                      context,
                      settings:
                          RouteSettings(name: CustomUpdatePassword.routeName),
                      screen: const CustomUpdatePassword(),
                      withNavBar: true,
                    );
                  },
                  child: CustomMainButton(
                    text: trnslt.lcod_lbl_update_password,
                    edgeInsets: const EdgeInsets.symmetric(horizontal: 30),
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                        context,
                        settings:
                            RouteSettings(name: CustomUpdatePassword.routeName),
                        screen: const CustomUpdatePassword(),
                        withNavBar: true,
                      );
                    },
                  ),
                ),

                CustomMainButton(
                  text: trnslt.lcod_lbl_logout,
                  edgeInsets: const EdgeInsets.symmetric(horizontal: 20),
                  onTap: () async {
                    await userProvider.signOut(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
