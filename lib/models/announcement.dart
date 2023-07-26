import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  final String id;
  final String build_uid;
  final String title;
  final String subtitle;
  final Timestamp date;
  final String imageUrl;

  Announcement({
    required this.id,
    required this.build_uid,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.imageUrl,
  });

  // factory Announcement.fromRawJson(String str) =>
  //     Announcement.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  // factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
  //       build_uid: json["build_uid"],
  //       title: json["title"],
  //       subtitle: json["subtitle"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "build_uid": build_uid,
  //       "title": title,
  //       "subtitle": subtitle,
  //     };
}
