import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdatePasswordScreen extends StatefulWidget {
  static String routeName = '/updatePassword';
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  // bool isPasswordFull() {
  //   return currentPassController.text.length > 5 &&
  //       newPassController.text.length > 5 &&
  //       newPassController == againNewPassController;
  // }

  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController againNewPassController = TextEditingController();

  bool changing = false;
  @override
  void initState() {
    super.initState();
    currentPassController.addListener(_newPasswordControllerListener);
    newPassController.addListener(_newPasswordControllerListener);
    againNewPassController.addListener(_newPasswordControllerListener);

    // _changingStreamController.stream;
    // _changingStreamController;

    _newPasswordControllerListener();
    //_changingStreamController;
    // changing;
    // setState(() {
    //   changing;
    // });
  }

  void _newPasswordControllerListener() {
    String currentPassValue = currentPassController.text;
    String newPassValue = newPassController.text;
    String againNewPassValue = againNewPassController.text;
    print('eski şifre: $currentPassValue');
    print('Yeni şifre: $newPassValue');
    print('Yeni şifre tekrar: $newPassValue');

    setState(() {
      // changing;
      if (currentPassValue.length > 5 &&
          newPassValue == againNewPassValue &&
          newPassValue.length > 5) {
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
    currentPassController.removeListener(_newPasswordControllerListener);
    newPassController.removeListener(_newPasswordControllerListener);
    againNewPassController.removeListener(_newPasswordControllerListener);
    // _changingStreamController.close();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

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
              trnslt.lcod_lbl_update_password,
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
                        controller: currentPassController,
                        labelText: trnslt.lcod_lbl_current_password,
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
                        height: 20,
                      ),
                      CustomTextField(
                        controller: newPassController,
                        labelText: trnslt.lcod_lbl_new_password,
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
                        height: 20,
                      ),
                      CustomTextField(
                        controller: againNewPassController,
                        labelText: trnslt.lcod_lbl_new_password_again,
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
                            String currentPassword = currentPassController.text;
                            String newPassword = newPassController.text;
                            String newPasswordAgain =
                                againNewPassController.text;

                            if (newPassword == newPasswordAgain) {
                              await userProvider.updatePassword(
                                  currentPassword, newPassword);
                              Navigator.pop(
                                  context); // Şifreler uyumluysa ekranı kapat
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text(trnslt.lcod_lbl_wrong_password_long),
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
                        edgeInsets: EdgeInsets.symmetric(horizontal: 23),
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
