import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String requester;
  String apartmentId;
  String apartmentNumber;
  String requestId;
  String requestTitle;
  String requestExplanation;
  bool status;
  Timestamp requestDate;
  String? imageUrl;
  String requestType;

  Request({
    this.imageUrl,
    required this.requestDate,
    required this.requester,
    required this.requestId,
    required this.requestTitle,
    required this.requestExplanation,
    required this.apartmentNumber,
    required this.status,
    required this.requestType,
    required this.apartmentId,
    //required this.date,
  });
}
