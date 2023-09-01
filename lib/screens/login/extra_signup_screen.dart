import 'dart:io';
import 'package:demo_publicarea/models/building.dart';
import 'package:demo_publicarea/providers/building_provider.dart';
import 'package:demo_publicarea/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/providers/photo_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/screens/main/tabs_screen.dart';
import 'package:demo_publicarea/widgets/custom_textfield.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';

class ExtraSignupScreen extends StatefulWidget {
  static const String routeName = '/extraSign';
  const ExtraSignupScreen({Key? key}) : super(key: key);

  @override
  State<ExtraSignupScreen> createState() => _ExtraSignupScreenState();
}

class _ExtraSignupScreenState extends State<ExtraSignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _buildingIdController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  // ignore: unused_field
  final List<BuildingModel> _buildingList = [];
  bool changing = false;
  bool isLoading = false;
  File? selectedImage;
  String? imageUrl;
  // final String defaultImageUrl =
  //     'https://firebasestorage.googleapis.com/v0/b/fir-publicarea.appspot.com/o/images%2FprofilePhoto%2Fdefault_pp.jpg?alt=media&token=b01afd32-81fd-46ce-b972-88c5e7278c7b';

  ImageProvider<Object>? buildImageProvider(UserProvider userProvider) {
    if (selectedImage != null) {
      return FileImage(selectedImage!);
    } else {
      return NetworkImage(userProvider.currentUser.imageUrl);
    }
  }

//default olan değer    firebasestorage
//resim seçilen         /data/
  signUpUser(UserProvider userProvider, PhotoProvider photoProvider,
      BuildingProvider buildingProvider) async {
    if (selectedImage == null) {
      // Eğer resim yüklenmediyse default resmi URL'sini kullanmak istiyorum
      // ancak olmuyor, sendPP içerisinde taskSnapshot kısmında patlıyor.
      selectedImage = File(userProvider.currentUser.imageUrl);
      imageUrl = await photoProvider.sendPP(
        selectedImage!,
        _usernameController.text,
      );
    }
    imageUrl = await photoProvider.sendPP(
      selectedImage!,
      _usernameController.text,
    );

    bool res = await userProvider.signUpUser(
      context,
      _emailController.text,
      _usernameController.text,
      _passwordController.text,
      _nameController.text,
      _surnameController.text,
      _buildingController.text,
      imageUrl ?? userProvider.currentUser.imageUrl,
      _phoneNumberController.text,
      _buildingIdController.text,

      // userProvider
      //     .updateBuildingId(buildingProvider.currentBuilding.buildingId),

      //buildingProvider,

      //await buildingProvider.currentBuilding.buildingId);
    );
    if (res) {
      await buildingProvider.fetchBuilding(_buildingController.text);
      userProvider.updateBuildinId(buildingProvider.currentBuilding.buildingId);
      //print(buildingProvider.currentBuilding.buildingId);
      PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
        context,
        settings:
            RouteSettings(name: TabsScreen.routeName, arguments: userProvider),
        screen: const TabsScreen(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    //  _nameController.text = userProvider currentUser.name;
    //  _phoneNumberController.text = currentUser.phoneNumber;
    //_emailController.addListener(_mailControllerListener);
    _usernameController.addListener(_mailControllerListener);
    _passwordController.addListener(_mailControllerListener);
    _nameController.addListener(_mailControllerListener);
    _surnameController.addListener(_mailControllerListener);
    _buildingController.addListener(_mailControllerListener);
    _phoneNumberController.addListener(_mailControllerListener);

    //_buildingListFuture = BuildingProvider().fetchBuildingList();
  }

  void _mailControllerListener() {
    //String mailValue = _emailController.text;
    String usernameValue = _usernameController.text;
    String passValue = _passwordController.text;
    String nameValue = _nameController.text;
    String surnameValue = _surnameController.text;
    String buildingValue = _buildingController.text;
    String phonenumberValue = _phoneNumberController.text;

    //  print('e-posta değeri: $mailValue');
    print('kullanıcı adı: $usernameValue');
    print('şifre değeri: $passValue');
    print('isim değeri: $nameValue');
    print('soyisim değeri: $surnameValue');
    print('bina adı değeri: $buildingValue');
    print('telefon num değeri: $phonenumberValue');

    setState(() {
      if (
          // mailValue.endsWith('.com') &&
          //   mailValue.contains('@') &&
          passValue.length > 5 &&
              usernameValue.length > 3 &&
              nameValue.length > 3 &&
              surnameValue.length > 2 &&
              buildingValue.length > 5 &&
              phonenumberValue.startsWith('05') &&
              phonenumberValue.length == 11) {
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
    _emailController.removeListener(_mailControllerListener);
    _passwordController.removeListener(_mailControllerListener);
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  late Stream<List<BuildingModel>> buildingStream;

  @override
  Widget build(BuildContext context) {
    var trnslt = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    PhotoProvider photoProvider = Provider.of<PhotoProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    BuildingProvider buildingProvider = Provider.of<BuildingProvider>(context);
    // ignore: unused_local_variable
    BuildingModel? selectedBuilding;
    // ignore: unused_local_variable
    String? selectedBuildingName;

    TextEditingController(text: "Your initial value");
//     _nameController.text = userProvider.currentUser.name;
//     _phoneNumberController.text = userProvider.currentUser.phoneNumber;

    return Scaffold(
      appBar: AppBar(
        title: Text(trnslt.lcod_lbl_signup),
      ),
      body:
          // Stack(
          //   children: [
          SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: size.height * 0.05),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          // title: Text('Resim Ekle'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                trnslt.lcod_lbl_profilphoto,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await photoProvider.takeAPhoto();

                                  setState(() {
                                    selectedImage = photoProvider.selectedImage;
                                  });

                                  Navigator.pop(context);
                                },
                                child: Text(
                                  trnslt.lcod_lbl_shooting,
                                  style: TextStyle(color: mainBackgroundColor),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () async {
                                  await photoProvider.getAPhoto();
                                  setState(() {
                                    selectedImage = photoProvider.selectedImage;
                                  });

                                  Navigator.pop(context);
                                },
                                child: Text(
                                  trnslt.lcod_lbl_upload_gallery,
                                  style: const TextStyle(
                                      color: mainBackgroundColor),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          foregroundImage: buildImageProvider(userProvider),
                          radius: 60,
                        ),
                        Positioned(
                          //icon
                          bottom: 0, right: 0,
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.9),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              heightFactor: 15,
                              widthFactor: 15,
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CustomTextField(
                  textName: 'createPass',
                  controller: _passwordController,
                  labelText: trnslt.lcod_lbl_create_password,
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
                CustomTextField(
                  textName: 'createUsername',
                  controller: _usernameController,
                  labelText: trnslt.lcod_lbl_create_username,
                  maxLength: 15,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.characters.length < 4) {
                      return trnslt.lcod_lbl_control_username;
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  textName: 'createName',

                  //initialValue: userProvider.currentUser.name,
                  controller: _nameController,
                  labelText: trnslt.lcod_lbl_enter_name,
                  //hintText: userProvider.currentUser.name,
                  maxLength: 15,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.characters.length < 4) {
                      return trnslt.lcod_lbl_control_name;
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  textName: 'createSurename',
                  controller: _surnameController,
                  labelText: trnslt.lcod_lbl_enter_surname,
                  maxLength: 15,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.characters.length <= 2) {
                      return trnslt.lcod_lbl_control_surname;
                    }
                    return null;
                  },
                ),
                TypeAheadField<String>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _buildingController,
                      decoration: InputDecoration(
                        labelText: trnslt.lcod_lbl_enter_building,
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      List<BuildingModel> buildingList =
                          await BuildingProvider.fetchBuildingList();
                      return buildingList
                          .where((building) => building.buildName
                              .toLowerCase()
                              .contains(pattern.toLowerCase()))
                          .map((building) => building.buildName)
                          .toList();
                    },
                    itemBuilder: (context, selected) {
                      return ListTile(
                        title: Text(selected),
                      );
                    },
                    onSuggestionSelected: (selected) async {
                      setState(() {
                        _buildingController.text = selected;
                      });
                      var buildingId = await buildingProvider
                          .fetchBuildingId(_buildingController.text);
                      setState(() {
                        _buildingIdController.text = buildingId;
                      });

                      print('loginsccc $buildingId');
                    }),
                CustomTextField(
                  // initialValue: userProvider.currentUser.phoneNumber,
                  textName: 'createPhoneNumber',
                  controller: _phoneNumberController,
                  labelText: trnslt.lcod_lbl_enter_phonenumber,
                  keyboardType: TextInputType.phone,
                  hintText: '05XX',
                  maxLength: 11,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.characters.length != 11 ||
                        !value.startsWith('05')) {
                      return trnslt.lcod_lbl_control_phone_number;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                CustomMainButton(
                  onTap: () {
                    setState(() {
                      changing;
                    });
                    isLoading = true;
                    if (_formKey.currentState!.validate() && changing) {
                      signUpUser(userProvider, photoProvider, buildingProvider);
                    }
                  },
                  text: trnslt.lcod_lbl_signup,
                  edgeInsets: const EdgeInsets.symmetric(vertical: 8),
                  color:
                      changing ? primaryColor : primaryColor.withOpacity(0.5),
                )
              ],
            ),
          ),
        ),
      ),
      //     if (isLoading)
      //       Center(
      //         child: LoadingAnimationWidget.halfTriangleDot(
      //             color: primaryColor, size: size.width / 3),
      //       ),
      //   ],
      // ),
    );
  }
}
