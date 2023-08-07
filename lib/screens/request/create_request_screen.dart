import 'dart:io';

import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/providers/photo_provider.dart';
import 'package:demo_publicarea/providers/request_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/screens/request/request_screen.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/utils/languages/lang.dart';
import 'package:demo_publicarea/widgets/custom_dropdownbutton.dart';
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
  TextEditingController selectedValueController = TextEditingController();

  String? selectedValue;
  String? apartmentId;
  String? userUid;
  File? selectedImage;
  String? imageUrl;
  bool changing = false;
  String? selectedValueType;

  //File? selectedImageWidget;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> argument =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    userUid = argument['userUid'];
    apartmentId = argument['apartmentId'];
  }

  @override
  // bool isTextFull() {
  //   return selectedValue != null &&
  //       apartmentNumberController.text.length > 1 &&
  //       requestExplanationController.text.length > 10 &&
  //       requestTitleController.text.length > 5;
  // }

  // @override
  // Color getButtonColor() {
  //   return isTextFull() ? primaryColor : primaryColor.withOpacity(0.5);
  // }

  @override
  void initState() {
    super.initState();
    // isTextFull();
    // getButtonColor();
    selectedValueController.addListener(_newMailControllerListener);
    apartmentNumberController.addListener(_newMailControllerListener);
    requestExplanationController.addListener(_newMailControllerListener);
    requestTitleController.addListener(_newMailControllerListener);

    _newMailControllerListener();
    // changing;
    // setState(() {
    //   changing;
    // });
  }

  void _newMailControllerListener() {
    String apartmentNumberValue = apartmentNumberController.text;
    String requestExplanationValue = requestExplanationController.text;
    String requestTitleValue = requestTitleController.text;
    String listenSelectedValue = selectedValueController.text;

    print('Talep başlığı: $requestTitleValue');
    print('Apartman numarası: $apartmentNumberValue');
    print('Talep tipi: $listenSelectedValue');
    print('Talep açıklaması: $requestExplanationValue');

    setState(() {
      // changing;
      if (requestTitleValue.isNotEmpty &&
          apartmentNumberValue.isNotEmpty &&
          listenSelectedValue.isNotEmpty &&
          requestExplanationValue.isNotEmpty) {
        print('$changing');
        changing = true;
        //sendButton = primaryColor;
      } else {
        print('$changing');
        changing = false;
        //_changingStreamController.add(false);
        //sendButton = primaryColor.withOpacity(0.5);
      }
    });

    setState(() {
      if (listenSelectedValue == 'Arıza' ||
          listenSelectedValue == 'Panne' ||
          listenSelectedValue == 'Malfunction' ||
          listenSelectedValue == 'عطل') {
        selectedValueType = listenSelectedValue;
        selectedValueType = 'lcod_lbl_request_malfunction';
      }
      if (listenSelectedValue == 'Soru' ||
          listenSelectedValue == 'Question' ||
          listenSelectedValue == 'Question' ||
          listenSelectedValue == 'سؤال') {
        selectedValueType = listenSelectedValue;
        selectedValueType = 'lcod_lbl_request_question';
      }
      if (listenSelectedValue == 'Öneri' ||
          listenSelectedValue == 'Suggestion' ||
          listenSelectedValue == 'Suggestion' ||
          listenSelectedValue == 'اقتراح') {
        selectedValueType = listenSelectedValue;
        selectedValueType = 'lcod_lbl_request_suggestion';
      }
      if (listenSelectedValue == 'Şikayet' ||
          listenSelectedValue == 'Plainte' ||
          listenSelectedValue == 'Complaint' ||
          listenSelectedValue == 'شكوى') {
        selectedValueType = listenSelectedValue;
        selectedValueType = 'lcod_lbl_request_complaint';
      }
    });
  }

  @override
  void dispose() {
    //_changingStreamController.close();
    apartmentNumberController.removeListener(_newMailControllerListener);
    requestExplanationController.removeListener(_newMailControllerListener);
    requestTitleController.removeListener(_newMailControllerListener);
    selectedValueController.removeListener(_newMailControllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      // isTextFull();
      // getButtonColor();
    });
    setState(() {
      selectedValue;
      selectedValueController.text.length;
      apartmentNumberController.text.length;
      requestExplanationController.text.length;
      requestTitleController.text.length;
    });
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    //userProvider.user.
    RequestProvider requestProvider =
        Provider.of<RequestProvider>(context, listen: false);
    PhotoProvider photoProvider =
        Provider.of<PhotoProvider>(context, listen: false);

    var trnslt = AppLocalizations.of(context)!;

    Widget buildImageWidget() {
      if (selectedImage != null) {
        return Container(
          color: mainBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(
              selectedImage!,
              fit: BoxFit.scaleDown,
              width: double.infinity,
              //height: 400,
            ),
          ),
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
            title: Text(trnslt.lcod_lbl_create_request),
            backgroundColor: mainBackgroundColor,
          ),
          body: Container(
            color: backgroundColor,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: buildImageWidget(),
                    // width: double.infinity,
                    // height: double.infinity,
                  ),

                  CustomTextField(
                    controller: requestTitleController,
                    labelText: trnslt.lcod_lbl_subject,
                  ),
                  CustomTextField(
                    controller: apartmentNumberController,
                    labelText: trnslt.lcod_lbl_apartment,
                  ),
                  //DropdownButtonFormField(items:, onChanged: (){})

                  CustomDropdownButton(
                    //controller: requestTypeController,
                    labelText: trnslt.lcod_lbl_request_type,
                    value: selectedValue,
                    //items: const ['Arıza', 'Soru', 'Öneri', 'Şikayet'],
                    items: [
                      trnslt.lcod_lbl_fault,
                      trnslt.lcod_lbl_question,
                      trnslt.lcod_lbl_suggestion,
                      trnslt.lcod_lbl_complaint
                    ],

                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue;
                        selectedValueController.text = selectedValue.toString();
                        // apartmentNumberController.text.length;
                        // requestExplanationController.text.length;
                        // requestTitleController.text.length;

                        // if (selectedValue != null) {
                        //   String lcod_lbl_fault = trnslt.lcod_lbl_fault;
                        //   String lcod_lbl_question = trnslt.lcod_lbl_question;
                        //   String lcod_lbl_suggestion =
                        //       trnslt.lcod_lbl_suggestion;
                        //   String lcod_lbl_complaint = trnslt.lcod_lbl_complaint;
                        // }
                      });
                    },
                  ),

                  // const CustomTextField(
                  //   controller: ,
                  //   labelText: 'Yaşam Alanı Tipi',
                  // ),
                  CustomTextFieldMedium(
                    controller: requestExplanationController,
                    labelText: trnslt.lcod_lbl_explanation,

                    //maxline: minLine + 1,
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  CustomMainButton(
                    color: negative,
                    text: '${trnslt.lcod_lbl_add_image}',
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
                                  child: Text(
                                    trnslt.lcod_lbl_shooting,
                                    style: const TextStyle(
                                        color: mainBackgroundColor),
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
                                  child: Text(
                                    trnslt.lcod_lbl_upload_from_gallery,
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
                    onTap: () async {
                      if (changing) {
                        requestProvider.sendRequestData(
                          apartmentNumberController,
                          requestTitleController,
                          requestExplanationController,
                          selectedValueType!,
                          apartmentId!,
                          userUid!,
                          selectedImage,
                        );
                        PersistentNavBarNavigator
                            .pushNewScreenWithRouteSettings(
                          context,
                          settings:
                              RouteSettings(name: RequestScreen.routeName),
                          screen: const RequestScreen(),
                          withNavBar: true,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      }
                    },
                    color:
                        changing ? primaryColor : primaryColor.withOpacity(0.5),
                    text: trnslt.lcod_lbl_send_request,
                    edgeInsets: const EdgeInsets.symmetric(vertical: 25),
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
