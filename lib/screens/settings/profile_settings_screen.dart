import 'dart:io';
import 'package:demo_publicarea/providers/photo_provider.dart';
import 'package:demo_publicarea/widgets/custom_button.dart';
import 'package:demo_publicarea/widgets/custom_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:demo_publicarea/main.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/utils/languages/lang.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:demo_publicarea/utils/languages/language.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/widgets/loading_indicator.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/providers/building_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:demo_publicarea/screens/settings/update_email_screen.dart';
import 'package:demo_publicarea/screens/settings/update_password_screen.dart';
import 'package:demo_publicarea/screens/settings/update_username_screen.dart';
import 'package:demo_publicarea/screens/settings/update_phonenumber_screen.dart';
import 'package:demo_publicarea/screens/settings/update_profilphoto_screen.dart';

class ProfileSettingsScreen extends StatefulWidget {
  static String routeName = '/profilesettings';
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  File? selectedImage;
  String? imageUrl;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(size.width);
    var trnslt = AppLocalizations.of(context)!;
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);
    BuildingProvider buildingProvider =
        Provider.of<BuildingProvider>(context, listen: true);
    PhotoProvider photoProvider =
        Provider.of<PhotoProvider>(context, listen: true);
    final double coverHeight = size.width / 1.5;
    final double profileHeight = size.width / 2;
    final double top = coverHeight - profileHeight / 2.5;
    final bottom = profileHeight / 1.5;
    final double extra = size.width / 8;
    print(coverHeight);
    print(profileHeight);
    print(top);
    print(bottom);
    print(extra);

    return Container(
      color: backgroundColor,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profil Ekranı'),
          toolbarHeight: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: size.width - extra,
                child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: bottom),
                        child: Image.network(
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return LoadingAnimationWidget.stretchedDots(
                                  color: primaryColor, size: size.width / 2);
                            }
                          },
                          buildingProvider.currentBuilding.imageUrl,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: top,
                        child: GestureDetector(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: CircleAvatar(
                                      radius: size.width * (3 / 2),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            size.width * (3 / 2)),
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: Image.network(
                                            userProvider.currentUser.imageUrl,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return Center(
                                                  child: LoadingAnimationWidget
                                                      .inkDrop(
                                                          color:
                                                              backgroundColor,
                                                          size: size.width / 7),
                                                );

                                                // LoadingIndicator(
                                                //   size: size.width / 8.6,
                                                // );
                                              }
                                            },
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //       borderRadius:
                                  //           BorderRadius.circular(35)),
                                  //   width: size.width * (3 / 2),
                                  //   //height: 200,
                                  //   child: GestureDetector(
                                  //     child: Image.network(
                                  //         userProvider.currentUser.imageUrl),
                                  //     onTap: () {
                                  //       Navigator.of(context).pop();
                                  //     },
                                  //   ),
                                  // ),
                                );
                              },
                            );
                          },
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return Stack(
                                      children: [
                                        CupertinoAlertDialog(
                                          // title: Text('Resim Ekle'),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  await photoProvider
                                                      .takeAPhoto();
                                                  setState(() {
                                                    selectedImage =
                                                        photoProvider
                                                            .selectedImage;
                                                  });
                                                  imageUrl = await photoProvider
                                                      .sendPP(
                                                          selectedImage!,
                                                          userProvider
                                                              .currentUser
                                                              .username);
                                                  await userProvider.updatePP(
                                                      userProvider
                                                          .currentUser.uid,
                                                      imageUrl!);
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  trnslt.lcod_lbl_shooting,
                                                  style: TextStyle(
                                                      color:
                                                          mainBackgroundColor),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  // Galeri seçeneği için işlemler burada yapılacak
                                                  await photoProvider
                                                      .getAPhoto();
                                                  // Seçim yapıldığında, 'galeri' değeri ile iletişim kutusunu kapatacak
                                                  setState(() {
                                                    selectedImage =
                                                        photoProvider
                                                            .selectedImage;
                                                  });
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  imageUrl = await photoProvider
                                                      .sendPP(
                                                          selectedImage!,
                                                          userProvider
                                                              .currentUser
                                                              .username);
                                                  await userProvider.updatePP(
                                                      userProvider
                                                          .currentUser.uid,
                                                      imageUrl!);
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  trnslt
                                                      .lcod_lbl_upload_gallery,
                                                  style: TextStyle(
                                                      color:
                                                          mainBackgroundColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (isLoading)
                                          Center(
                                            child: LoadingAnimationWidget
                                                .dotsTriangle(
                                                    color: mainBackgroundColor,
                                                    size: size.width / 3),
                                          ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );

                            // PersistentNavBarNavigator
                            //     .pushNewScreenWithRouteSettings(
                            //   context,
                            //   settings: RouteSettings(
                            //       name: UpdateProfilphotoScreen.routeName),
                            //   screen: const UpdateProfilphotoScreen(),
                            //   withNavBar: true,
                            // );
                          },
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: size.width / 5,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(size.width / 5),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image.network(
                                      userProvider.currentUser.imageUrl,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child:
                                                LoadingAnimationWidget.inkDrop(
                                                    color: backgroundColor,
                                                    size: size.width / 3.4),
                                          );

                                          // LoadingIndicator(
                                          //   size: size.width / 8.6,
                                          // );
                                        }
                                      },
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              // CircleAvatar(
                              //   radius: size.width / 5,
                              //   backgroundImage: NetworkImage(
                              //       userProvider.currentUser.imageUrl),
                              //   // child:
                              //   //     Image.network(userProvider.currentUser.imageUrl)
                              // ),
                              Positioned(
                                //icon
                                bottom: 0, right: 0,
                                child: Container(
                                  height: size.width / 11.22,
                                  width: size.width / 11.22,
                                  decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(0.9),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    // heightFactor: 55,
                                    // widthFactor: 55,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
              // GestureDetector(
              //   onLongPress: () {
              //     showDialog(
              //       context: context,
              //       builder: (context) {
              //         return AlertDialog(
              //           content: Container(
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(35)),
              //             width: size.width * (3 / 2),
              //             //height: 200,
              //             child: GestureDetector(
              //               child: Image.network(
              //                   userProvider.currentUser.imageUrl),
              //               onTap: () {
              //                 Navigator.of(context).pop();
              //               },
              //             ),
              //           ),
              //         );
              //       },
              //     );
              //   },
              //   onTap: () {
              //     PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
              //       context,
              //       settings:
              //           RouteSettings(name: UpdateProfilphotoScreen.routeName),
              //       screen: const UpdateProfilphotoScreen(),
              //       withNavBar: true,
              //     );
              //   },
              //   child: CustomListItem(
              //     title:
              //         '${userProvider.currentUser.name} ${userProvider.currentUser.surname}',
              //     subtitle: trnslt.lcod_lbl_name_surname,
              //     leading: Container(
              //       width: 70,
              //       height: 70,
              //       decoration: BoxDecoration(
              //         border: Border.all(color: primaryColor, width: 2),
              //         shape: BoxShape.circle,
              //         image: DecorationImage(
              //           fit: BoxFit.cover,
              //           image: NetworkImage(
              //             userProvider.currentUser.imageUrl,
              //           ),
              //         ),
              //       ),
              //     ),
              //     // CircleAvatar(
              //     //   foregroundImage:
              //     //       NetworkImage(userProvider.currentUser.imageUrl),
              //     //   radius: 35,
              //     // ),
              //     trailing: IconButton(
              //       onPressed: () {
              //         PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
              //           context,
              //           settings: RouteSettings(
              //               name: UpdateProfilphotoScreen.routeName),
              //           screen: const UpdateProfilphotoScreen(),
              //           withNavBar: true,
              //         );
              //       },
              //       icon: const Icon(
              //         Icons.change_circle_outlined,
              //         color: primaryColor,
              //       ),
              //     ),
              //   ),
              // ),
              Stack(
                children: [
                  CustomTitle(
                    mainTitle:
                        '${userProvider.currentUser.name}\n${userProvider.currentUser.surname}',
                    textAlign: TextAlign.center,
                    color: backgroundColor,
                    fontSize: 30,
                  ),
                  Positioned(
                    left: extra / 2,
                    bottom: 0, //extra * 1.3,
                    child: IconButton(
                      iconSize: extra,
                      onPressed: () {
                        PersistentNavBarNavigator
                            .pushNewScreenWithRouteSettings(context,
                                settings: RouteSettings(
                                    name: UpdatePasswordScreen.routeName),
                                screen: const UpdatePasswordScreen(),
                                withNavBar: true);
                      },
                      icon: Icon(Icons.vpn_key_outlined),
                      color: secondaryBackgroundColor,
                    ),
                  ),
                  Positioned(
                    right: extra / 2,
                    bottom: 0,
                    child: IconButton(
                      iconSize: extra,
                      onPressed: () async {
                        await userProvider.signOut(context);
                      },
                      icon: Icon(Icons.logout_outlined),
                      color: secondaryBackgroundColor,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                    context,
                    settings: RouteSettings(name: UpdateEmailScreen.routeName),
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
                    color: primaryColor,
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.change_circle_outlined,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
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
                    color: primaryColor,
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.change_circle_outlined,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                        context,
                        settings:
                            RouteSettings(name: UpdateUsernameScreen.routeName),
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
                    settings:
                        RouteSettings(name: UpdatePhonenumberScreen.routeName),
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
                    color: primaryColor,
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.change_circle_outlined,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
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
                trailing: Text(
                  '${buildingProvider.currentBuilding.country}/\n${buildingProvider.currentBuilding.town}',
                  style: TextStyle(
                      color: primaryColor, fontWeight: FontWeight.w500),
                ),
                leading: const Icon(
                  Icons.apartment_outlined,
                  size: 40,
                  color: primaryColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: primaryColor, //.withOpacity(0.7),
                ),
                child: DropdownButton<Language>(
                  borderRadius: BorderRadius.circular(35),
                  dropdownColor: backgroundColor.withOpacity(1).withAlpha(127),
                  iconSize: 30,
                  hint: Text(
                    translation(context).changeLanguage,
                    style: TextStyle(color: mainBackgroundColor),
                  ),
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
              ),
              // const SizedBox(
              //   height: 35,
              // ),
              // GestureDetector(
              //   onTap: () {
              //     PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
              //       context,
              //       settings:
              //           RouteSettings(name: UpdatePasswordScreen.routeName),
              //       screen: const UpdatePasswordScreen(),
              //       withNavBar: true,
              //     );
              //   },
              //   child: CustomMainButton(
              //     text: trnslt.lcod_lbl_update_password,
              //     edgeInsets: const EdgeInsets.symmetric(horizontal: 25),
              //     onTap: () {
              //       PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
              //         context,
              //         settings:
              //             RouteSettings(name: UpdatePasswordScreen.routeName),
              //         screen: const UpdatePasswordScreen(),
              //         withNavBar: true,
              //       );
              //     },
              //   ),
              // ),
              // CustomMainButton(
              //   text: trnslt.lcod_lbl_logout,
              //   edgeInsets: const EdgeInsets.symmetric(horizontal: 25),
              //   onTap: () async {
              //     await userProvider.signOut(context);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
