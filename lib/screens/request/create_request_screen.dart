import 'dart:io';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/widgets/custom_textfield.dart';
import 'package:demo_publicarea/providers/photo_provider.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/providers/request_provider.dart';
import 'package:demo_publicarea/widgets/custom_textfiled_med.dart';
import 'package:demo_publicarea/widgets/custom_dropdownbutton.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:demo_publicarea/screens/request/request_screen.dart';

class CreateRequestScreen extends StatefulWidget {
  static String routeName = '/createrequest';

  const CreateRequestScreen({Key? key}) : super(key: key);

  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
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
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> argument =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    userUid = argument['userUid'];
    apartmentId = argument['apartmentId'];
  }

  @override
  @override
  void initState() {
    super.initState();
    selectedValueController.addListener(_newMailControllerListener);
    apartmentNumberController.addListener(_newMailControllerListener);
    requestExplanationController.addListener(_newMailControllerListener);
    requestTitleController.addListener(_newMailControllerListener);

    _newMailControllerListener();
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
      if (requestTitleValue.isNotEmpty &&
          apartmentNumberValue.isNotEmpty &&
          listenSelectedValue.isNotEmpty &&
          requestExplanationValue.isNotEmpty) {
        print('$changing');
        changing = true;
      } else {
        print('$changing');
        changing = false;
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
    apartmentNumberController.removeListener(_newMailControllerListener);
    requestExplanationController.removeListener(_newMailControllerListener);
    requestTitleController.removeListener(_newMailControllerListener);
    selectedValueController.removeListener(_newMailControllerListener);
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    setState(() {
      selectedValue;
      selectedValueController.text.length;
      apartmentNumberController.text.length;
      requestExplanationController.text.length;
      requestTitleController.text.length;
    });
    // UserProvider userProvider =
    //     Provider.of<UserProvider>(context, listen: false);
    RequestProvider requestProvider =
        Provider.of<RequestProvider>(context, listen: false);
    PhotoProvider photoProvider =
        Provider.of<PhotoProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    var trnslt = AppLocalizations.of(context)!;

    Widget buildImageWidget() {
      if (selectedImage != null) {
        return Container(
          child: Stack(
            children: [
              GestureDetector(
                child: Container(
                  color: primaryColor.withOpacity(0.5),
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadiusDirectional.circular(1)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.file(
                        selectedImage!,
                        fit: BoxFit.scaleDown,
                        width: double.infinity,
                        //height: 400,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                await photoProvider.takeAPhoto();
                                Navigator.pop(context);
                                setState(() {
                                  selectedImage = photoProvider.selectedImage;
                                });
                              },
                              child: Text(
                                trnslt.lcod_lbl_shooting,
                                style:
                                    const TextStyle(color: mainBackgroundColor),
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
                                  selectedImage = photoProvider.selectedImage;
                                });
                              },
                              child: Text(
                                trnslt.lcod_lbl_upload_from_gallery,
                                style: TextStyle(color: mainBackgroundColor),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              Positioned(
                bottom: 0,
                right: 0,
                //: Alignment.bottomRight,
                //alignment: Alignment(1, 1),
                child: Container(
                  height: 25,
                  width: 25,
                  // margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
        //alig
      } else {
        return Container(
          width: 100,
          height: 100,
          margin: EdgeInsets.only(top: 30),
          child: Stack(
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.camera_alt,
                  //Icons.add_a_photo_outlined,
                  color: Colors.grey,
                  size: 84,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                await photoProvider.takeAPhoto();
                                Navigator.pop(context);
                                setState(() {
                                  selectedImage = photoProvider.selectedImage;
                                });
                              },
                              child: Text(
                                trnslt.lcod_lbl_shooting,
                                style:
                                    const TextStyle(color: mainBackgroundColor),
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
                                  selectedImage = photoProvider.selectedImage;
                                });
                              },
                              child: Text(
                                trnslt.lcod_lbl_upload_from_gallery,
                                style: TextStyle(color: mainBackgroundColor),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              Positioned(
                //icon
                bottom: 9,
                right: 3,
                // alignment: Alignment(0.9, 0.77),
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    // heightFactor: 15,
                    // widthFactor: 15,
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // child: Stack(
          //   children: <Widget>[
          //     CircleAvatar(
          //       radius: 50,
          //       child: Align(
          //         alignment: Alignment.bottomRight,
          //         child: Container(
          //           height: 25,
          //           width: 25,
          //           decoration: BoxDecoration(
          //             color: primaryColor,
          //             shape: BoxShape.circle,
          //           ),
          //           child: Center(
          //             child: IconButton(
          //               icon: const Icon(
          //                 //  Icons.camera_alt,
          //                 Icons.add_a_photo_outlined,
          //                 color: Colors.grey,
          //               ),
          //               onPressed: () {
          //                 showDialog(
          //                   context: context,
          //                   builder: (context) {
          //                     return CupertinoAlertDialog(
          //                       content: Column(
          //                         mainAxisSize: MainAxisSize.min,
          //                         children: [
          //                           ElevatedButton(
          //                             onPressed: () async {
          //                               await photoProvider.takeAPhoto();
          //                               Navigator.pop(context);
          //                               setState(() {
          //                                 selectedImage =
          //                                     photoProvider.selectedImage;
          //                               });
          //                             },
          //                             child: Text(
          //                               trnslt.lcod_lbl_shooting,
          //                               style: const TextStyle(
          //                                   color: mainBackgroundColor),
          //                             ),
          //                           ),
          //                           const SizedBox(height: 10),
          //                           ElevatedButton(
          //                             onPressed: () async {
          //                               // Galeri seçeneği için işlemler burada yapılacak
          //                               await photoProvider.getAPhoto();
          //                               Navigator.pop(
          //                                   context); // Seçim yapıldığında, 'galeri' değeri ile iletişim kutusunu kapatacak
          //                               setState(() {
          //                                 selectedImage =
          //                                     photoProvider.selectedImage;
          //                               });
          //                             },
          //                             child: Text(
          //                               trnslt.lcod_lbl_upload_from_gallery,
          //                               style: TextStyle(
          //                                   color: mainBackgroundColor),
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     );
          //                   },
          //                 );
          //               },
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        );
      }
    }

    return Stack(
      children: [
        Container(
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          child: buildImageWidget(),
                        ),
                        CustomTextField(
                          textName: 'requestSubject',
                          controller: requestTitleController,
                          labelText: trnslt.lcod_lbl_subject,
                          maxLength: 20,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.characters.length < 4) {
                              return trnslt.lcod_lbl_control_title;
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          textName: 'requestApartment',
                          controller: apartmentNumberController,
                          labelText: trnslt.lcod_lbl_apartment,
                          maxLength: 10,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.characters.isEmpty) {
                              return trnslt.lcod_lbl_control_apartment_number;
                            }
                            return null;
                          },
                        ),
                        CustomDropdownButton(
                          //controller: requestTypeController,
                          labelText: trnslt.lcod_lbl_request_type,
                          value: selectedValue,
                          items: [
                            trnslt.lcod_lbl_fault,
                            trnslt.lcod_lbl_question,
                            trnslt.lcod_lbl_suggestion,
                            trnslt.lcod_lbl_complaint
                          ],

                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue;
                              selectedValueController.text =
                                  selectedValue.toString();
                            });
                          },
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.characters.length < 4) {
                              return trnslt.lcod_lbl_control_request_type;
                            }
                            return null;
                          },
                        ),
                        CustomTextFieldMedium(
                          controller: requestExplanationController,
                          labelText: trnslt.lcod_lbl_explanation,
                          maxLength: 200,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.characters.length < 4) {
                              return trnslt
                                  .lcod_lbl_control_request_explanation;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // CustomMainButton(
                        //   color: negative,
                        //   text: '${trnslt.lcod_lbl_add_image}',
                        //   edgeInsets: const EdgeInsets.symmetric(horizontal: 100),
                        //   onTap: () {},
                        // ),
                        CustomMainButton(
                          onTap: () async {
                            if (_formKey.currentState!.validate() && changing) {
                              setState(() {
                                isLoading = true;
                              });
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
                                settings: RouteSettings(
                                    name: RequestScreen.routeName),
                                screen: const RequestScreen(),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            } else {
                              isLoading = false;
                            }
                          },
                          color: changing
                              ? primaryColor
                              : primaryColor.withOpacity(0.5),
                          text: trnslt.lcod_lbl_send_request,
                          edgeInsets: const EdgeInsets.symmetric(vertical: 25),
                        ),
                      ],
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
