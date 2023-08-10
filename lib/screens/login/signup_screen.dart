// import 'dart:io';
// import 'package:demo_publicarea/providers/photo_provider.dart';
// import 'package:demo_publicarea/resources/auth_methods.dart';
// import 'package:demo_publicarea/screens/main/tabs_screen.dart';
// import 'package:demo_publicarea/utils/colors.dart';
// import 'package:demo_publicarea/widgets/custom_main_button.dart';
// import 'package:demo_publicarea/widgets/custom_textfield.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// import 'package:provider/provider.dart';

// class SignupScreen extends StatefulWidget {
//   static const String routeName = '/sign';
//   const SignupScreen({Key? key}) : super(key: key);

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _surnameController = TextEditingController();
//   final TextEditingController _buildingController = TextEditingController();
//   final AuthMethods _authMethods = AuthMethods();

//   File? selectedImage;
//   String? imageUrl;
//   final String defaultImageUrl =
//       'https://firebasestorage.googleapis.com/v0/b/fir-publicarea.appspot.com/o/images%2FprofilePhoto%2Fdefault_pp.png?alt=media&token=b7b85eab-17d2-42bf-a9fc-3ce97a68e9ba';

//   ImageProvider<Object>? buildImageProvider() {
//     if (selectedImage != null) {
//       return Image.file(selectedImage!)
//           .image; // FileImage'ı ImageProvider türüne çevir
//     } else {
//       return const NetworkImage(
//         'https://firebasestorage.googleapis.com/v0/b/fir-publicarea.appspot.com/o/images%2FprofilePhoto%2Fdefault_pp.png?alt=media&token=b7b85eab-17d2-42bf-a9fc-3ce97a68e9ba',
//       );
//     }
//   }

//   void signUpUser() async {
//     if (selectedImage == null) {
//       // Eğer resim çekilmediyse veya yüklenmediyse default resmi URL'sini kullan
//       imageUrl = defaultImageUrl;
//     } else {
//       imageUrl = await PhotoProvider()
//           .sendPP(selectedImage!, _usernameController.text);
//     }
//     bool res = await _authMethods.signUpUser(
//       context,
//       _emailController.text,
//       _usernameController.text,
//       _passwordController.text,
//       _nameController.text,
//       _surnameController.text,
//       _buildingController.text,
//     );
//     if (res) {
//       PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
//         context,
//         settings: RouteSettings(name: TabsScreen.routeName),
//         screen: const TabsScreen(),
//         withNavBar: false,
//         pageTransitionAnimation: PageTransitionAnimation.cupertino,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     PhotoProvider photoProvider = Provider.of<PhotoProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Üye Ol'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 18),
//           child: Column(
//             children: [
//               SizedBox(height: size.height * 0.05),
//               GestureDetector(
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return CupertinoAlertDialog(
//                         // title: Text('Resim Ekle'),
//                         content: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             const Text(
//                               'Profil Resmi Ekleyiniz..',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             ElevatedButton(
//                               onPressed: () async {
//                                 await photoProvider.takeAPhoto();

//                                 setState(() {
//                                   selectedImage = photoProvider.selectedImage;
//                                 });

//                                 Navigator.pop(context);
//                               },
//                               child: const Text(
//                                 'Çekim yap',
//                                 style: TextStyle(color: mainBackgroundColor),
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             ElevatedButton(
//                               onPressed: () async {
//                                 // Galeri seçeneği için işlemler burada yapılacak
//                                 await photoProvider.getAPhoto();
//                                 // Seçim yapıldığında, 'galeri' değeri ile iletişim kutusunu kapatacak
//                                 setState(() {
//                                   selectedImage = photoProvider.selectedImage;
//                                 });

//                                 Navigator.pop(context);
//                               },
//                               child: const Text(
//                                 'Galeriden yükle',
//                                 style: TextStyle(color: mainBackgroundColor),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: CircleAvatar(
//                     foregroundImage: //buildImageProvider(),
//                         imageUrl != null
//                             ? buildImageProvider()
//                             : const NetworkImage(
//                                 'https://firebasestorage.googleapis.com/v0/b/fir-publicarea.appspot.com/o/images%2FprofilePhoto%2Fdefault_pp.png?alt=media&token=b7b85eab-17d2-42bf-a9fc-3ce97a68e9ba'),
//                     radius: 60,
//                   ),
//                 ),
//               ),
//               CustomTextField(
//                 controller: _emailController,
//                 labelText: 'Email Adresinizi girin',
//               ),
//               CustomTextField(
//                 controller: _passwordController,
//                 labelText: 'Parolanızı oluşturun',
//               ),
//               CustomTextField(
//                 controller: _usernameController,
//                 labelText: 'Kullanıcı adınızı oluşturun',
//               ),
//               CustomTextField(
//                 controller: _nameController,
//                 labelText: 'Adınızı girin',
//               ),
//               CustomTextField(
//                 controller: _surnameController,
//                 labelText: 'Soyadınızı girin',
//               ),
//               CustomTextField(
//                 controller: _buildingController,
//                 labelText: 'Bina adını girin',
//               ),
//               const SizedBox(height: 15),
//               CustomMainButton(
//                   onTap: signUpUser,
//                   text: 'Üye ol..',
//                   edgeInsets: const EdgeInsets.symmetric(vertical: 8))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/providers/photo_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/screens/main/tabs_screen.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/sign';
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  // final AuthMethods _authMethods = AuthMethods();
  bool changing = false;
  File? selectedImage;
  String? imageUrl;
  final String defaultImageUrl =
      'https://firebasestorage.googleapis.com/v0/b/fir-publicarea.appspot.com/o/images%2FprofilePhoto%2Fdefault_pp.jpg?alt=media&token=b01afd32-81fd-46ce-b972-88c5e7278c7b';

  // @override
  // void initState() {
  //   super.initState();
  //   // initState yöntemi içinde selectedImage'ı null olarak başlat
  //   selectedImage = null;
  // }

  ImageProvider<Object>? buildImageProvider() {
    if (selectedImage != null) {
      return FileImage(selectedImage!);
    } else {
      return NetworkImage(defaultImageUrl);
    }
  }

//default olan değer    firebasestorage
//resim seçilen         /data/
  signUpUser(UserProvider userProvider, PhotoProvider photoProvider) async {
    if (selectedImage == null) {
      // Eğer resim yüklenmediyse default resmi URL'sini kullanmak istiyorum
      // ancak olmuyor, sendPP içerisinde taskSnapshot kısmında patlıyor.
      selectedImage = File(defaultImageUrl);
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
      imageUrl ?? defaultImageUrl,
      _phoneNumberController.text,
    );
    if (res) {
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
    _emailController.addListener(_mailControllerListener);
    _usernameController.addListener(_mailControllerListener);
    _passwordController.addListener(_mailControllerListener);
    _nameController.addListener(_mailControllerListener);
    _surnameController.addListener(_mailControllerListener);
    _buildingController.addListener(_mailControllerListener);
    _phoneNumberController.addListener(_mailControllerListener);

    //_changingStreamController;
    // changing;
    // setState(() {
    //   changing;
    // });
  }

  void _mailControllerListener() {
    String mailValue = _emailController.text;
    String usernameValue = _usernameController.text;
    String passValue = _passwordController.text;
    String nameValue = _nameController.text;
    String surnameValue = _surnameController.text;
    String buildingValue = _buildingController.text;
    String phonenumberValue = _phoneNumberController.text;

    print('e-posta değeri: $mailValue');
    print('kullanıcı adı: $usernameValue');
    print('şifre değeri: $passValue');
    print('isim değeri: $nameValue');
    print('soyisim değeri: $surnameValue');
    print('bina adı değeri: $buildingValue');
    print('telefon num değeri: $phonenumberValue');

    setState(() {
      // changing;
      if (mailValue.endsWith('.com') &&
          mailValue.contains('@') &&
          passValue.length > 5 &&
          usernameValue.length > 3 &&
          nameValue.length > 3 &&
          surnameValue.length > 2 &&
          buildingValue.length > 5 &&
          phonenumberValue.startsWith('05') &&
          phonenumberValue.length == 11) {
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

  //final AuthMethods _authMethods = AuthMethods();
  @override
  void dispose() {
    // State nesnesi yok edildiğinde, dinleyicileri kaldırın
    _emailController.removeListener(_mailControllerListener);
    _passwordController.removeListener(_mailControllerListener);
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var trnslt = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    PhotoProvider photoProvider = Provider.of<PhotoProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(trnslt.lcod_lbl_signup),
      ),
      body: SingleChildScrollView(
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
                                    // if (selectedImage == null) {
                                    //   selectedImage = File(defaultImageUrl);
                                    // }
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
                                  // Galeri seçeneği için işlemler burada yapılacak
                                  await photoProvider.getAPhoto();
                                  // Seçim yapıldığında, 'galeri' değeri ile iletişim kutusunu kapatacak
                                  setState(() {
                                    // if (selectedImage == null) {
                                    //   selectedImage = File(defaultImageUrl);
                                    // }
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
                    child: CircleAvatar(
                      foregroundImage: buildImageProvider(),
                      radius: 60,
                    ),
                  ),
                ),
                CustomTextField(
                  controller: _emailController,
                  labelText: trnslt.lcod_lbl_email,
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
                CustomTextField(
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
                    return null; // Herhangi bir hata yoksa null döndürün.
                  },
                ),
                CustomTextField(
                  controller: _usernameController,
                  labelText: trnslt.lcod_lbl_create_username,
                  maxLength: 15,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.characters.length < 4) {
                      return trnslt.lcod_lbl_control_username;
                    }
                    return null; // Herhangi bir hata yoksa null döndürün.
                  },
                ),
                CustomTextField(
                  controller: _nameController,
                  labelText: trnslt.lcod_lbl_enter_name,
                  maxLength: 15,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.characters.length < 4) {
                      return trnslt.lcod_lbl_control_name;
                    }
                    return null; // Herhangi bir hata yoksa null döndürün.
                  },
                ),
                CustomTextField(
                  controller: _surnameController,
                  labelText: trnslt.lcod_lbl_enter_surname,
                  maxLength: 15,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.characters.length <= 2) {
                      return trnslt.lcod_lbl_control_surname;
                    }
                    return null; // Herhangi bir hata yoksa null döndürün.
                  },
                ),
                CustomTextField(
                  controller: _buildingController,
                  labelText: trnslt.lcod_lbl_enter_building,
                  maxLength: 35,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.characters.length < 4) {
                      return trnslt.lcod_lbl_control_building_name;
                    }
                    return null; // Herhangi bir hata yoksa null döndürün.
                  },
                ),
                CustomTextField(
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
                    return null; // Herhangi bir hata yoksa null döndürün.
                  },
                ),
                const SizedBox(height: 15),
                CustomMainButton(
                  onTap: () {
                    setState(() {
                      changing;
                    });
                    if (_formKey.currentState!.validate() && changing) {
                      signUpUser(userProvider, photoProvider);
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
    );
  }
}
