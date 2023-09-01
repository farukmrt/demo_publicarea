import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';
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
  bool changing = false;
  bool isLoading = false;

  TextEditingController currentValueController = TextEditingController();
  TextEditingController mailPassController = TextEditingController();
  TextEditingController newMailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    newMailController.addListener(_newMailControllerListener);
    mailPassController.addListener(_newMailControllerListener);
    _newMailControllerListener();
  }

  void _newMailControllerListener() {
    String newMailValue = newMailController.text;
    String mailPassValue = mailPassController.text;
    print('Yeni e-posta değeri: $newMailValue');
    print('Yeni şifre değeri: $mailPassValue');

    setState(() {
      if (newMailValue.endsWith('.com') &&
          newMailValue.contains('@') &&
          newMailValue.length > 9 &&
          mailPassValue.length > 5) {
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
    newMailController.removeListener(_newMailControllerListener);
    mailPassController.removeListener(_newMailControllerListener);
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var trnslt = AppLocalizations.of(context)!;
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Stack(
      children: [
        Container(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextField(
                            textName: 'currentEmail',
                            readOnly: true,
                            controller: currentValueController,
                            hintText: userProvider.currentUser.email,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            textName: 'updateEmail',
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
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            textName: 'updateEmailPass',
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
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomMainButton(
                            onTap: () async {
                              if (_formKey.currentState!.validate() &&
                                  changing) {
                                setState(() {
                                  isLoading = true;
                                });
                                String currentPassword =
                                    mailPassController.text;
                                //String currentEmail = currentValueController.text;
                                String newEmail = newMailController.text;

                                bool isPasswordCorrect = await userProvider
                                    .verifyPassword(currentPassword);

                                if (isPasswordCorrect) {
                                  await userProvider.updateEmail(
                                      currentPassword, newEmail);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text(trnslt.lcod_lbl_updated_email),
                                      duration: Duration(seconds: 5),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
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
                            color: changing
                                ? primaryColor
                                : primaryColor.withOpacity(0.5),
                            text: trnslt.lcod_lbl_update,
                            icon: CupertinoIcons.arrow_2_circlepath_circle,
                            edgeInsets:
                                const EdgeInsets.symmetric(horizontal: 23),
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
            child: LoadingAnimationWidget.hexagonDots(
                color: primaryColor, size: size.width / 3),
          ),
      ],
    );
  }
}
