import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/providers/photo_provider.dart';
import 'package:demo_publicarea/widgets/custom_textfield.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/screens/settings/data_create.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ProfileSettingsScreen extends StatefulWidget {
  static String routeName = '/profilesettings';
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  TextEditingController currentValueController = TextEditingController();
  TextEditingController newValueController = TextEditingController();
  TextEditingController newValueAgainController = TextEditingController();
  File? selectedImage;
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    PhotoProvider photoProvider = Provider.of<PhotoProvider>(context);
    final size = MediaQuery.of(context).size;
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
              title: userProvider.user.email,
              subtitle: 'E-Mail',
              leading: const Icon(
                Icons.email_outlined,
                size: 40,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.change_circle_outlined),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        child: Container(
                          height: size.height * 0.5,
                          width: size.width * 0.8,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextField(
                                  //readOnly: true,
                                  controller: currentValueController,
                                  hintText: userProvider.user.email,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  controller: newValueController,
                                  labelText: 'Yeni e-mail adresini girin',
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  controller: newValueAgainController,
                                  labelText: 'Şifrenizi girin',
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                CustomMainButton(
                                  onTap: () async {
                                    String currentPassword =
                                        newValueAgainController.text;
                                    String currentEmail =
                                        currentValueController.text;
                                    String newEmail = newValueController.text;

                                    bool isPasswordCorrect = await userProvider
                                        .verifyPassword(currentPassword);

                                    if (isPasswordCorrect) {
                                      await userProvider.updateEmail(
                                          currentPassword, newEmail);
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'E-mail adresiniz güncellendi...'),
                                          duration: Duration(seconds: 5),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Geçerli şifre yanlış.'),
                                          duration: Duration(seconds: 5),
                                        ),
                                      );
                                    }
                                  },
                                  text: 'Güncelle',
                                  icon:
                                      CupertinoIcons.arrow_2_circlepath_circle,
                                  edgeInsets: const EdgeInsets.symmetric(
                                      horizontal: 23),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            CustomListItem(
              title: userProvider.user.username,
              subtitle: 'Kullanıcı Adı',
              leading: const Icon(
                Icons.account_circle_outlined,
                size: 40,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.change_circle_outlined),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        child: Container(
                          height: size.height * 0.5,
                          width: size.width * 0.8,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextField(
                                  readOnly: true,
                                  controller: currentValueController,
                                  hintText: userProvider.user.username,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  controller: newValueController,
                                  labelText: 'Yeni kullanıcı adını girin',
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  controller: newValueAgainController,
                                  labelText: 'Şifrenizi girin',
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                CustomMainButton(
                                  onTap: () async {
                                    String currentPassword =
                                        newValueAgainController.text;
                                    //String currentEmail = currentValueController.text;
                                    String newUsername =
                                        newValueController.text;
                                    // bool isPasswordCorrect = await userProvider
                                    //     .verifyPassword(currentPassword);
                                    // if (isPasswordCorrect) {
                                    await userProvider.updateUsername(
                                        context,
                                        userProvider.user.uid,
                                        newUsername,
                                        currentPassword);
                                    Navigator.pop(context);
// setState(() {
//     userProvider.user.email = newEmail;
// //   });
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                         content: Text(
//                                             'Kullanıcı adınız güncellendi...'),
//                                         duration: Duration(seconds: 5),
//                                       ),
//                                     );
                                    // } else {
                                    //   ScaffoldMessenger.of(context)
                                    //       .showSnackBar(
                                    //     const SnackBar(
                                    //       content:
                                    //           Text('Geçerli şifre yanlış.'),
                                    //       duration: Duration(seconds: 5),
                                    //     ),
                                    //   );
                                    // }
                                  },
                                  text: 'Güncelle',
                                  icon:
                                      CupertinoIcons.arrow_2_circlepath_circle,
                                  edgeInsets: const EdgeInsets.symmetric(
                                      horizontal: 23),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            CustomListItem(
              title: userProvider.user.phoneNumber,
              subtitle: 'Telefon Numarası',
              leading: const Icon(
                Icons.call,
                size: 40,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.change_circle_outlined),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.white,
                        // shadowColor: mainBackgroundColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(90),
                          ),
                        ),
                        child: Container(
                          height: size.height * 0.5,
                          width: size.width * 0.8,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextField(
                                  readOnly: true,
                                  controller: currentValueController,
                                  hintText: userProvider.user.phoneNumber,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  controller: newValueController,
                                  labelText: 'Telefon',
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  controller: newValueAgainController,
                                  labelText: 'Şifrenizi girin',
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                CustomMainButton(
                                  onTap: () async {
                                    String currentPassword =
                                        newValueAgainController.text;
                                    String newPhoneNumber =
                                        newValueController.text;
                                    await userProvider.updatePhoneNumber(
                                        userProvider.user.uid,
                                        newPhoneNumber,
                                        currentPassword);
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Telefon numaranız güncellendi...'),
                                        duration: Duration(seconds: 5),
                                      ),
                                    );
                                  },
                                  text: 'Güncelle',
                                  icon:
                                      CupertinoIcons.arrow_2_circlepath_circle,
                                  edgeInsets: const EdgeInsets.symmetric(
                                      horizontal: 23),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            CustomListItem(
              leading: const Icon(
                Icons.apartment_outlined,
                size: 40,
              ),
              title: userProvider.user.building,
              subtitle: 'Bina',
            ),
            const SizedBox(
              height: 55,
            ),
            CustomMainButton(
              edgeInsets: const EdgeInsets.symmetric(horizontal: 30),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: Container(
                        height: size.height * 0.6,
                        width: size.width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTextField(
                                controller: currentValueController,
                                labelText: 'Güncel şifrenizi giriniz',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                controller: newValueController,
                                labelText: 'Yeni şifrenizi oluşturun',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                controller: newValueAgainController,
                                labelText: 'Yeni şifrenizi tekrar girin',
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              CustomMainButton(
                                onTap: () async {
                                  String currentPassword =
                                      currentValueController.text;
                                  String newPassword = newValueController.text;
                                  String newPasswordAgain =
                                      newValueAgainController.text;

                                  if (newPassword == newPasswordAgain) {
                                    await userProvider.updatePassword(
                                        currentPassword, newPassword);
                                    Navigator.pop(
                                        context); // Şifreler uyumluysa ekranı kapat
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Şifreler uyuşmuyor, kontrol ederek tekrar girin..'),
                                        duration: Duration(seconds: 5),
                                      ),
                                    );
                                  }
                                },
                                text: 'Güncelle',
                                icon: CupertinoIcons.arrow_2_circlepath_circle,
                                edgeInsets:
                                    EdgeInsets.symmetric(horizontal: 23),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              text: 'Şifreyi güncelle',
            ),
            CustomMainButton(
              edgeInsets: const EdgeInsets.symmetric(horizontal: 20),
              onTap: () async {
                await userProvider.signOut(context);
              },
              text: 'Hesaptan çıkış yap',
            ),
            // IconButton(
            //     onPressed: () {
            //       PersistentNavBarNavigator.pushNewScreen(context,
            //           screen: const MyWidgetScreen());
            //     },
            //     icon: const Icon(Icons.abc))
          ],
        ),
      ),
    );
  }
}
