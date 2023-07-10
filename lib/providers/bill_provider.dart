import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_publicarea/models/bill.dart';

import 'package:flutter/material.dart';

class BillProvider with ChangeNotifier {
  //static List<Map<String, dynamic>> _bills = [];
  // Future<List<Map<String, dynamic>>> fetchBill() async {
  //   var collectionn = FirebaseFirestore.instance.collection('bills');
  //   print(collectionn);
  //   List<Map<String, dynamic>> tempList = [];
  //   var data = await collectionn.get();
  //   data.docs.forEach((element) {
  //     tempList.add(element.data());
  //   });
  //   return tempList;
  // }

  Future<List<Bill>> fetchBillByPaidStatus(bool paidStatus,
      {int? limit}) async {
    var collection = FirebaseFirestore.instance.collection('bills');
    //print(collection);
    var query = collection.where("isPaid",
        isEqualTo: paidStatus); //.limit(limit != null?);
    query = limit != null ? query.limit(limit) : query;
    // if (limit != null) {
    //   query.limit(limit);
    // }

    //en kotu ihtimal
    List<Bill> bills = [];
    var data = await query.get();
    data.docs.forEach((element) {
      var bill = Bill(
        bill_uid: element.data()['id'],
        name: element.data()['name'],
        date: element.data()['date'],
        amount: element.data()['amount'],
        isPaid: element.data()['isPaid'],
      );
      bills.add(bill);
    });
    return bills;

    // Map<String,Bill> Map(){
    //   return{
    //     'bill_uid': BillProvider,
    //     "name":,
    //     "date":this._date,
    //     "amount":this._amount,
    //     "isPaid":this._paidStatues,
    //   };
    // }

    // //eski duzen fetchbill kismi guncellenmeli(foto var)
    // List<Map<String, dynamic>> tempList = [];
    // var data = await query.get();
    // data.docs.forEach((element) {
    //   tempList.add(element.data());
    // });
    // notifyListeners();
    // //notify acildiginde liste donguye giriyor
    // return tempList;
  }

  Future<double> fetchAmountTotalStatus(bool paidStatus) async {
    var collection = FirebaseFirestore.instance.collection('bills');
    final query = collection.where("isPaid", isEqualTo: paidStatus);

    double total = 0;

    var data = await query.get();
    data.docs.forEach((bills) {
      total += bills.data()['amount'];
    });
    //notifyListeners();
    return total;
  }
  // Future updateBill(
  //     double amount, DateTime date, String id, bool isPaid, String name) async {
  //   try {
  //     await FirebaseFirestore.instance.collection('bills').doc(id).update(
  //         {'amount': amount, 'date': date, 'isPaid': isPaid, 'name': name});
  //     var updateBill = bills.firstWhere((element) => element['id'] == id);
  //     updateBill['amount'] = amount;
  //     updateBill['date'] = date;
  //     updateBill['isPaid'] = isPaid;
  //     updateBill['name'] = name;
  //     notifyListeners();
  //   } catch (e) {
  //     throw (e);
  //   }
  // }
  //
  // List<Map<String, dynamic>> get getBills {
  //   return _bills;
  // }
}
