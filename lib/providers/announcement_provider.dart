import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_publicarea/models/announcement.dart';

class AnnouncementProvider with ChangeNotifier {
  final _announcementStreamController =
      StreamController<List<Announcement>>.broadcast();

  Stream<List<Announcement>> get announcementStream =>
      _announcementStreamController.stream;

  // Stream<List<Announcement>> fetchAnnouncement(String build_id, {int? limit}) {
  //   var collection = FirebaseFirestore.instance.collection("announcements");
  //   var query = collection
  //       .where('build_id', isEqualTo: build_id)
  //       // .where('date')
  //       .orderBy('date', descending: true);
  //   query = limit != null ? query.limit(limit) : query;

  //   return query.snapshots().map((querySnapshot) {
  //     List<Announcement> tempList = [];
  //     querySnapshot.docs.forEach((element) {
  //       var announcement = Announcement(
  //         id: element.data()['id'],
  //         build_uid: element.data()['build_id'],
  //         title: element.data()['title'],
  //         subtitle: element.data()['subtitle'],
  //         date: element.data()['date'],
  //         imageUrl: element.data()['imageUrl'],
  //       );
  //       tempList.add(announcement);
  //     });
  //     return tempList;
  //   });
  // }

  DocumentSnapshot? lastDocument; // _fetchPage dışında bir yerde tanımlanacak

  List<Announcement> _announcements = [];

  List<Announcement> get announcements => _announcements;

  Stream<List<Announcement>> fetchPageAnnouncement(String build_id,
      {int? limit, int? pageKey}) async* {
    try {
      var collection = FirebaseFirestore.instance.collection("announcements");
      var query = collection
          .where('build_id', isEqualTo: build_id)

          //query = query.where('date').orderBy('date', descending: false);
          .orderBy('date', descending: true);
      query = limit != null ? query.limit(limit) : query;

      if (pageKey != null) {
        if (pageKey > 0) {
          query = query.startAfterDocument(lastDocument!);
        }
      }
      var querySnapshot = await query.get();
      List<Announcement> tempList = [];
      var documents = querySnapshot.docs;
      if (documents.isNotEmpty) {
        lastDocument = documents[documents.length - 1];
        documents.forEach(
          (element) {
            var announcement = Announcement(
              id: element.data()['id'],
              build_uid: element.data()['build_id'],
              title: element.data()['title'],
              subtitle: element.data()['subtitle'],
              date: element.data()['date'],
              imageUrl: element.data()['imageUrl'],
            );
            tempList.add(announcement);
          },
        );
      }
      yield tempList;
    } catch (e) {
      print("error --> $e");

      yield [];
    }
  }

  Stream<Announcement?> fetchAnnouncementDetails(String announcementId) {
    var collection = FirebaseFirestore.instance.collection('announcements');
    var query = collection.where('id', isEqualTo: announcementId).limit(1);

    return query.snapshots().map(
      (querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          var document = querySnapshot.docs.first;

          var announcement = Announcement(
              id: document.data()['id'],
              build_uid: document.data()['build_id'],
              title: document.data()['title'],
              subtitle: document.data()['subtitle'],
              date: document.data()['date'],
              imageUrl: document.data()['imageUrl']);
          return announcement;
        } else {
          return null;
        }
      },
    );
  }

  @override
  void dispose() {
    _announcementStreamController.close();
    super.dispose();
  }
}
