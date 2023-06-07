import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class NoyaFormatter {
  static String generate(date) {
    initializeDateFormatting('tr', 'TR');
    var outputFormat = DateFormat('dd/MMMM/yyyy', 'tr_TR');
    return outputFormat.format(date);
  }

  static String generateAmount(amount) {
    var outputFormat = NumberFormat.currency(locale: 'tr_TR', symbol: '₺');
    return outputFormat.format(amount);
  }
}








      // Expanded(
      //         child: Consumer<BillProvider>(
      //           builder: (context, provider, _) {
      //             List<Bill> bills = provider.bill;
      //             List<Bill> paidBills =
      //                 bills.where((bill) => bill.isPaid).toList();

      //             if (paidBills.isNotEmpty) {
        //             initializeDateFormatting('tr', 'TR');
        //     final DateFormat dateFormatter = DateFormat('dd MMMM yyyy', 'tr_TR');
        // final NumberFormat amountFormatter = NumberFormat.currency(locale: 'tr_TR', symbol: '₺');
      //               return ListView.builder(
      //                 itemCount: paidBills.length,
      //                 itemBuilder: (context, index) {
      //                   final expName = paidBills[index];
      //                   final frmDate = dateFormatter.format(expName.date);
      //                   final frmAmount =
      //                       amountFormatter.format(expName.amount);
      //                   Bill bill = paidBills[index];
      //                   return CustomListItem(
      //                     title: bill.name,
      //                     subtitle: 'Ödeme Tarihi: $frmDate',
      //                     color: paidc,
      //                     trailing: Text(frmAmount),
      //                     leading: const Icon(
      //                       Icons.receipt_long_outlined,
      //                       color: paidc,
      //                       size: 30,
      //                     ),
      //                   );
      //                 },
      //               );
      //             } else {
      //               return const CustomListItem(
      //                 title: 'Ödenmiş fatura bulunmamaktadır',
      //                 subtitle: 'Lütfen ödeme yapın..',
      //                 color: negative,
      //               );
      //             }
      //           },
      //         ),
      //       ),

   