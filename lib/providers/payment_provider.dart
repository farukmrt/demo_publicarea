import 'package:flutter/material.dart';
import 'package:demo_publicarea/models/bill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentProvider with ChangeNotifier {
//firebasedeki kart bilgileri ile fake ödeme yapıyoruz
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
          .where('cardNumber', isEqualTo: cardNumber)
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

//fatura ödemesi yapıldığında durumunu güncelliyoruz
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
