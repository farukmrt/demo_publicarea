import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/widgets/custom_textfield.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';

class UpdatePasswordScreen extends StatefulWidget {
  static String routeName = '/updatePassword';
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController againNewPassController = TextEditingController();

  bool changing = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    currentPassController.addListener(_newPasswordControllerListener);
    newPassController.addListener(_newPasswordControllerListener);
    againNewPassController.addListener(_newPasswordControllerListener);

    _newPasswordControllerListener();
  }

  void _newPasswordControllerListener() {
    String currentPassValue = currentPassController.text;
    String newPassValue = newPassController.text;
    String againNewPassValue = againNewPassController.text;
    print('eski şifre: $currentPassValue');
    print('Yeni şifre: $newPassValue');
    print('Yeni şifre tekrar: $newPassValue');

    setState(() {
      if (currentPassValue.length > 5 &&
          newPassValue == againNewPassValue &&
          newPassValue.length > 5) {
        print('$changing');
        changing = true;
      } else {
        print('$changing');
        changing = false;
      }
    });
  }

  @override
  void dispose() {
    currentPassController.removeListener(_newPasswordControllerListener);
    newPassController.removeListener(_newPasswordControllerListener);
    againNewPassController.removeListener(_newPasswordControllerListener);

    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    final size = MediaQuery.of(context).size;
    //final size = MediaQuery.of(context).size;

    var trnslt = AppLocalizations.of(context)!;

    return Stack(
      children: [
        Container(
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
                            textName: 'currentPass',
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
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            textName: 'updateNewPass',
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
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            textName: 'updateAgainPass',
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
                              return null;
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
                              if (_formKey.currentState!.validate() &&
                                  changing) {
                                setState(() {
                                  isLoading = true;
                                });
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
                                  setState(() {
                                    isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          trnslt.lcod_lbl_wrong_password_long),
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
        ),
        if (isLoading)
          Center(
            child: LoadingAnimationWidget.dotsTriangle(
                color: primaryColor, size: size.width / 3),
          ),
      ],
    );
  }
}
