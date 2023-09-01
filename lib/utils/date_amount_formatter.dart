import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoyaFormatter {
  static String generate(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    initializeDateFormatting('tr', 'TR');
    var outputFormat = DateFormat('dd/MM/yyyy', 'tr_TR');
    return outputFormat.format(date);
  }

  static String generateDetail(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    initializeDateFormatting('tr', 'TR');
    var outputFormat = DateFormat('dd/MM/yyyy hh:mm', 'tr_TR');
    return outputFormat.format(date);
  }

  static String generateAmount(dynamic amount) {
    var outputFormat = NumberFormat.currency(locale: 'tr_TR', symbol: '₺');
    return outputFormat.format(amount);
  }
}
