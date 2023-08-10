import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/widgets/custom_textfield.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';

class UpdatePhonenumberScreen extends StatefulWidget {
  static String routeName = '/updatePhoneNumber';
  const UpdatePhonenumberScreen({Key? key}) : super(key: key);

  @override
  _UpdatePhonenumberScreenState createState() =>
      _UpdatePhonenumberScreenState();
}

class _UpdatePhonenumberScreenState extends State<UpdatePhonenumberScreen> {
  // bool isPhoneNumberFull() {
  //   return newPhoneNumberController.text.startsWith('0') &&
  //       newPhoneNumberController.text.length == 11 &&
  //       phoneNumberPassController.text.length > 5;
  // }

  bool changing = false;
  bool newPhoneNumberColor = false;
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
    String newPhonenumberValue = newPhoneNumberController.text;
    String userPassValue = phoneNumberPassController.text;
    print('Yeni telefon numarası: $newPhonenumberValue');
    print('Yeni şifre: $userPassValue');

    setState(() {
      // changing;

      if (newPhonenumberValue.startsWith('05') &&
          newPhonenumberValue.length == 11 &&
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
    // if (newPhoneNumberController.text.length == 11 &&
    //     newPhoneNumberController.text.startsWith('05')) {
    //   newPhoneNumberColor = false;
    // }
    // // if (newPhonenumberValue == null)
    // else {
    //   newPhoneNumberColor = true;
    // }
  }

  final _formKey = GlobalKey<FormState>();

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
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextField(
                        readOnly: true,
                        controller: currentValueController,
                        hintText: userProvider.currentUser.phoneNumber,
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      CustomTextField(
                        controller: newPhoneNumberController,
                        hintText: '05xx',
                        labelText: trnslt.lcod_lbl_phone_text,
                        keyboardType: TextInputType.phone,
                        maxLength: 11,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.characters.length != 11 ||
                              !value.startsWith('05')) {
                            return trnslt.lcod_lbl_control_phone_number;
                          }
                          return null; // Herhangi bir hata yoksa null döndürün.
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: phoneNumberPassController,
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
                          setState(() {
                            changing;
                          });
                          if (_formKey.currentState!.validate() && changing) {
                            String currentPasswordPhone =
                                phoneNumberPassController.text;
                            String newPhoneNumber =
                                newPhoneNumberController.text;

                            bool isPasswordCorrectPhone = await userProvider
                                .verifyPassword(currentPasswordPhone);

                            if (isPasswordCorrectPhone) {
                              await userProvider.updatePhoneNumber(
                                  userProvider.currentUser.uid,
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
