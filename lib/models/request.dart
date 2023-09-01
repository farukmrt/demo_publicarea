import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String requester;
  String apartmentId;
  String apartmentNumber;
  String requestId;
  String requestTitle;
  String requestExplanation;
  bool status;
  bool isPositive;
  Timestamp requestDate;
  String? imageUrl;
  String requestType;
  String resultDescription;

  Request({
    this.imageUrl,
    required this.requestDate,
    required this.requester,
    required this.requestId,
    required this.requestTitle,
    required this.requestExplanation,
    required this.apartmentNumber,
    required this.status,
    required this.isPositive,
    required this.requestType,
    required this.apartmentId,
    required this.resultDescription,
    //required this.date,
  });
}
