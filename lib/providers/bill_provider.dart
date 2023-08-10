// import 'package:flutter/material.dart';
// import 'package:demo_publicarea/models/bill.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class BillProvider with ChangeNotifier {
//   //static List<Map<String, dynamic>> _bills = [];
//   // Future<List<Map<String, dynamic>>> fetchBill() async {
//   //   var collectionn = FirebaseFirestore.instance.collection('bills');
//   //   print(collectionn);
//   //   List<Map<String, dynamic>> tempList = [];
//   //   var data = await collectionn.get();
//   //   data.docs.forEach((element) {
//   //     tempList.add(element.data());
//   //   });
//   //   return tempList;
//   // }
//   Future<List<Bill>> fetchBillByPaidStatus(bool paidStatus, String apartmentId,
//       {int? limit}) async {
//     var collection = FirebaseFirestore.instance.collection('bills');
//     //print(collection);
//     var query = collection
//         .where("isPaid", isEqualTo: paidStatus)
//         .where("apartmentId", isEqualTo: apartmentId); //.limit(limit != null?);
//     query = limit != null ? query.limit(limit) : query;
//     //en kotu ihtimal
//     List<Bill> bills = [];
//     var data = await query.get();
//     data.docs.forEach((element) {
//       var bill = Bill(
//         id: element.data()['id'],
//         name: element.data()['name'],
//         date: element.data()['date'],
//         amount: element.data()['amount'],
//         isPaid: element.data()['isPaid'],
//         apartmentId: element.data()['apartmentId'],
//       );
//       bills.add(bill);
//     });
//     return bills;
//     // Map<String,Bill> Map(){
//     //   return{
//     //     'bill_uid': BillProvider,
//     //     "name":,
//     //     "date":this._date,
//     //     "amount":this._amount,
//     //     "isPaid":this._paidStatues,
//     //   };
//     // }

//     // //eski duzen fetchbill kismi guncellenmeli(foto var)
//     // List<Map<String, dynamic>> tempList = [];
//     // var data = await query.get();
//     // data.docs.forEach((element) {
//     //   tempList.add(element.data());
//     // });
//     // notifyListeners();
//     // //notify acildiginde liste donguye giriyor
//     // return tempList;
//   }
//   Future<double> fetchAmountTotalStatus(
//       bool paidStatus, String apartmentId) async {
//     var collection = FirebaseFirestore.instance.collection('bills');
//     final query = collection
//         .where("isPaid", isEqualTo: paidStatus)
//         .where("apartmentId", isEqualTo: apartmentId);
//     ;

//     double total = 0;

//     var data = await query.get();
//     data.docs.forEach((bills) {
//       total += bills.data()['amount'];
//     });
//     //notifyListeners();
//     return total;
//   }

//   // Future updateBill(
//   //     double amount, DateTime date, String id, bool isPaid, String name) async {
//   //   try {
//   //     await FirebaseFirestore.instance.collection('bills').doc(id).update(
//   //         {'amount': amount, 'date': date, 'isPaid': isPaid, 'name': name});
//   //     var updateBill = bills.firstWhere((element) => element['id'] == id);
//   //     updateBill['amount'] = amount;
//   //     updateBill['date'] = date;
//   //     updateBill['isPaid'] = isPaid;
//   //     updateBill['name'] = name;
//   //     notifyListeners();
//   //   } catch (e) {
//   //     throw (e);
//   //   }
//   // }
//   //
//   // List<Map<String, dynamic>> get getBills {
//   //   return _bills;
//   // }
// }
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
    // _billStreamController.close();
    super.dispose();
  }
}
