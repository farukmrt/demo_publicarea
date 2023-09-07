import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
  bool changing = false;
  bool newPhoneNumberColor = false;
  bool isLoading = false;
  TextEditingController currentValueController = TextEditingController();
  TextEditingController phoneNumberPassController = TextEditingController();
  TextEditingController newPhoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    newPhoneNumberController.addListener(_newPhoneNumberControllerListener);
    phoneNumberPassController.addListener(_newPhoneNumberControllerListener);

    _newPhoneNumberControllerListener();
  }

  void _newPhoneNumberControllerListener() {
    String newPhonenumberValue = newPhoneNumberController.text;
    String userPassValue = phoneNumberPassController.text;
    print('Yeni telefon numarası: $newPhonenumberValue');
    print('Yeni şifre: $userPassValue');

    setState(() {
      if (newPhonenumberValue.startsWith('05') &&
          newPhonenumberValue.length == 11 &&
          userPassValue.length > 5) {
        print('$changing');
        changing = true;
      } else {
        print('$changing');

        changing = false;
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    newPhoneNumberController.removeListener(_newPhoneNumberControllerListener);
    phoneNumberPassController.removeListener(_newPhoneNumberControllerListener);

    super.dispose();
  }

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
                            textName: 'currentPhoneNumber',
                            readOnly: true,
                            controller: currentValueController,
                            hintText: userProvider.currentUser.phoneNumber,
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          CustomTextField(
                            textName: 'updatePhoneNumber',
                            controller: newPhoneNumberController,
                            hintText: '05xx',
                            labelText: trnslt.lcod_lbl_phone_text,
                            keyboardType: TextInputType.phone,
                            maxLength: 11,
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.numeric(
                                    errorText: 'Lütfen yalnızca rakam giriniz'),
                                (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.characters.length != 11 ||
                                      !value.startsWith('05')) {
                                    return trnslt.lcod_lbl_control_phone_number;
                                  }
                                  return null;
                                },
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            textName: 'updatePhoneNumberPass',
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
            child: LoadingAnimationWidget.dotsTriangle(
                color: primaryColor, size: size.width / 3),
          ),
      ],
    );
  }
}
