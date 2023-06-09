// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:demo_publicarea/models/description.dart' as model;

// class DescriptionMethods {
//   final _descriptionRef = FirebaseFirestore.instance.collection('descriptions');


//   Future<Map<String, dynamic>?> getCurrentDescription(String? uid) async {
//     if (uid != null) {
//       final snap = await _descriptionRef.doc(uid).get();
//       return snap.data();
//     }
//     return null;
//   }
// }
