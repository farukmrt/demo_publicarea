import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:demo_publicarea/models/request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RequestProvider with ChangeNotifier {
  final _requestStreamController = StreamController<List<Request>>.broadcast();
  Stream<List<Request>> get requestStream => _requestStreamController.stream;

//otomatik requestId'sini verebilmek için son id'yi sorgulayıp bir büyüğünü gönderiyoruz
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

  DocumentSnapshot? lastdocument;
  final List<Request> _requests = [];
  List<Request> get requests => _requests;

  Stream<List<Request>> fetchPageRequestByStatus(
      bool status, String apartmentId,
      {int? limit, int? pageKey}) async* {
    var collection = FirebaseFirestore.instance.collection('request');
    var query = collection
        .where("status", isEqualTo: status)
        .where("apartmentId", isEqualTo: apartmentId)
        .orderBy('requestDate', descending: true);
    //.orderBy("requestDate");

    query = limit != null ? query.limit(limit) : query;
    if (pageKey != null) {
      if (pageKey > 0) {
        query = query.startAfterDocument(lastdocument!);
      }
    }
    var querySnapshot = await query.get();
    List<Request> templist = [];
    var documents = querySnapshot.docs;
    if (documents.isNotEmpty) {
      lastdocument = documents[documents.length - 1];
      documents.forEach(
        (element) {
          var request = Request(
            requestId: element.data()['requestId'],
            requestTitle: element.data()['requestTitle'],
            apartmentId: element.data()['apartmentId'],
            apartmentNumber: element.data()['apartmentNumber'],
            status: element.data()['status'],
            isPositive: element.data()['isPositive'],
            requestType: element.data()['requestType'],
            requestExplanation: element.data()['requestExplanation'],
            requester: element.data()['requester'],
            requestDate: element.data()['requestDate'],
            resultDescription: element.data()['resultDescription'],
          );

          templist.add(request);
        },
      );
    }
    yield templist;
  }

  // Stream<List<Request>> fetchRequestByStatus(bool status, String apartmentId,
  //     {int? limit, int? pageKey}) {
  //   var collection = FirebaseFirestore.instance.collection('request');
  //   var query = collection
  //       .where("status", isEqualTo: status)
  //       .where("apartmentId", isEqualTo: apartmentId);
  //   query = limit != null ? query.limit(limit) : query;
  //   return query.snapshots().map((querySnapshot) {
  //     List<Request> requests = [];
  //     querySnapshot.docs.forEach((element) {
  //       var request = Request(
  //           requestId: element.data()['requestId'],
  //           requestTitle: element.data()['requestTitle'],
  //           apartmentId: element.data()['apartmentId'],
  //           apartmentNumber: element.data()['apartmentNumber'],
  //           status: element.data()['status'],
  //           requestType: element.data()['requestType'],
  //           requestExplanation: element.data()['requestExplanation'],
  //           requester: element.data()['requester'],
  //           requestDate: element.data()['requestDate']);
  //       requests.add(request);
  //     });
  //     return requests;
  //   });
  // }

  Future<void> sendRequestData(
    TextEditingController apartmentNumberController,
    TextEditingController requestTitleController,
    TextEditingController requestExplanationController,
    String requestTypeController,
    String apartmentId,
    String userUid,
    File? imageFile,
  ) async {
    try {
      String? imageUrl;
      final newRequestId = await getLatestRequestId();
      final CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('request');

      if (imageFile != null) {
        String imageName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('images/requests/$imageName.jpg');
        UploadTask uploadTask = storageReference.putFile(imageFile);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        imageUrl = await taskSnapshot.ref.getDownloadURL();
      }

      await collectionRef.add({
        'requestId': newRequestId,
        'apartmentId': apartmentId,
        'apartmentNumber': apartmentNumberController.text,
        'requestTitle': requestTitleController.text,
        'requestExplanation': requestExplanationController.text,
        'requestType': requestTypeController,
        'status': true,
        'isPositive': true,
        'requester': userUid,
        'requestDate': Timestamp.now(),
        'imageUrl': imageUrl,
        'resultDescription': '',
      });
      print('Veriler Firestore\'a başarıyla gönderildi.');
    } catch (e) {
      print('Firestore\'a verileri gönderirken hata oluştu: $e');
    }
  }

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
          isPositive: document.data()['isPositive'],
          resultDescription: document.data()['resultDescription'],
        );
        return request;
      } else {
        return null;
      }
    });
  }

  @override
  void dispose() {
    _requestStreamController.close();
    super.dispose();
  }
}
