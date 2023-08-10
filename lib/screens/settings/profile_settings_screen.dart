import 'dart:io';

import 'package:demo_publicarea/screens/settings/update_email_screen.dart';
import 'package:demo_publicarea/screens/settings/update_password_screen.dart';
import 'package:demo_publicarea/screens/settings/update_phonenumber_screen.dart';
import 'package:demo_publicarea/screens/settings/update_profilphoto_screen.dart';
import 'package:demo_publicarea/screens/settings/update_username_screen.dart';
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
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);

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
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35)),
                            width: size.width * (3 / 2),
                            //height: 200,
                            child: GestureDetector(
                              child: Image.network(
                                  userProvider.currentUser.imageUrl),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                      context,
                      settings: RouteSettings(
                          name: UpdateProfilphotoScreen.routeName),
                      screen: const UpdateProfilphotoScreen(),
                      withNavBar: true,
                    );
                  },
                  child: CustomListItem(
                    title:
                        '${userProvider.currentUser.name} ${userProvider.currentUser.surname}',
                    subtitle: trnslt.lcod_lbl_name_surname,
                    leading: CircleAvatar(
                      foregroundImage:
                          NetworkImage(userProvider.currentUser.imageUrl),
                      radius: 35,
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          PersistentNavBarNavigator
                              .pushNewScreenWithRouteSettings(
                            context,
                            settings: RouteSettings(
                                name: UpdateProfilphotoScreen.routeName),
                            screen: const UpdateProfilphotoScreen(),
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
                          RouteSettings(name: UpdateEmailScreen.routeName),
                      screen: const UpdateEmailScreen(),
                      withNavBar: true,
                    );
                  },
                  child: CustomListItem(
                    title: userProvider.currentUser.email,
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
                              RouteSettings(name: UpdateEmailScreen.routeName),
                          screen: const UpdateEmailScreen(),
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
                          RouteSettings(name: UpdateUsernameScreen.routeName),
                      screen: const UpdateUsernameScreen(),
                      withNavBar: true,
                    );
                  },
                  child: CustomListItem(
                    title: userProvider.currentUser.username,
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
                              name: UpdateUsernameScreen.routeName),
                          screen: const UpdateUsernameScreen(),
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
                          name: UpdatePhonenumberScreen.routeName),
                      screen: const UpdatePhonenumberScreen(),
                      withNavBar: true,
                    );
                  },
                  child: CustomListItem(
                    title: userProvider.currentUser.phoneNumber,
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
                              name: UpdatePhonenumberScreen.routeName),
                          screen: const UpdatePhonenumberScreen(),
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
                  title: userProvider.currentUser.building,
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
                          RouteSettings(name: UpdatePasswordScreen.routeName),
                      screen: const UpdatePasswordScreen(),
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
                            RouteSettings(name: UpdatePasswordScreen.routeName),
                        screen: const UpdatePasswordScreen(),
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
