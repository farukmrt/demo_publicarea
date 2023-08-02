import 'dart:io';

import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/main.dart';
import 'package:demo_publicarea/utils/languages/lang.dart';
import 'package:demo_publicarea/utils/languages/language.dart';
import 'package:demo_publicarea/utils/utils.dart';
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
  // TextEditingController newValueController = TextEditingController();
  // TextEditingController newValueAgainController = TextEditingController();

  TextEditingController mailPassController = TextEditingController();
  TextEditingController newMailController = TextEditingController();

  TextEditingController usernamePassController = TextEditingController();
  TextEditingController newUsernameController = TextEditingController();

  TextEditingController phoneNumberPassController = TextEditingController();
  TextEditingController newPhoneNumberController = TextEditingController();

  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController againNewPassController = TextEditingController();

  File? selectedImage;
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    PhotoProvider photoProvider = Provider.of<PhotoProvider>(context);
    final size = MediaQuery.of(context).size;

    var trnslt = AppLocalizations.of(context)!;
    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(trnslt.lcod_lbl_profile_screen),
          ),
          body: Column(
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
                                Text(trnslt.lcod_lbl_update_profile_screen),
                                ElevatedButton(
                                  onPressed: () async {
                                    await photoProvider.takeAPhoto();

                                    setState(() {
                                      selectedImage =
                                          photoProvider.selectedImage;
                                    });
                                    imageUrl = await photoProvider.sendPP(
                                        selectedImage!,
                                        userProvider.user.username);
                                    await userProvider.updatePP(
                                        userProvider.user.uid, imageUrl!);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    trnslt.lcod_lbl_shooting,
                                    style:
                                        TextStyle(color: mainBackgroundColor),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () async {
                                    // Galeri seçeneği için işlemler burada yapılacak
                                    await photoProvider.getAPhoto();
                                    // Seçim yapıldığında, 'galeri' değeri ile iletişim kutusunu kapatacak
                                    setState(() {
                                      selectedImage =
                                          photoProvider.selectedImage;
                                    });
                                    imageUrl = await photoProvider.sendPP(
                                        selectedImage!,
                                        userProvider.user.username);
                                    await userProvider.updatePP(
                                        userProvider.user.uid, imageUrl!);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    trnslt.lcod_lbl_upload_gallery,
                                    style:
                                        TextStyle(color: mainBackgroundColor),
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
                subtitle: trnslt.lcod_lbl_name_surname,
                title: '${userProvider.user.name} ${userProvider.user.surname}',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomListItem(
                title: userProvider.user.email,
                subtitle: trnslt.lcod_lbl_email_text,
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
                              Radius.circular(25),
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
                                    controller: newMailController,
                                    labelText: trnslt.lcod_lbl_new_email,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextField(
                                    controller: mailPassController,
                                    labelText: trnslt.lcod_lbl_password_2,
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  CustomMainButton(
                                    onTap: () async {
                                      String currentPassword =
                                          mailPassController.text;
                                      String currentEmail =
                                          currentValueController.text;
                                      String newEmail = newMailController.text;

                                      bool isPasswordCorrect =
                                          await userProvider
                                              .verifyPassword(currentPassword);

                                      if (isPasswordCorrect) {
                                        await userProvider.updateEmail(
                                            currentPassword, newEmail);
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                trnslt.lcod_lbl_updated_email),
                                            duration: Duration(seconds: 5),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                trnslt.lcod_lbl_wrong_password),
                                            duration: Duration(seconds: 5),
                                          ),
                                        );
                                      }
                                    },
                                    text: trnslt.lcod_lbl_update,
                                    icon: CupertinoIcons
                                        .arrow_2_circlepath_circle,
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
              const SizedBox(
                height: 10,
              ),
              CustomListItem(
                title: userProvider.user.username,
                subtitle: trnslt.lcod_lbl_username,
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
                              Radius.circular(25),
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
                                    controller: newUsernameController,
                                    labelText: trnslt.lcod_lbl_new_username,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextField(
                                    controller: usernamePassController,
                                    labelText: trnslt.lcod_lbl_password_2,
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  CustomMainButton(
                                    onTap: () async {
                                      String currentPasswordUsername =
                                          usernamePassController.text;
                                      String newUsername =
                                          newUsernameController.text;

                                      bool isPasswordCorrectUsername =
                                          await userProvider.verifyPassword(
                                              currentPasswordUsername);

                                      if (isPasswordCorrectUsername) {
                                        await userProvider.updateUsername(
                                            context,
                                            userProvider.user.uid,
                                            newUsername,
                                            currentPasswordUsername);
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              trnslt.lcod_lbl_updated_username),
                                          duration: Duration(seconds: 5),
                                        ));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              trnslt.lcod_lbl_wrong_password),
                                          duration: Duration(seconds: 5),
                                        ));
                                      }
                                    },
                                    text: trnslt.lcod_lbl_update,
                                    icon: CupertinoIcons
                                        .arrow_2_circlepath_circle,
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
              const SizedBox(
                height: 10,
              ),
              CustomListItem(
                title: userProvider.user.phoneNumber,
                subtitle: trnslt.lcod_lbl_phone_number,
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
                              Radius.circular(25),
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
                                    controller: newPhoneNumberController,
                                    labelText: trnslt.lcod_lbl_phone_text,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextField(
                                    controller: phoneNumberPassController,
                                    labelText: trnslt.lcod_lbl_password_2,
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  CustomMainButton(
                                    onTap: () async {
                                      String currentPasswordPhone =
                                          phoneNumberPassController.text;
                                      String newPhoneNumber =
                                          newPhoneNumberController.text;

                                      bool isPasswordCorrectPhone =
                                          await userProvider.verifyPassword(
                                              currentPasswordPhone);

                                      if (isPasswordCorrectPhone) {
                                        await userProvider.updatePhoneNumber(
                                            userProvider.user.uid,
                                            newPhoneNumber,
                                            currentPasswordPhone);
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(trnslt
                                                .lcod_lbl_updated_phone_number),
                                            duration: Duration(seconds: 5),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                trnslt.lcod_lbl_wrong_password),
                                            duration: Duration(seconds: 5),
                                          ),
                                        );
                                      }
                                    },
                                    text: trnslt.lcod_lbl_update,
                                    icon: CupertinoIcons
                                        .arrow_2_circlepath_circle,
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
              const SizedBox(
                height: 10,
              ),
              CustomListItem(
                leading: const Icon(
                  Icons.apartment_outlined,
                  size: 40,
                ),
                title: userProvider.user.building,
                subtitle: trnslt.lcod_lbl_building,
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

              CustomMainButton(
                edgeInsets: const EdgeInsets.symmetric(horizontal: 30),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
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
                                  controller: currentPassController,
                                  labelText: trnslt.lcod_lbl_current_password,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomTextField(
                                  controller: newPassController,
                                  labelText: trnslt.lcod_lbl_new_password,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomTextField(
                                  controller: againNewPassController,
                                  labelText: trnslt.lcod_lbl_new_password_again,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                CustomMainButton(
                                  onTap: () async {
                                    String currentPassword =
                                        currentPassController.text;
                                    String newPassword = newPassController.text;
                                    String newPasswordAgain =
                                        againNewPassController.text;

                                    if (newPassword == newPasswordAgain) {
                                      await userProvider.updatePassword(
                                          currentPassword, newPassword);
                                      Navigator.pop(
                                          context); // Şifreler uyumluysa ekranı kapat
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(trnslt
                                              .lcod_lbl_wrong_password_long),
                                          duration: Duration(seconds: 5),
                                        ),
                                      );
                                    }
                                  },
                                  text: trnslt.lcod_lbl_update,
                                  icon:
                                      CupertinoIcons.arrow_2_circlepath_circle,
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
                text: trnslt.lcod_lbl_update_password,
              ),
              CustomMainButton(
                edgeInsets: const EdgeInsets.symmetric(horizontal: 20),
                onTap: () async {
                  await userProvider.signOut(context);
                },
                text: trnslt.lcod_lbl_logout,
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
      ),
    );
  }
}
