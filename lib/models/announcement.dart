import 'dart:convert';

class Announcement {
  String build_uid;
  String title;
  String subtitle;

  Announcement({
    required this.build_uid,
    required this.title,
    required this.subtitle,
  });

  factory Announcement.fromRawJson(String str) =>
      Announcement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
        build_uid: json["build_uid"],
        title: json["title"],
        subtitle: json["subtitle"],
      );

  Map<String, dynamic> toJson() => {
        "build_uid": build_uid,
        "title": title,
        "subtitle": subtitle,
      };
}
