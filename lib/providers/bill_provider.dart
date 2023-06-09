import 'package:demo_publicarea/models/bill.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillProvider with ChangeNotifier {
  List<Bill> bills = [
    Bill(
        name: 'Aidat ödemesi',
        date: DateTime(2021, 6, 12),
        amount: 355.55,
        //  userId: 5,
        isPaid: false),
    Bill(
        name: 'Yakıt ödemesi',
        date: DateTime(2021, 6, 12),
        amount: 849.99,
        isPaid: false),
    Bill(
        name: 'Demirbaş gidrleri',
        date: DateTime(2021, 6, 12),
        amount: 1199.99,
        isPaid: false),
    Bill(
        name: 'Asansör bakımı',
        date: DateTime(2021, 6, 12),
        amount: 275.75,
        isPaid: false),
    Bill(
        name: 'Demirbaş gidrleri',
        date: DateTime(2021, 6, 12),
        amount: 100,
        isPaid: false),
    Bill(
        name: 'Bahçe bakımı',
        date: DateTime(2021, 6, 12),
        amount: 450,
        isPaid: false),
    Bill(
        name: 'Çatı bakımı',
        date: DateTime(2021, 6, 12),
        amount: 858.1,
        isPaid: true),
  ];

  List<Bill> get unpaidBills => bills.where((bill) => !bill.isPaid).toList();
  List<Bill> get paidBills => bills.where((bill) => bill.isPaid).toList();

  // @override
  // Widget build(BuildContext context) {
  //   initializeDateFormatting('tr_TR', null);
  //   final DateFormat dateFormatter = DateFormat('dd MMMM yyyy', 'tr_TR');
  //   final NumberFormat amountFormatter =
  //       NumberFormat.currency(locale: 'tr_TR', symbol: '₺');

  List<Bill> get bill => bills;

  void addBill(Bill bill) {
    bills.add(bill);
    notifyListeners();
  }

  void removeBill(Bill bill) {
    bills.remove(bill);
    notifyListeners();
  }
}





  //  double amountTotal = 0;
  // @override
  // void initState() {
  //   super.initState();
  //   calculateTotalAmount();
  // }

  // void calculateTotalAmount() {
  //   final provider = Provider.of<BillProvider>(context, listen: false);
  //   final unpaidBills = provider.bill.where((bill) => !bill.isPaid).toList();
  //   amountTotal = 0;
  //   unpaidBills.forEach((bill) {
  //     amountTotal += bill.amount;
  //   });
  // }
