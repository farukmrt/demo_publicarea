import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomUpdatePhonenumber extends StatefulWidget {
  static String routeName = '/updatePhoneNumber';
  const CustomUpdatePhonenumber({Key? key}) : super(key: key);

  @override
  _CustomUpdatePhonenumberState createState() =>
      _CustomUpdatePhonenumberState();
}

class _CustomUpdatePhonenumberState extends State<CustomUpdatePhonenumber> {
  // bool isPhoneNumberFull() {
  //   return newPhoneNumberController.text.startsWith('0') &&
  //       newPhoneNumberController.text.length == 11 &&
  //       phoneNumberPassController.text.length > 5;
  // }

  bool changing = false;
  TextEditingController currentValueController = TextEditingController();
  TextEditingController phoneNumberPassController = TextEditingController();
  TextEditingController newPhoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    newPhoneNumberController.addListener(_newPhoneNumberControllerListener);
    phoneNumberPassController.addListener(_newPhoneNumberControllerListener);
    // _changingStreamController.stream;
    // _changingStreamController;

    _newPhoneNumberControllerListener();
    //_changingStreamController;
    // changing;
    // setState(() {
    //   changing;
    // });
  }

  void _newPhoneNumberControllerListener() {
    String newUsernameValue = newPhoneNumberController.text;
    String userPassValue = phoneNumberPassController.text;
    print('Yeni telefon numarası: $newUsernameValue');
    print('Yeni şifre: $userPassValue');

    setState(() {
      // changing;
      if (newUsernameValue.startsWith('05') &&
          newUsernameValue.length == 11 &&
          userPassValue.length > 5) {
        print('$changing');
        changing = true;
        // _changingStreamController.add(true);

        //sendButton = primaryColor;
      } else {
        print('$changing');
        changing = false;
        //_changingStreamController.add(false);
        //sendButton = primaryColor.withOpacity(0.5);
      }
      //_changingStreamController.add(changing);
    });
  }

  @override
  void dispose() {
    // State nesnesi yok edildiğinde, dinleyicileri kaldırın
    newPhoneNumberController.removeListener(_newPhoneNumberControllerListener);
    phoneNumberPassController.removeListener(_newPhoneNumberControllerListener);
    // _changingStreamController.close();
    super.dispose();
  }

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
            backgroundColor: primaryColor,
            title: Text(
              trnslt.lcod_lbl_update_phone_number,
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
                        hintText: userProvider.user.phoneNumber,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: newPhoneNumberController,
                        hintText: '05xx',
                        labelText: trnslt.lcod_lbl_phone_text,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: phoneNumberPassController,
                        labelText: trnslt.lcod_lbl_password_2,
                        obscore: true,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomMainButton(
                        onTap: () async {
                          setState(() {
                            changing;
                          });
                          if (changing) {
                            String currentPasswordPhone =
                                phoneNumberPassController.text;
                            String newPhoneNumber =
                                newPhoneNumberController.text;

                            bool isPasswordCorrectPhone = await userProvider
                                .verifyPassword(currentPasswordPhone);

                            if (isPasswordCorrectPhone) {
                              await userProvider.updatePhoneNumber(
                                  userProvider.user.uid,
                                  newPhoneNumber,
                                  currentPasswordPhone);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      trnslt.lcod_lbl_updated_phone_number),
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
