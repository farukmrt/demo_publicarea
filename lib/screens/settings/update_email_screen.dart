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

class UpdateEmailScreen extends StatefulWidget {
  static String routeName = '/updateEmail';
  const UpdateEmailScreen({Key? key}) : super(key: key);

  @override
  _UpdateEmailScreenState createState() => _UpdateEmailScreenState();
}

class _UpdateEmailScreenState extends State<UpdateEmailScreen> {
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
          newMailValue.length > 9 &&
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

  final _formKey = GlobalKey<FormState>();

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
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextField(
                        readOnly: true,
                        controller: currentValueController,
                        hintText: userProvider.currentUser.email,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: newMailController,
                        labelText: trnslt.lcod_lbl_new_email,
                        maxLength: 33,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.endsWith('.com') ||
                              !value.contains('@') ||
                              value.characters.length < 9) {
                            return trnslt.lcod_lbl_control_email;
                          }
                          return null; // Herhangi bir hata yoksa null döndürün.
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: mailPassController,
                        labelText: trnslt.lcod_lbl_password_2,
                        obscore: true,
                        maxLength: 20,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.characters.length < 6) {
                            return trnslt.lcod_lbl_control_password;
                          }
                          return null; // Herhangi bir hata yoksa null döndürün.
                        },
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
                          if (_formKey.currentState!.validate() && changing) {
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
