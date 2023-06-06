import 'package:demo_publicarea/models/bill.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class BillProvider with ChangeNotifier {
  List<Bill> bills = [
    Bill(
        name: 'Aidat ödemesi',
        date: DateTime(2021, 6, 12),
        amount: 759.35,
        isPaid: false),
    Bill(
        name: 'Aidat ödemesi',
        date: DateTime(2021, 6, 12),
        amount: 759.35,
        isPaid: false),
    Bill(
        name: 'Aidat ödemesi',
        date: DateTime(2021, 6, 12),
        amount: 759.35,
        isPaid: false),
    Bill(
        name: 'Aidat ödemesi',
        date: DateTime(2021, 6, 12),
        amount: 759.35,
        isPaid: false),
    Bill(
        name: 'Aidat ödemesi',
        date: DateTime(2021, 6, 12),
        amount: 759.35,
        isPaid: false),
    Bill(
        name: 'Aidat ödemesi',
        date: DateTime(2021, 6, 12),
        amount: 759.35,
        isPaid: false),
    Bill(
        name: 'Aidat ödemesi',
        date: DateTime(2021, 6, 12),
        amount: 759.35,
        isPaid: false),
    Bill(
        name: 'Yakıt ödemesi',
        date: DateTime(2021, 6, 12),
        amount: 759.35,
        isPaid: false),
    Bill(
        name: 'Demirbaş gidrleri',
        date: DateTime(2021, 6, 12),
        amount: 759.35,
        isPaid: true),
    Bill(
        name: 'Asansör bakımı',
        date: DateTime(2021, 6, 12),
        amount: 759.35,
        isPaid: true),
    Bill(
        name: 'Demirbaş gidrleri',
        date: DateTime(2021, 6, 12),
        amount: 759.35,
        isPaid: true),
    Bill(
        name: 'Asansör bakımı',
        date: DateTime(2021, 6, 12),
        amount: 759.35,
        isPaid: true),
    Bill(
        name: 'Demirbaş gidrleri',
        date: DateTime(2021, 6, 12),
        amount: 759.35,
        isPaid: true),
    Bill(
        name: 'Asansör bakımı',
        date: DateTime(2021, 6, 12),
        amount: 759.35,
        isPaid: true),
    Bill(
        name: 'Demirbaş gidrleri',
        date: DateTime(2021, 6, 12),
        amount: 759.35,
        isPaid: true),
    Bill(
        name: 'Asansör bakımı',
        date: DateTime(2021, 6, 12),
        amount: 759.35,
        isPaid: true),
    Bill(
        name: 'Demirbaş gidrleri',
        date: DateTime(2021, 6, 12),
        amount: 759.35,
        isPaid: true),
    Bill(
        name: 'Asansör bakımı',
        date: DateTime(2021, 6, 12),
        amount: 759.35,
        isPaid: true),
    Bill(
        name: 'Demirbaş gidrleri',
        date: DateTime(2021, 6, 12),
        amount: 759.35,
        isPaid: true),
    Bill(
        name: 'Asansör bakımı',
        date: DateTime(2021, 6, 12),
        amount: 759.35,
        isPaid: true),
    Bill(
        name: 'Demirbaş gidrleri',
        date: DateTime(2021, 6, 12),
        amount: 759.35,
        isPaid: true),
    Bill(
        name: 'Asansör bakımı',
        date: DateTime(2021, 6, 12),
        amount: 759.35,
        isPaid: true),
  ];

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
