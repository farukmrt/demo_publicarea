import 'package:cloud_firestore/cloud_firestore.dart';

class Bill {
  String id;
  String name;
  Timestamp date;
  num amount;
  bool isPaid;
  String apartmentId;
  // bool isSelected;

  Bill({
    required this.id,
    required this.name,
    required this.date,
    required this.amount,
    required this.isPaid,
    required this.apartmentId,
    // this.isSelected = false,
  });
}
