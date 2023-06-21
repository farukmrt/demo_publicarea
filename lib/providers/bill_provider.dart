import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:demo_publicarea/models/bill.dart';
//import 'package:demo_publicarea/utils/colors.dart';
//import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

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

  Future<List<Map<String, dynamic>>> fetchBillByPaidStatus(
      bool paidStatus) async {
    var collection = FirebaseFirestore.instance.collection('bills');
    //print(collection);

    final query = collection.where("isPaid", isEqualTo: paidStatus);

    List<Map<String, dynamic>> tempList = [];
    var data = await query.get();
    data.docs.forEach((element) {
      tempList.add(element.data());
    });
    // notifyListeners();
    //notify acildiginde liste donguye giriyor
    return tempList;
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
