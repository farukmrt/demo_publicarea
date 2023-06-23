import 'package:custom_navigator/custom_navigation.dart';
import 'package:demo_publicarea/providers/bill_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/utils/date_amount_formatter.dart';
import 'package:demo_publicarea/widgets/custom_button.dart';
import 'package:demo_publicarea/widgets/custom_checkbox.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/widgets/custom_subtitle.dart';
import 'package:demo_publicarea/widgets/custom_title.dart';
import 'package:demo_publicarea/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentSelectScreen extends StatefulWidget {
  static String routeName = '/paymentSelect';

  const PaymentSelectScreen({Key? key}) : super(key: key);

  @override
  State<PaymentSelectScreen> createState() => _PaymentSelectScreenState();
}

class _PaymentSelectScreenState extends State<PaymentSelectScreen> {
  // bool? isChecked = false;
  // bool? newBool = true;
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return CustomScaffold(
      children: pages,
      onItemTap: onPageChange,
      scaffold: Scaffold(
        appBar: AppBar(
          title: const Text('Ödemeler'),
          backgroundColor: mainBackgroundColor,
        ),
        // backgroundColor: backgroundColor,
        body: Column(
          children: [
            //const CustomTitle(mainTitle: 'Ödeme'),
            CustomSubtitle(
              title: userProvider.user.building,
            ),
            Expanded(
              child: Consumer<BillProvider>(
                builder: (context, data, index) {
                  return FutureBuilder(
                    future: data.fetchBillByPaidStatus(false),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: LoadingIndicator(),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              var bill = snapshot.data?[index];
                              bool check_bill = false;
                              // return CustomListItem(
                              //   title: bill!['name'],
                              //   subtitle:
                              //       'Son Ödeme T: ${NoyaFormatter.generate(bill['date'])}',
                              //   color: unpaidc,
                              //   trailing: Text(NoyaFormatter.generateAmount(
                              //       bill['amount'])),
                              //   leading: Checkbox(
                              //       value: check_bill,
                              //       activeColor: negative,
                              //       onChanged: (check) {
                              //         setState(() {
                              //           check_bill = check!;
                              //         });
                              //       },
                              //       ),
                              // );

                              // return CheckboxListTile(

                              //   title: bill!['name'],
                              //   // subtitle: Text(
                              //   //     'Son Ödeme T: ${NoyaFormatter.generate(bill['date'])}'),
                              //   //color: unpaidc,
                              //   // secondary: Text(NoyaFormatter.generateAmount(
                              //   //     bill['amount'])),
                              //   controlAffinity:
                              //       ListTileControlAffinity.leading,
                              //   value: check_bill,
                              //   onChanged: (check) {
                              //     setState(() {
                              //       check_bill = check!;
                              //     });
                              //   },
                              // );
                            },
                          );
                        }
                      } else if (snapshot.hasError) {
                        return const Text('no data');
                      }
                      return const LoadingIndicator();
                    },
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              color: mainBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Column(
                  children: [
                    CustomMainButton(
                        onTap: () {},
                        text: 'Devam et >',
                        edgeInsets: const EdgeInsets.symmetric(horizontal: 20)),
                    Row(
                      //mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomIconbutton(
                            title: 'Hizmet\nBedeli',
                            rightText: NoyaFormatter.generateAmount(234),
                            icon: Icons.heart_broken_outlined,
                            size: 60,
                            ontap: () {}),
                        CustomIconbutton(
                            title: 'Toplam\nTutar',
                            rightText: NoyaFormatter.generateAmount(346),
                            icon: Icons.credit_card_outlined,
                            size: 60,
                            ontap: () {})
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
