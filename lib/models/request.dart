import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String requestExplanation;
  String apartmentNumber;
  bool status;
  Timestamp date;
  static final List<String> requestTypeList = [
    'Arıza',
    'Soru',
    'Öneri',
    'Şikayet'
  ];

  Request({
    required this.requestExplanation,
    required this.apartmentNumber,
    required this.status,
    required this.date,
  });
}
