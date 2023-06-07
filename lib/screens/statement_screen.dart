import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_publicarea/models/bill.dart';
import 'package:demo_publicarea/providers/bill_provider.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_button.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/widgets/custom_column_button.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:demo_publicarea/widgets/custom_subtitle.dart';
import 'package:demo_publicarea/widgets/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../utils/date_amount_formatter.dart';

class StatementScreen extends StatefulWidget {
  const StatementScreen({Key? key}) : super(key: key);

  @override
  State<StatementScreen> createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {
  @override
  Widget build(BuildContext context) {
    var outputFormat = DateFormat('MM/dd/yyyy');
    return SafeArea(
      child: Scaffold(
        // backgroundColor: backgroundColor,
        appBar: null,
        body: Column(
          children: [
            const CustomTitle(mainTitle: 'Hesap Özeti'),
            const CustomSubtitle(
              title: 'Ödenmemişler',
              subtitle: 'Hill Tower Göksu Sitesi',
            ),
            Expanded(
              child: Consumer<BillProvider>(
                builder: (context, provider, _) {
                  List<Bill> unpaidBills = provider.unpaidBills;
                  if (unpaidBills.isNotEmpty) {
                    return ListView.builder(
                      itemCount: unpaidBills.length,
                      itemBuilder: (context, index) {
                        Bill bill = unpaidBills[index];
                        return CustomListItem(
                          title: bill.name,
                          subtitle:
                              'Son Ödeme T: ${NoyaFormatter.generate(bill.date)}',
                          color: unpaidc,
                          trailing: Text('${bill.amount}'),
                          leading: const Icon(
                            Icons.receipt_long_outlined,
                            color: unpaidc,
                            size: 30,
                          ),
                        );
                      },
                    );
                  } else {
                    return const CustomListItem(
                      title: 'Ödenmemiş fatura bulunmamaktadır',
                      subtitle: 'Teşekkürler..',
                      color: positive,
                      leading: Icon(
                        Icons.done_outlined,
                        size: 40,
                        color: positive,
                      ),
                    );
                  }
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 40,
              color: mainBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Toplam'),
                    Text('amountTotal'),
                  ],
                ),
              ),
            ),
            const CustomSubtitle(
              title: 'Ödenmişler',
              subtitle: 'Hill Tower Göksu Sitesi',
            ),
            Expanded(
              child: Consumer<BillProvider>(
                builder: (context, provider, _) {
                  List<Bill> paidBills = provider.paidBills;
                  if (paidBills.isNotEmpty) {
                    return ListView.builder(
                      itemCount: paidBills.length,
                      itemBuilder: (context, index) {
                        Bill bill = paidBills[index];
                        return CustomListItem(
                          title: bill.name,
                          subtitle:
                              'Ödeme Tarihi: ${NoyaFormatter.generate(bill.date)}',
                          color: paidc,
                          trailing: Text(
                              '${NoyaFormatter.generateAmount(bill.amount)}'),
                          leading: const Icon(
                            Icons.receipt_long_outlined,
                            color: paidc,
                            size: 30,
                          ),
                        );
                      },
                    );
                  } else {
                    return const CustomListItem(
                      title: 'Ödenmiş fatura bulunmamaktadır',
                      subtitle: 'Lütfen Ödeme Yapın..',
                      color: negative,
                      leading: Icon(
                        Icons.priority_high_outlined,
                        size: 40,
                        color: negative,
                      ),
                    );
                  }
                },
              ),
            ),
            Container(
              color: mainBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomIconbutton(
                    title: 'Hesap Grafiği',
                    icon: Icons.insert_chart_outlined,
                    ontap: () {},
                  ),
                  CustomIconbutton(
                    title: 'Ödeme Yap',
                    icon: Icons.wallet_outlined,
                    ontap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
