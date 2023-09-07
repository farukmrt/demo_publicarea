import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PhotoProvider with ChangeNotifier {
  File? selectedImage;
  final imagePicker = ImagePicker();

  Future takeAPhoto() async {
    selectedImage = null;
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxHeight: 600);
    if (pickedImage == null) {
      return;
    }
    selectedImage = File(pickedImage.path);
    return selectedImage;
  }

  Future getAPhoto() async {
    selectedImage = null;
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 600);
    if (pickedImage == null) {
      return;
    }
    selectedImage = File(pickedImage.path);
    return selectedImage;
  }

//resimler talep id değeri ile tutualbilir değiştirebiliriz
  Future<String?> sendRequestImage(File imageFile) async {
    try {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/requests/$imageName.jpg');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Error uploading image to Firebase: $e");
      return null;
    }
  }

  Future<String?> sendPP(File imageFile, String uname) async {
    try {
      String imageName = uname.toString();
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/profilePhoto/$imageName.jpg');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Error uploading image to Firebase: $e");
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
