import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_publicarea/models/announcement.dart';

class AnnouncementProvider with ChangeNotifier {
  Future<List<Announcement>> fetchAnnouncement() async {
    var collection = FirebaseFirestore.instance.collection("announcements");
    //print(collection);
    List<Announcement> tempList = [];
    var data = await collection.get();
    //notifyListeners();
    data.docs.forEach((element) {
      var announcement = Announcement(
        build_uid: element.data()['build_id'],
        title: element.data()['title'],
        subtitle: element.data()['subtitle'],
      );
      tempList.add(announcement);
    });

    return tempList;
  }

  // Future updateAnnouncement(String id, String title, String subtitle) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('announcements')
  //         .doc(id)
  //         .update({'title': title, 'subtitle': subtitle});

  //     notifyListeners();
  //   } catch (e) {
  //     throw (e);
  //   }
  //}

  //List<Map<String, dynamic>> get getAnnouncements {
  // return _announcements;
  //}
}

//for list dondurme
// DescriptionProvider descriptionProvider =
//         Provider.of<DescriptionProvider>(context);
//     for (int i = 0; i < 3; i++) {
//       Description description = Description(
//         titlee: 'Duyuru Başlığı $i',
//         subtitlee: 'Duyuru Alt Başlığı $i',
//       );
//       descriptionProvider.addDescription(description
