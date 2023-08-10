import 'dart:io';

import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/providers/photo_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProfilphotoScreen extends StatefulWidget {
  static String routeName = '/updateProfilePhoto';
  const UpdateProfilphotoScreen({Key? key}) : super(key: key);
  @override
  _UpdateProfilphotoScreenState createState() =>
      _UpdateProfilphotoScreenState();
}

class _UpdateProfilphotoScreenState extends State<UpdateProfilphotoScreen> {
  File? selectedImage;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var trnslt = AppLocalizations.of(context)!;
    UserProvider userProvider = Provider.of<UserProvider>(context);
    PhotoProvider photoProvider = Provider.of<PhotoProvider>(context);

    return Container(
      color: primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text(
              trnslt.lcod_lbl_update_profile_photo,
              style: TextStyle(color: mainBackgroundColor),
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    foregroundImage:
                        NetworkImage(userProvider.currentUser.imageUrl),
                    radius: size.width * 0.45,
                  ),
                  SizedBox(height: 15),
                  //Text(trnslt.lcod_lbl_update_profile_screen),
                  ElevatedButton(
                    onPressed: () async {
                      await photoProvider.takeAPhoto();

                      setState(() {
                        selectedImage = photoProvider.selectedImage;
                      });
                      imageUrl = await photoProvider.sendPP(
                          selectedImage!, userProvider.currentUser.username);
                      await userProvider.updatePP(
                          userProvider.currentUser.uid, imageUrl!);
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
                        selectedImage = photoProvider.selectedImage;
                      });
                      imageUrl = await photoProvider.sendPP(
                          selectedImage!, userProvider.currentUser.username);
                      await userProvider.updatePP(
                          userProvider.currentUser.uid, imageUrl!);
                      Navigator.pop(context);
                    },
                    child: Text(
                      trnslt.lcod_lbl_upload_gallery,
                      style: TextStyle(color: mainBackgroundColor),
                    ),
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
