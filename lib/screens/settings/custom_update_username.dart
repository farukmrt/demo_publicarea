import 'dart:async';

import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_checkbox.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class CustomUpdateUsername extends StatefulWidget {
  static String routeName = '/updateUsername';
  const CustomUpdateUsername({Key? key}) : super(key: key);

  @override
  _CustomUpdateUsernameState createState() => _CustomUpdateUsernameState();
}

class _CustomUpdateUsernameState extends State<CustomUpdateUsername> {
  // final _changingStreamController = StreamController<bool>.broadcast();
  // Stream<bool> get changingStream => _changingStreamController.stream;

  bool changing = false;
  bool isUsernameAvailable = false;
  TextEditingController currentValueController = TextEditingController();
  TextEditingController usernamePassController = TextEditingController();
  TextEditingController newUsernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    newUsernameController.addListener(_newUsernameControllerListener);
    usernamePassController.addListener(_newUsernameControllerListener);
    // _changingStreamController.stream;
    // _changingStreamController;

    _newUsernameControllerListener();
    //_changingStreamController;
    // changing;
    // setState(() {
    //   changing;
    // });
  }

  void _newUsernameControllerListener() {
    String newUsernameValue = newUsernameController.text;
    String userPassValue = usernamePassController.text;
    print('Yeni kullanıcı adı: $newUsernameValue');
    print('Yeni şifre: $userPassValue');

    setState(() {
      // changing;
      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);
      userProvider.checkUsername(context, newUsernameValue).then((isAvailable) {
        setState(() {
          isUsernameAvailable = !isAvailable;
        });
      });

      if (newUsernameValue.length > 3 && userPassValue.length > 5) {
        print('$changing');
        changing = true;

        // _changingStreamController.add(true);

        //sendButton = primaryColor;
      } else {
        print('$changing');
        changing = false;
        isUsernameAvailable = false;
        //_changingStreamController.add(false);
        //sendButton = primaryColor.withOpacity(0.5);
      }
      //_changingStreamController.add(changing);
    });
  }

  //didUpdateWidget(changing);
  @override
  void dispose() {
    // State nesnesi yok edildiğinde, dinleyicileri kaldırın
    newUsernameController.removeListener(_newUsernameControllerListener);
    usernamePassController.removeListener(_newUsernameControllerListener);
    // _changingStreamController.close();
    super.dispose();
  }

  // bool isUsernameFull() {
  //   return newUsernameController.text.isNotEmpty &&
  //       usernamePassController.text.length > 5;
  // }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   changing;
    // });
    UserProvider userProvider = Provider.of<UserProvider>(context);
    final size = MediaQuery.of(context).size;

    var trnslt = AppLocalizations.of(context)!;

    return Container(
      color: primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text(
              trnslt.lcod_lbl_update_username,
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
                        obscore: true,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      StatefulBuilder(builder: (context, setState) {
                        return CustomMainButton(
                          onTap: () async {
                            setState(() {
                              changing;
                              isUsernameAvailable;
                            });
                            if (changing && isUsernameAvailable) {
                              String currentPasswordUsername =
                                  usernamePassController.text;
                              String newUsername = newUsernameController.text;

                              bool isPasswordCorrectUsername =
                                  await userProvider
                                      .verifyPassword(currentPasswordUsername);

                              if (isPasswordCorrectUsername) {
                                await userProvider.updateUsername(
                                    context,
                                    userProvider.user.uid,
                                    newUsername,
                                    currentPasswordUsername);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text(trnslt.lcod_lbl_updated_username),
                                    duration: Duration(seconds: 5),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text(trnslt.lcod_lbl_wrong_password),
                                    duration: Duration(seconds: 5),
                                  ),
                                );
                              }
                            }
                          },
                          color: changing && isUsernameAvailable
                              ? primaryColor
                              : primaryColor.withOpacity(0.5),
                          text: trnslt.lcod_lbl_update,
                          icon: CupertinoIcons.arrow_2_circlepath_circle,
                          edgeInsets:
                              const EdgeInsets.symmetric(horizontal: 23),
                        );
                      }),
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
