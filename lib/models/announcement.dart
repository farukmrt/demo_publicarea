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
}
