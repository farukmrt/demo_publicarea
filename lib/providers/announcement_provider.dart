// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:demo_publicarea/models/announcement.dart';

// // class AnnouncementProvider with ChangeNotifier {
// //   Future<List<Announcement>> fetchAnnouncement(String build_id,
// //       {int? limit}) async {
// //     var collection = FirebaseFirestore.instance.collection("announcements");
// //     //print(collection);
// //     List<Announcement> tempList = [];
// //     var data = await collection.where('build_id', isEqualTo: build_id).get();
// //     data = limit != null ? data.limit(limit) : data;

// //     //notifyListeners();
// //     data.docs.forEach((element) {
// //       var announcement = Announcement(
// //         build_uid: element.data()['build_id'],
// //         title: element.data()['title'],
// //         subtitle: element.data()['subtitle'],
// //       );
// //       tempList.add(announcement);
// //     });

// //     return tempList;
// //   }

// //   // Future updateAnnouncement(String id, String title, String subtitle) async {
// //   //   try {
// //   //     await FirebaseFirestore.instance
// //   //         .collection('announcements')
// //   //         .doc(id)
// //   //         .update({'title': title, 'subtitle': subtitle});

// //   //     notifyListeners();
// //   //   } catch (e) {
// //   //     throw (e);
// //   //   }
// //   //}

// // //for list dondurme
// // // DescriptionProvider descriptionProvider =
// // //         Provider.of<DescriptionProvider>(context);
// // //     for (int i = 0; i < 3; i++) {
// // //       Description description = Description(
// // //         titlee: 'Duyuru Başlığı $i',
// // //         subtitlee: 'Duyuru Alt Başlığı $i',
// // //       );
// // //       descriptionProvider.addDescription(description
// class AnnouncementProvider with ChangeNotifier {
//   Future<List<Announcement>> fetchAnnouncement(String build_id,
//       {int? limit}) async {
//     var collection = FirebaseFirestore.instance.collection("announcements");
//     List<Announcement> tempList = [];
//     var query = collection.where('build_id', isEqualTo: build_id);
//     if (limit != null) {
//       query = query.limit(limit);
//     }
//     var data = await query.get();
//     data.docs.forEach((element) {
//       var announcement = Announcement(
//         id: element.data()['id'],
//         build_uid: element.data()['build_id'],
//         title: element.data()['title'],
//         subtitle: element.data()['subtitle'],
//         date: element.data()['date'],
//       );
//       tempList.add(announcement);
//     });
//     return tempList;
//   }

//   Announcement? announcement;
//   //late Announcement announcement;
//   Future<Announcement?> fetchAnAnnouncement(String announcementId) async {
//     var collection = FirebaseFirestore.instance.collection('announcements');
//     var query = collection.where('id', isEqualTo: announcementId).limit(1);
//     var data = await query.get();

//     //if (data.docs.isNotEmpty) {
//     var document = data.docs.first;

//     var announcement = Announcement(
//       id: document.data()['id'],
//       build_uid: document.data()['build_id'],
//       title: document.data()['title'],
//       subtitle: document.data()['subtitle'],
//       date: document.data()['date'],
//     );
//     return announcement;
//   }
// }

//   //     if (data.docs) {
//   //       var documentSnapshot = querySnapshot.docs.first;
//   //       var element = documentSnapshot.data();

//   //       Announcement announcement = Announcement(
//   //         id: element['id'],
//   //         build_uid: element['build_id'],
//   //         title: element['title'],
//   //         subtitle: element['subtitle'],
//   //         date: element['date'],
//   //       );

//   //       return announcement;
//   //     } else {
//   //       print('Belirtilen duyuru bulunamadı.');
//   //       return null;
//   //     }
//   //   } catch (e) {
//   //     print('Duyuru çekme işlemi sırasında bir hata oluştu: $e');
//   //     return null;
//   //   }
//   // }

//   //int selectedIndex = -1;

//   // void setIndex(int index) {
//   //   selectedIndex = index;
//   //   notifyListeners();
//   // }

//   // void setAnnouncement(Announcement newAnnouncement) {
//   //   announcement = newAnnouncement;
//   //   notifyListeners();
//   // }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:demo_publicarea/models/announcement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementProvider with ChangeNotifier {
  final _announcementStreamController =
      StreamController<List<Announcement>>.broadcast();
  Stream<List<Announcement>> get announcementStream =>
      _announcementStreamController.stream;

  Stream<List<Announcement>> fetchAnnouncement(String build_id, {int? limit}) {
    var collection = FirebaseFirestore.instance.collection("announcements");
    var query = collection.where('build_id', isEqualTo: build_id);
    query = limit != null ? query.limit(limit) : query;

    return query.snapshots().map((querySnapshot) {
      List<Announcement> tempList = [];
      querySnapshot.docs.forEach((element) {
        var announcement = Announcement(
          id: element.data()['id'],
          build_uid: element.data()['build_id'],
          title: element.data()['title'],
          subtitle: element.data()['subtitle'],
          date: element.data()['date'],
        );
        tempList.add(announcement);
      });
      return tempList;
    });
  }

  Stream<Announcement?> fetchAnAnnouncement(String announcementId) {
    var collection = FirebaseFirestore.instance.collection('announcements');
    var query = collection.where('id', isEqualTo: announcementId).limit(1);

    return query.snapshots().map((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        var document = querySnapshot.docs.first;

        var announcement = Announcement(
          id: document.data()['id'],
          build_uid: document.data()['build_id'],
          title: document.data()['title'],
          subtitle: document.data()['subtitle'],
          date: document.data()['date'],
        );
        return announcement;
      } else {
        return null;
      }
    });
  }

  @override
  void dispose() {
    _announcementStreamController.close();
    super.dispose();
  }
}
