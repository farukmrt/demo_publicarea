import 'dart:io';

import 'package:demo_publicarea/providers/photo_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/resources/auth_methods.dart';
import 'package:demo_publicarea/screens/login/onboard_screen.dart';
import 'package:demo_publicarea/screens/settings/data_create.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/widgets/loading_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class ProfileSettingsScreen extends StatefulWidget {
  static String routeName = '/profilesettings';
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  File? selectedImage;
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    PhotoProvider photoProvider = Provider.of<PhotoProvider>(context);

    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomListItem(
              trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          // title: Text('Resim Ekle'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Profil Resmini Güncelle'),
                              ElevatedButton(
                                onPressed: () async {
                                  await photoProvider.takeAPhoto();

                                  setState(() {
                                    selectedImage = photoProvider.selectedImage;
                                  });
                                  imageUrl = await photoProvider.sendPP(
                                      selectedImage!,
                                      userProvider.user.username);
                                  await userProvider.updatePP(
                                      userProvider.user.uid, imageUrl!);
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Çekim yap',
                                  style: TextStyle(color: mainBackgroundColor),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () async {
                                  // Galeri seçeneği için işlemler burada yapılacak
                                  await photoProvider.getAPhoto();
                                  // Seçim yapıldığında, 'galeri' değeri ile iletişim kutusunu kapatacak
                                  setState(() {
                                    selectedImage = photoProvider.selectedImage;
                                  });
                                  imageUrl = await photoProvider.sendPP(
                                      selectedImage!,
                                      userProvider.user.username);
                                  await userProvider.updatePP(
                                      userProvider.user.uid, imageUrl!);
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Galeriden yükle',
                                  style: TextStyle(color: mainBackgroundColor),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.change_circle_outlined)),
              leading: CircleAvatar(
                foregroundImage: NetworkImage(userProvider.user.imageUrl),
                radius: 35,
              ),
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

            // Consumer<UserProvider>(
            //                       builder: (context, data, index) {
            //                         return StreamBuilder<User>(
            //                           stream: data.userStream,
            //                           builder: (context, snapshot) {
            //                             if (snapshot.hasData) {
            //                               User user = snapshot.data!;
            //                               return CircleAvatar(
            //                                 foregroundImage:
            //                                     NetworkImage(user.imageUrl),
            //                                 radius: 45,
            //                               );
            //                             } else {
            //                               return const LoadingIndicator();
            //                             }
            //                           },
            //                         );
            //                       },
            //                     ),

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
              text: 'Şifreyi güncelle',
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
            IconButton(
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(context,
                      screen: const MyWidgetScreen());
                },
                icon: const Icon(Icons.abc))
          ],
        ),
      ),
    );
  }
}

// import 'dart:io';

// import 'package:demo_publicarea/providers/photo_provider.dart';
// import 'package:demo_publicarea/providers/user_providers.dart';
// import 'package:demo_publicarea/resources/auth_methods.dart';
// import 'package:demo_publicarea/screens/login/onboard_screen.dart';
// import 'package:demo_publicarea/screens/settings/data_create.dart';
// import 'package:demo_publicarea/utils/colors.dart';
// import 'package:demo_publicarea/widgets/custom_listItem.dart';
// import 'package:demo_publicarea/widgets/custom_main_button.dart';
// import 'package:demo_publicarea/widgets/loading_indicator.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// import 'package:provider/provider.dart';

// class ProfileSettingsScreen extends StatefulWidget {
//   static String routeName = '/profilesettings';
//   const ProfileSettingsScreen({Key? key}) : super(key: key);

//   @override
//   State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
// }

// class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
//   File? selectedImage;
//   String? imageUrl;
//   @override
//   Widget build(BuildContext context) {
//     UserProvider userProvider = Provider.of<UserProvider>(context);

//     PhotoProvider photoProvider = Provider.of<PhotoProvider>(context);

//     return Container(
//       color: backgroundColor,
//       child: SafeArea(
//         child: Consumer<UserProvider>(
//           builder: (context, data, index) {
//             return StreamBuilder<UserProvider>(
//               stream: userProvider.userStream,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   UserProvider dynamicuser = snapshot.data!;
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CustomListItem(
//                         trailing: IconButton(
//                             onPressed: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return CupertinoAlertDialog(
//                                     // title: Text('Resim Ekle'),
//                                     content: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         const Text('Profil Resmini Güncelle'),
//                                         ElevatedButton(
//                                           onPressed: () async {
//                                             await photoProvider.takeAPhoto();

//                                             setState(() {
//                                               selectedImage =
//                                                   photoProvider.selectedImage;
//                                             });
//                                             imageUrl =
//                                                 await photoProvider.sendPP(
//                                                     selectedImage!,
//                                                     dynamicuser.username);
//                                             await AuthMethods().updatePP(
//                                                 dynamicuser.uid, imageUrl!);
//                                             Navigator.pop(context);
//                                           },
//                                           child: const Text(
//                                             'Çekim yap',
//                                             style: TextStyle(
//                                                 color: mainBackgroundColor),
//                                           ),
//                                         ),
//                                         const SizedBox(height: 10),
//                                         ElevatedButton(
//                                           onPressed: () async {
//                                             // Galeri seçeneği için işlemler burada yapılacak
//                                             await photoProvider.getAPhoto();
//                                             // Seçim yapıldığında, 'galeri' değeri ile iletişim kutusunu kapatacak
//                                             setState(() {
//                                               selectedImage =
//                                                   photoProvider.selectedImage;
//                                             });
//                                             await photoProvider.sendPP(
//                                                 selectedImage!,
//                                                 dynamicuser.username);
//                                             await AuthMethods().updatePP(
//                                                 dynamicuser.uid, imageUrl!);
//                                             Navigator.pop(context);
//                                           },
//                                           child: const Text(
//                                             'Galeriden yükle',
//                                             style: TextStyle(
//                                                 color: mainBackgroundColor),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                             icon: const Icon(Icons.change_circle_outlined)),
//                         leading: CircleAvatar(
//                           foregroundImage: NetworkImage(dynamicuser.imageUrl),
//                           radius: 35,
//                         ),
//                         subtitle: 'İsim Soyisim',
//                         title: '${dynamicuser.name} ${dynamicuser.surname}',
//                       ),
//                       CustomListItem(
//                         title: dynamicuser.building,
//                         subtitle: 'Bina',
//                       ),
//                       CustomListItem(
//                         title: dynamicuser.email,
//                         subtitle: 'E-Mail',
//                       ),
//                       CustomListItem(
//                         title: dynamicuser.username,
//                         subtitle: 'Kullanıcı Adı',
//                       ),
//                       const SizedBox(
//                         height: 55,
//                       ),
//                       CustomMainButton(
//                         edgeInsets: const EdgeInsets.symmetric(horizontal: 30),
//                         onTap: () async {
//                           //TODO
//                           //auth methods icine aktarılacak
//                           await FirebaseAuth.instance.signOut();

//                           PersistentNavBarNavigator.pushNewScreen(
//                             context,
//                             screen: const OnboardingScreen(),
//                             withNavBar: false,
//                           );
//                         },
//                         text: 'Şifreyi güncelle',
//                       ),
//                       CustomMainButton(
//                         edgeInsets: const EdgeInsets.symmetric(horizontal: 30),
//                         onTap: () async {
//                           //TODO
//                           //auth methods icine aktarılacak
//                           await FirebaseAuth.instance.signOut();

//                           PersistentNavBarNavigator.pushNewScreen(
//                             context,
//                             screen: const OnboardingScreen(),
//                             withNavBar: false,
//                           );
//                         },
//                         text: 'Hesaptan çıkış yap',
//                       ),
//                       IconButton(
//                           onPressed: () {
//                             PersistentNavBarNavigator.pushNewScreen(context,
//                                 screen: const MyWidgetScreen());
//                           },
//                           icon: const Icon(Icons.abc))
//                     ],
//                   );
//                 } else if (snapshot.hasError) {
//                   return Text('Hata: ${snapshot.error}');
//                 }
//                 return const LoadingIndicator();
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
