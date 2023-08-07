import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/widgets/custom_textfield.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';

class CustomUpdateEmail extends StatefulWidget {
  static String routeName = '/updateEmail';
  const CustomUpdateEmail({Key? key}) : super(key: key);

  @override
  _CustomUpdateEmailState createState() => _CustomUpdateEmailState();
}

class _CustomUpdateEmailState extends State<CustomUpdateEmail> {
  //StreamController<bool> _changingStreamController = StreamController<bool>();

  bool changing = false;
  Color sendButton = mainBackgroundColor; // primaryColor.withOpacity(0.5);

  //newMailController için dinleyici fonksiyonu

  // bool buttonColorr() {
  //   if (newMailValue.endsWith('.com') &&
  //       newMailValue.contains('@') &&
  //       mailPassValue.length >= 6) {
  //     setState(() {
  //       print('primary');
  //       sendButton = primaryColor;
  //     });
  //     return true;
  //   } else {
  //     setState(() {
  //       print('opacity');
  //       sendButton = primaryColor.withOpacity(0.5);
  //     });
  //     return false;
  //   }
  // }
  // @override
  // void _newMailControllerListener() {
  //   String newMailValue = newMailController.text;
  //   String mailPassValue = mailPassController.text;
  //   if (newMailValue.endsWith('.com') &&
  //       newMailValue.contains('@') &&
  //       mailPassValue.length >= 6) {
  //     setState(() {
  //       changing = true;
  //     });
  //   } else {
  //     setState(() {
  //       changing = false;
  //     });
  //   }
  // }

  // bool isMailFull() {
  //   return newMailController.text.endsWith('.com') &&
  //       newMailController.text.contains('@') &&
  //       mailPassController.text.length > 5;
  // }

  TextEditingController currentValueController = TextEditingController();
  TextEditingController mailPassController = TextEditingController();
  TextEditingController newMailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    newMailController.addListener(_newMailControllerListener);
    mailPassController.addListener(_newMailControllerListener);
    _newMailControllerListener();
    //_changingStreamController;
    // changing;
    // setState(() {
    //   changing;
    // });
  }

  void _newMailControllerListener() {
    String newMailValue = newMailController.text;
    String mailPassValue = mailPassController.text;
    print('Yeni e-posta değeri: $newMailValue');
    print('Yeni şifre değeri: $mailPassValue');

    setState(() {
      // changing;
      if (newMailValue.endsWith('.com') &&
          newMailValue.contains('@') &&
          mailPassValue.length > 5) {
        print('$changing');
        changing = true;
        //_changingStreamController.add(true);

        //sendButton = primaryColor;
      } else {
        print('$changing');
        changing = false;
        // _changingStreamController.add(false);
        //sendButton = primaryColor.withOpacity(0.5);
      }
    });
  }

  // void _refreshcontroller(){
  //   _changingStreamController.;
  // }
  @override
  void dispose() {
    // State nesnesi yok edildiğinde, dinleyicileri kaldırın
    newMailController.removeListener(_newMailControllerListener);
    mailPassController.removeListener(_newMailControllerListener);
    super.dispose();
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var trnslt = AppLocalizations.of(context)!;
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      color: primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text(
              trnslt.lcod_lbl_update_email,
              style: TextStyle(color: mainBackgroundColor),
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                height: size.height * 0.5,
                width: size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextField(
                        readOnly: true,
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
                        obscore: true,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomMainButton(
                        onTap: () async {
                          // setState(() {
                          //   //buradaki setstate işlemi sayesinde veri güncelleniyor ancak tıklama yapılması şart yoksa güncellemiyor
                          //   changing;
                          // });
                          if (changing) {
                            String currentPassword = mailPassController.text;
                            String currentEmail = currentValueController.text;
                            String newEmail = newMailController.text;

                            bool isPasswordCorrect = await userProvider
                                .verifyPassword(currentPassword);

                            if (isPasswordCorrect) {
                              // (changing) => setState(
                              //     () => this.changing = changing!);

                              await userProvider.updateEmail(
                                  currentPassword, newEmail);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(trnslt.lcod_lbl_updated_email),
                                  duration: Duration(seconds: 5),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(trnslt.lcod_lbl_wrong_password),
                                  duration: Duration(seconds: 5),
                                ),
                              );
                            }
                          }
                        },
                        color: changing
                            ? primaryColor
                            : primaryColor.withOpacity(0.5),
                        //color_dis: primaryColor.withOpacity(0.5),
                        text: trnslt.lcod_lbl_update,
                        icon: CupertinoIcons.arrow_2_circlepath_circle,
                        edgeInsets: const EdgeInsets.symmetric(horizontal: 23),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
