import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_publicarea/models/bill.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class PaymentProvider with ChangeNotifier {
  Future<bool> checkPayment(
    String cardNumber,
    String cardHolderName,
    String cvvCode,
    String expiryDate,
  ) async {
    bool isMatched = false;

    try {
      var collection = FirebaseFirestore.instance.collection('cards');
      var query = collection
          //.where('cardNumber', isEqualTo: cardNumber)
          .where('cardHolderName', isEqualTo: cardHolderName)
          .where('cvvCode', isEqualTo: cvvCode)
          .where('expiryDate', isEqualTo: expiryDate)
          .limit(1);
      var data = await query.get();

      if (data.docs.isNotEmpty) {
        isMatched = true;
      }
    } catch (e) {
      print('Hata: $e.toString()');
    }

    return isMatched;
  }

// Future<void> updateBillPaidStatus(List<Bill> selectedBills) async {
//   bool newValue = true;
//   Timestamp newDate = Timestamp.now();
//   // var db = FirebaseFirestore();
//   var collection = FirebaseFirestore.instance.collection('bills');
//   for (var selectedBill in selectedBills) {
//     DocumentReference documentRef = collection.doc(selectedBill.id);
//     //('id/${selectedBill.id}');
//     //documentRef = collection.doc(selectedBill.id);
//     try {
//       await documentRef.update({
//         'isPaid': newValue,
//         'date': newDate,
//       });
//       print('Belge güncellendi: ${selectedBill.id}');
//     } catch (error) {
//       print('Hata oluştu: ${error.toString()}');
//     }
//   }
// }

  Future<void> updateBillPaidStatus(List<Bill> selectedBills) async {
    bool newValue = true;
    Timestamp newDate = Timestamp.now();
    var collection = FirebaseFirestore.instance.collection('bills');

    for (var selectedBill in selectedBills) {
      QuerySnapshot querySnapshot = await collection
          .where('id', isEqualTo: selectedBill.id)
          .where('isPaid', isEqualTo: false)
          .get();

      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      for (var document in documents) {
        DocumentReference documentRef = collection.doc(document.id);

        try {
          await documentRef.update({
            'isPaid': newValue,
            'date': newDate,
          });
          print('Belge güncellendi: ${document.id}');
        } catch (error) {
          print('Hata oluştu: ${error.toString()}');
        }
      }
    }
  }
}
// // Future<void> updateBillPaidStatus(List<Bill> selectedBills) async {
// //   bool newValue = true;
// //   Timestamp newDate = Timestamp.now();
// //   var collection = FirebaseFirestore.instance.collection('bills');
// //   var billIds = selectedBills.map((bill) => bill.id).toList();

// //   for (var billId in billIds) {
// //     DocumentReference documentRef = collection.doc(billId);
// //     try {
// //       await documentRef.update({
// //         'isPaid': newValue,
// //         'date': newDate,
// //       });
// //       print('Belge güncellendi: $billId');
// //     } catch (error) {
// //       print('Hata oluştu: ${error.toString()}');
// //     }
// //   }
// // }

// // class CardCheckMethods {
// //   final _cardCheck = FirebaseFirestore.instance.collection('cards');

// //   Future<bool> checkCardNumber(String cardNumber) async {
// //     bool isMatched = false;

// //     return isMatched;
// //   }
// // }