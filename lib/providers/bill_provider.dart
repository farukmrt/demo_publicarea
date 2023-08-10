import 'dart:async';

import 'package:flutter/material.dart';
import 'package:demo_publicarea/models/bill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BillProvider with ChangeNotifier {
  final _billStreamController = StreamController<List<Bill>>.broadcast();
  Stream<List<Bill>> get billStream => _billStreamController.stream;

  DocumentSnapshot? lastdocument;
  final List<Bill> _bills = [];
  List<Bill> get bills => _bills;

//ödenmişlik durumuna göre anlık veri gösterimi için kullanıyoruz
  Stream<List<Bill>> fetchBillByPaidStatus(bool paidStatus, String apartmentId,
      {int? limit}) {
    var collection = FirebaseFirestore.instance.collection('bills');
    var query = collection
        .where("isPaid", isEqualTo: paidStatus)
        .where("apartmentId", isEqualTo: apartmentId);

    query = limit != null ? query.limit(limit) : query;

    return query.snapshots().map((querySnapshot) {
      List<Bill> bills = [];
      querySnapshot.docs.forEach((element) {
        var bill = Bill(
          id: element.data()['id'],
          name: element.data()['name'],
          date: element.data()['date'],
          amount: element.data()['amount'],
          isPaid: element.data()['isPaid'],
          apartmentId: element.data()['apartmentId'],
        );
        bills.add(bill);
      });
      return bills;
    });
  }

//ödenmişlik durumuna göre paging yapısını kullandığımız yerlerde kullanıyoruz
  Stream<List<Bill>> fetchPageBillByPaidStatus(
      bool paidStatus, String apartmentId,
      {int? limit, int? pageKey}) async* {
    var collection = FirebaseFirestore.instance.collection('bills');
    var query = collection
        .where("isPaid", isEqualTo: paidStatus)
        .where("apartmentId", isEqualTo: apartmentId);

    query = limit != null ? query.limit(limit) : query;
    if (pageKey != null) {
      if (pageKey > 0) {
        query = query.startAfterDocument(lastdocument!);
      }
    }
    var querySnapshot = await query.get();
    List<Bill> templist = [];
    var documents = querySnapshot.docs;
    if (documents.isNotEmpty) {
      lastdocument = documents[documents.length - 1];
      documents.forEach(
        (element) {
          var bill = Bill(
            id: element.data()['id'],
            name: element.data()['name'],
            date: element.data()['date'],
            amount: element.data()['amount'],
            isPaid: element.data()['isPaid'],
            apartmentId: element.data()['apartmentId'],
          );
          templist.add(bill);
        },
      );
    }
    yield templist;
  }

//toplam fatura tutarını alıyoruz
  Stream<double> fetchAmountTotalStatus(bool paidStatus, String apartmentId) {
    var collection = FirebaseFirestore.instance.collection('bills');
    final query = collection
        .where("isPaid", isEqualTo: paidStatus)
        .where("apartmentId", isEqualTo: apartmentId);

    return query.snapshots().map((querySnapshot) {
      double total = 0;
      querySnapshot.docs.forEach((bills) {
        total += bills.data()['amount'];
      });
      return total;
    });
  }

  @override
  void dispose() {
    _billStreamController.close();
    super.dispose();
  }
}
