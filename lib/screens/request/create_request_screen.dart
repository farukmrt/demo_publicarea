import 'dart:io';

import 'package:demo_publicarea/providers/photo_provider.dart';
import 'package:demo_publicarea/providers/request_provider.dart';
import 'package:demo_publicarea/screens/request/request_screen.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_dropdownbutton.dart';
import 'package:demo_publicarea/widgets/custom_image_input.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/widgets/custom_textfield.dart';
import 'package:demo_publicarea/widgets/custom_textfiled_med.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class CreateRequestScreen extends StatefulWidget {
  static String routeName = '/createrequest';

  const CreateRequestScreen({Key? key}) : super(key: key);

  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  //TextEditingController apartmentId = TextEditingController();
  TextEditingController apartmentNumberController = TextEditingController();
  TextEditingController requestTitleController = TextEditingController();
  TextEditingController requestExplanationController = TextEditingController();
  TextEditingController requestTypeController = TextEditingController();
  String? selectedValue;
  String? apartmentId;
  String? userUid;
  File? selectedImage;
  String? imageUrl;
  //File? selectedImageWidget;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> argument =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    userUid = argument['userUid'];
    apartmentId = argument['apartmentId'];
  }

  Widget build(BuildContext context) {
    RequestProvider requestProvider =
        Provider.of<RequestProvider>(context, listen: false);
    PhotoProvider photoProvider =
        Provider.of<PhotoProvider>(context, listen: false);

    Widget buildImageWidget() {
      if (selectedImage != null) {
        return Image.file(
          selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 500,
        );
      } else {
        return const Icon(Icons.camera_alt, size: 100, color: Colors.grey);
      }
    }

    return Container(
      color: mainBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Talep oluştur'),
            backgroundColor: mainBackgroundColor,
          ),
          body: Container(
            color: backgroundColor,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextField(
                    controller: requestTitleController,
                    labelText: 'Konu',
                  ),
                  CustomTextField(
                    controller: apartmentNumberController,
                    labelText: 'Daire',
                  ),
                  //DropdownButtonFormField(items:, onChanged: (){})

                  CustomDropdownButton(
                    //controller: requestTypeController,
                    labelText: 'Talep Tipi',
                    value: selectedValue,
                    items: const ['Arıza', 'Soru', 'Öneri', 'Şikayet'],
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue;
                      });
                    },
                  ),

                  // const CustomTextField(
                  //   controller: ,
                  //   labelText: 'Yaşam Alanı Tipi',
                  // ),
                  CustomTextFieldMedium(
                    controller: requestExplanationController,
                    labelText: 'Açıklama',

                    //maxline: minLine + 1,
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  CustomMainButton(
                    color: negative,
                    text: '    Resim ekle..',
                    edgeInsets: const EdgeInsets.symmetric(horizontal: 100),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            // title: Text('Resim Ekle'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    await photoProvider.takeAPhoto();
                                    Navigator.pop(context);
                                    setState(() {
                                      selectedImage =
                                          photoProvider.selectedImage;
                                    });
                                  },
                                  child: const Text(
                                    'Çekim yap',
                                    style:
                                        TextStyle(color: mainBackgroundColor),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () async {
                                    // Galeri seçeneği için işlemler burada yapılacak
                                    await photoProvider.getAPhoto();
                                    Navigator.pop(
                                        context); // Seçim yapıldığında, 'galeri' değeri ile iletişim kutusunu kapatacak
                                    setState(() {
                                      selectedImage =
                                          photoProvider.selectedImage;
                                    });
                                  },
                                  child: const Text(
                                    'Galeriden yükle',
                                    style:
                                        TextStyle(color: mainBackgroundColor),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  CustomMainButton(
                    text: 'Talebi Gönder..',
                    edgeInsets: const EdgeInsets.symmetric(vertical: 25),
                    onTap: () async {
                      if (selectedImage != null) {
                        imageUrl = await photoProvider
                            .sendRequestImage(selectedImage!);
                      }
                      requestProvider.sendRequestToFirestore(
                        apartmentNumberController,
                        requestTitleController,
                        requestExplanationController,
                        selectedValue!,
                        apartmentId!,
                        userUid!,
                        imageUrl,
                      );
                      PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                        context,
                        settings: RouteSettings(name: RequestScreen.routeName),
                        screen: const RequestScreen(),
                        withNavBar: true,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                  ),
                  Container(
                    child: buildImageWidget(),
                    // width: double.infinity,
                    // height: double.infinity,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
