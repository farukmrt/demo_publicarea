import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/widgets/custom_textfield.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';

class UpdateUsernameScreen extends StatefulWidget {
  static String routeName = '/updateUsername';
  const UpdateUsernameScreen({Key? key}) : super(key: key);

  @override
  _UpdateUsernameScreenState createState() => _UpdateUsernameScreenState();
}

class _UpdateUsernameScreenState extends State<UpdateUsernameScreen> {
  bool changing = false;
  bool isLoading = false;
  bool isUsernameAvailable = false;
  TextEditingController currentValueController = TextEditingController();
  TextEditingController usernamePassController = TextEditingController();
  TextEditingController newUsernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    newUsernameController.addListener(_newUsernameControllerListener);
    usernamePassController.addListener(_newUsernameControllerListener);
    _newUsernameControllerListener();
  }

  void _newUsernameControllerListener() {
    String newUsernameValue = newUsernameController.text;
    String userPassValue = usernamePassController.text;
    print('Yeni kullanıcı adı: $newUsernameValue');
    print('Yeni şifre: $userPassValue');

    setState(() {
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
      } else {
        print('$changing');
        changing = false;
        isUsernameAvailable = false;
      }
    });
  }

  @override
  void dispose() {
    newUsernameController.removeListener(_newUsernameControllerListener);
    usernamePassController.removeListener(_newUsernameControllerListener);
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    final size = MediaQuery.of(context).size;
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
                  trnslt.lcod_lbl_update_username,
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
                            textName: 'currentUsername',
                            readOnly: true,
                            controller: currentValueController,
                            hintText: userProvider.currentUser.username,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            textName: 'updateUsername',
                            controller: newUsernameController,
                            labelText: trnslt.lcod_lbl_new_username,
                            maxLength: 20,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.characters.length < 4) {
                                return trnslt.lcod_lbl_control_username;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            textName: 'updateUsernamePass',
                            controller: usernamePassController,
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
                              setState(() {
                                changing;
                                isUsernameAvailable;
                                isLoading;
                                // isLoading = true;
                              });
                              if (_formKey.currentState!.validate() &&
                                  changing &&
                                  isUsernameAvailable) {
                                setState(() {
                                  isLoading = true;
                                });
                                String currentPasswordUsername =
                                    usernamePassController.text;
                                String newUsername = newUsernameController.text;

                                bool isPasswordCorrectUsername =
                                    await userProvider.verifyPassword(
                                        currentPasswordUsername);

                                if (isPasswordCorrectUsername) {
                                  await userProvider.updateUsername(
                                      context,
                                      userProvider.currentUser.uid,
                                      newUsername,
                                      currentPasswordUsername);

                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          trnslt.lcod_lbl_updated_username),
                                      duration: Duration(seconds: 5),
                                    ),
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text(trnslt.lcod_lbl_wrong_password),
                                      duration: Duration(seconds: 5),
                                    ),
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
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
                          ),
                          SizedBox(
                            height: 20,
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
            child: LoadingAnimationWidget.staggeredDotsWave(
                color: primaryColor, size: size.width / 3),
          ),
      ],
    );
  }
}
