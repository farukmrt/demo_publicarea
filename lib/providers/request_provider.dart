import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_publicarea/models/request.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RequestProvider with ChangeNotifier {
  Future<String> getLatestRequestId() async {
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('request');
    final querySnapshot = await collectionRef
        .orderBy('requestId', descending: true)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      final latestRequestId =
          querySnapshot.docs.first.data() as Map<String, dynamic>;
      final latestRequestIdValue = latestRequestId['requestId'] as String;
      final newRequestId = int.parse(latestRequestIdValue) + 1;
      final newRequestIdFormatted = newRequestId.toString().padLeft(4, '0');
      return newRequestIdFormatted;
    } else {
      return '0001';
    }
  }

  final _requestStreamController = StreamController<List<Request>>.broadcast();
  Stream<List<Request>> get requestStream => _requestStreamController.stream;

  Stream<List<Request>> fetchRequestByStatus(bool status, String apartmentId,
      {int? limit}) {
    var collection = FirebaseFirestore.instance.collection('request');
    var query = collection
        .where("status", isEqualTo: status)
        .where("apartmentId", isEqualTo: apartmentId);

    query = limit != null ? query.limit(limit) : query;

    return query.snapshots().map((querySnapshot) {
      List<Request> requests = [];
      querySnapshot.docs.forEach((element) {
        var request = Request(
            requestId: element.data()['requestId'],
            requestTitle: element.data()['requestTitle'],
            apartmentId: element.data()['apartmentId'],
            apartmentNumber: element.data()['apartmentNumber'],
            status: element.data()['status'],
            requestType: element.data()['requestType'],
            requestExplanation: element.data()['requestExplanation'],
            requester: element.data()['requester'],
            requestDate: element.data()['requestDate']);

        requests.add(request);
      });
      return requests;
    });
  }

  Future<void> sendRequestToFirestore(
    TextEditingController apartmentNumberController,
    TextEditingController requestTitleController,
    TextEditingController requestExplanationController,
    String requestTypeController,
    // bool status,
    String apartmentId,
    String userUid,
    String? imageUrl,
  ) async {
    try {
      final newRequestId = await getLatestRequestId();
      final CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('request');

      await collectionRef.add({
        'requestId': newRequestId,
        'apartmentId': apartmentId,
        'apartmentNumber': apartmentNumberController.text,
        'requestTitle': requestTitleController.text,
        'requestExplanation': requestExplanationController.text,
        'requestType': requestTypeController,
        'status': true,
        'requester': userUid,
        'requestDate': Timestamp.now(),
        'imageUrl': imageUrl,
      });
      print('Veriler Firestore\'a başarıyla gönderildi.');
    } catch (e) {
      print('Firestore\'a verileri gönderirken hata oluştu: $e');
    }
  }

  // File? selectedImage;
  // Future takeAPhoto() async {
  //   final imagePicker = ImagePicker();
  //   final pickedImage =
  //       await imagePicker.pickImage(source: ImageSource.camera, maxHeight: 600);
  //   if (pickedImage == null) {
  //     return;
  //   }
  //   selectedImage = File(pickedImage.path);
  //   return selectedImage;
  // }

  // Future getAPhoto() async {
  //   final imagePicker = ImagePicker();
  //   final pickedImage = await imagePicker.pickImage(
  //       source: ImageSource.gallery, maxHeight: 600);
  //   if (pickedImage == null) {
  //     return;
  //   }
  //   selectedImage = File(pickedImage.path);
  //   return selectedImage;
  // }

  // Future<String?> sendRequestImage(File imageFile) async {
  //   try {
  //     String imageName = DateTime.now().millisecondsSinceEpoch.toString();
  //     Reference storageReference = FirebaseStorage.instance
  //         .ref()
  //         .child('images/requests/$imageName.jpg');
  //     UploadTask uploadTask = storageReference.putFile(imageFile);
  //     TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
  //     String imageUrl = await taskSnapshot.ref.getDownloadURL();
  //     return imageUrl;
  //   } catch (e) {
  //     print("Error uploading image to Firebase: $e");
  //     return null;
  //   }
  // }

  Stream<Request?> fetchARequest(String requestId) {
    var collection = FirebaseFirestore.instance.collection('request');
    var query = collection.where('requestId', isEqualTo: requestId).limit(1);

    return query.snapshots().map((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        var document = querySnapshot.docs.first;

        var request = Request(
          requestId: requestId,
          status: document.data()['status'],
          requester: document.data()['requester'],
          requestDate: document.data()['requestDate'],
          requestType: document.data()['requestType'],
          apartmentId: document.data()['apartmentId'],
          requestTitle: document.data()['requestTitle'],
          apartmentNumber: document.data()['apartmentNumber'],
          requestExplanation: document.data()['requestExplanation'],
          imageUrl: document.data()['imageUrl'],
        );
        return request;
      } else {
        return null;
      }
    });
  }

  @override
  void dispose() {
    // StreamController'ları temizleyin
    // İlgili yerde kullanılan StreamController'ları dispose edin
    // Ayrıca diğer gereksiz nesneleri de burada temizleyebilirsiniz
    _requestStreamController.close();
    super.dispose();
  }
}
