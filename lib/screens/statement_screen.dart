import 'package:demo_publicarea/models/bill.dart';
import 'package:demo_publicarea/providers/bill_provider.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_button.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:demo_publicarea/widgets/custom_subtitle.dart';
import 'package:demo_publicarea/widgets/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_http_request.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class StatementScreen extends StatefulWidget {
  const StatementScreen({Key? key}) : super(key: key);

  @override
  State<StatementScreen> createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        // appBar: null,
        // body: Column(
        //   children: [
        //     const CustomTitle(mainTitle: 'Hesap Özeti'),
        //     const CustomSubtitle(
        //       title: 'Ödenmemişler',
        //       subtitle: 'Hill Tower Göksu Sitesi',
        //     ),
//             Expanded(
//               child: Consumer<BillProvider>(
//                 builder: (context, provider, _) {
//                   List<Bill> bills = provider.bill;
//                   List<Bill> unpaidBills =
//                       bills.where((bill) => !bill.isPaid).toList();

//                   if (unpaidBills.isNotEmpty) {
//                     // initializeDateFormatting('tr', 'TR');
//                     // final DateFormat dateFormatter =
//                     //     DateFormat('dd MMMM yyyy', 'tr_TR');
//                     // final NumberFormat amountFormatter =
//                     //     NumberFormat.currency(locale: 'tr_TR', symbol: '₺');
//                     return ListView.builder(
//                       itemCount: unpaidBills.length,
//                       itemBuilder: (context, index) {
//                         // final expName = unpaidBills[index];
//                         // final frmDate = dateFormatter.format(expName.date);
//                         // final frmAmount =
//                         //     amountFormatter.format(expName.amount);
//                         Bill bill = unpaidBills[index];
//                         return CustomListItem(
//                           title: bill.name,
//                           subtitle: bill.date.toString(),
//                           trailing: Text(bill.amount.toString()),
//                           leading: const Icon(Icons.receipt_long_outlined),
//                         );
//                       },
//                     );
//                   } else {
//                     return const CustomListItem(
//                       title: 'Ödenmemiş fatura bulunmamaktadır',
//                       subtitle: 'Teşekkürler..',
//                     );
//                   }
//                 },
//               ),
//             ),
//             const CustomTitle(mainTitle: 'toplam'),
//             const CustomSubtitle(
//               title: 'Ödenmişler',
//               subtitle: 'Hill Tower Göksu Sitesi',
//             ),
//             Expanded(
//               child: Consumer<BillProvider>(
//                 builder: (context, provider, _) {
//                   List<Bill> bills = provider.bill;
//                   List<Bill> paidBills =
//                       bills.where((bill) => bill.isPaid).toList();

//                   if (paidBills.isNotEmpty) {
//                     return ListView.builder(
//                       itemCount: paidBills.length,
//                       itemBuilder: (context, index) {
//                         Bill bill = paidBills[index];
//                         return CustomListItem(
//                           title: bill.name,
//                           subtitle: bill.date.toString(),
//                           trailing: Text(bill.amount.toString()),
//                           leading: const Icon(Icons.receipt_long_outlined),
//                         );
//                       },
//                     );
//                   } else {
//                     return const CustomListItem(
//                         title: 'Ödenmiş fatura bulunmamaktadır',
//                         subtitle: 'Lütfen ödeme yapın..');
//                   }
//                 },
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [],
//             ),
        //   ],
        // ),
      ),
    );
  }
}
