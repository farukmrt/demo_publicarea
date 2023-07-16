import 'package:demo_publicarea/providers/bill_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/screens/statement/payment_select_screen.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/utils/date_amount_formatter.dart';
import 'package:demo_publicarea/widgets/custom_button.dart';

import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/widgets/custom_subtitle.dart';

import 'package:demo_publicarea/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnpaidItemizedAccountScreen extends StatefulWidget {
  static String routeName = '/unpaidItemizedAccount';

  const UnpaidItemizedAccountScreen({Key? key}) : super(key: key);

  @override
  State<UnpaidItemizedAccountScreen> createState() =>
      _UnpaidItemizedAccountScreenState();
}

class _UnpaidItemizedAccountScreenState
    extends State<UnpaidItemizedAccountScreen> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      color: mainBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Hesap Dökümü'),
            backgroundColor: mainBackgroundColor,
          ),
          // backgroundColor: backgroundColor,
          body: Column(
            children: [
              //const CustomTitle(mainTitle: 'Ödeme'),
              CustomSubtitle(
                title: 'Ödenmeyen Faturalar',
                subtitle: userProvider.user.building,
              ),
              Expanded(
                child: Consumer<BillProvider>(
                  builder: (context, data, index) {
                    return StreamBuilder(
                      stream: data.fetchBillByPaidStatus(
                          false, userProvider.user.apartmentId),
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

                                return CustomListItem(
                                  title: bill!.name,
                                  subtitle: //'Son Ödeme T: ${bill.date}',
                                      'Son Ödeme T: ${NoyaFormatter.generate(bill.date)}',
                                  color: unpaidc,
                                  trailing: Text(NoyaFormatter.generateAmount(
                                      bill.amount)),
                                  leading: const Icon(
                                    Icons.receipt_long_outlined,
                                    color: unpaidc,
                                    size: 30,
                                  ),
                                );
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
                          edgeInsets: //custommain'e bu deger verilmediginde hata ekrani geliyor
                              const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 8),
                          onTap: () {
                            Navigator.of(context, rootNavigator: false).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PaymentSelectScreen(),
                                    maintainState: true));
                          },
                          icon: Icons.redo_outlined,
                          color: positive.shade400,
                          text: 'Ödeme Yap'),
                      Row(
                        //mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //toplam borc ve odenen tutarlari gosterebilmek icin verileri cekiyoruz
                          Consumer<BillProvider>(
                            builder: (context, data, index) {
                              return StreamBuilder<double>(
                                stream: data.fetchAmountTotalStatus(
                                    false, userProvider.user.apartmentId),
                                builder: (BuildContext context, snapshot) {
                                  //var bill = snapshot.data?;
                                  if (snapshot.hasData) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: LoadingIndicator(),
                                      );
                                    } else {
                                      return CustomIconbutton(
                                        color: negative.shade200,
                                        title: 'Borç',
                                        rightText: NoyaFormatter.generateAmount(
                                            snapshot.data),
                                        icon: Icons.payments_outlined,
                                        size: 60,
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
                          Consumer<BillProvider>(
                            builder: (context, data, index) {
                              return StreamBuilder<double>(
                                stream: data.fetchAmountTotalStatus(
                                    true, userProvider.user.apartmentId),
                                builder: (BuildContext context, snapshot) {
                                  //var bill = snapshot.data?;
                                  if (snapshot.hasData) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: LoadingIndicator(),
                                      );
                                    } else {
                                      return CustomIconbutton(
                                        title: 'Ödenen',
                                        color: positive.shade200,
                                        rightText: NoyaFormatter.generateAmount(
                                            snapshot.data),
                                        icon: Icons.credit_score_outlined,
                                        size: 60,
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
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
