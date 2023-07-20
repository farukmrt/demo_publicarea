// import 'package:intl/intl.dart';
// import 'package:flutter/foundation.dart';
// import 'package:demo_publicarea/models/bill.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:demo_publicarea/widgets/custom_main_button.dart';
// import 'package:demo_publicarea/widgets/custom_column_button.dart';
import 'package:demo_publicarea/providers/bill_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/screens/statement/credit_card_screen.dart';
import 'package:demo_publicarea/screens/statement/itemized_account_screen.dart';
import 'package:demo_publicarea/screens/statement/payment_select_screen.dart';
import 'package:demo_publicarea/screens/statement/unpaid_itemized_account_screen.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_button.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:demo_publicarea/widgets/custom_subtitle.dart';
import 'package:demo_publicarea/widgets/custom_text_button.dart';
import 'package:demo_publicarea/widgets/custom_title.dart';
import 'package:demo_publicarea/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../../utils/date_amount_formatter.dart';

class StatementScreen extends StatefulWidget {
  const StatementScreen({Key? key}) : super(key: key);

  @override
  State<StatementScreen> createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {
  @override
  Widget build(BuildContext context) {
    //var outputFormat = DateFormat('MM/dd/yyyy');
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Container(
      color: mainBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: null,
          body: Column(
            children: [
              const CustomTitle(mainTitle: 'Hesap Özeti'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSubtitle(
                    title: 'Ödenmemişler',
                    subtitle: userProvider.user.building,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomTextButton(
                            onTap: () {
                              Navigator.of(context, rootNavigator: false).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UnpaidItemizedAccountScreen(),
                                      maintainState: true));
                            },
                            text: 'Tümünü Gör ->'),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Consumer<BillProvider>(
                  builder: (context, data, index) {
                    return StreamBuilder(
                      stream: data.fetchBillByPaidStatus(
                          false, userProvider.user.apartmentId,
                          limit: 4),
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
                          return Text('Hata: ${snapshot.error}');
                        }
                        return const LoadingIndicator();
                      },
                    );
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
                      const Text('Toplam'),
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
                                  return Text(NoyaFormatter.generateAmount(
                                      snapshot.data));
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
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSubtitle(
                    title: 'Ödenmişler',
                    subtitle: userProvider.user.building,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomTextButton(
                            onTap: () {
                              Navigator.of(context, rootNavigator: false).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ItemizedAccountScreen(),
                                      maintainState: true));
                            },
                            text: 'Tümünü Gör ->'),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Consumer<BillProvider>(
                  builder: (context, data, index) {
                    return StreamBuilder(
                      stream: data.fetchBillByPaidStatus(
                          true, userProvider.user.apartmentId,
                          limit: 4),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: LoadingIndicator(),
                            );
                          } else {
                            return ListView.builder(
                              //son girilen degeri en uste almak istedigim icin listeyi ters cevirdim
                              //reverse: true,
                              itemCount: snapshot.data?.length,
                              //
                              //eger odenen fatura sayisi alttaki degerden az ise
                              //liste asagi kaydirildiginda ustte hata(kirmizilik) cikiyor

                              itemBuilder: (context, index) {
                                var bill = snapshot.data?[index];

                                return CustomListItem(
                                  title: bill!.name,
                                  subtitle: //'Ödeme Tarihi: ${bill.date}',
                                      'Ödeme Tarihi: ${NoyaFormatter.generate(bill.date)}',
                                  color: paidc,
                                  trailing: Text(NoyaFormatter.generateAmount(
                                      bill.amount)),
                                  leading: const Icon(
                                    Icons.receipt_long_outlined,
                                    color: paidc,
                                    size: 30,
                                  ),
                                );
                              },
                            );
                          }
                        } else if (snapshot.hasError) {
                          return Text('Hata: ${snapshot.error}');
                        }
                        return const LoadingIndicator();
                      },
                    );
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
                      onTap: () {},
                    ),
                    CustomIconbutton(
                      title: 'Ödeme Yap',
                      icon: Icons.wallet_outlined,
                      onTap: () {
                        PersistentNavBarNavigator
                            .pushNewScreenWithRouteSettings(
                          context,
                          settings: RouteSettings(
                              name: PaymentSelectScreen.routeName),
                          screen: const PaymentSelectScreen(),
                          withNavBar: true,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },

                      // ontap: () {
                      //   Navigator.of(context, rootNavigator: true).push(
                      //       //rootnavigator sifirdan sayfa olusturma yada üstüne acma özelligi
                      //       //ancak calismiyor
                      //       MaterialPageRoute(
                      //           fullscreenDialog: true,
                      //           builder: (context) => const PaymentSelectScreen(),
                      //           maintainState: true));
                      //   //^^rotanin etkin olmadiginde bellekte kalmasi gerekip gerekmedigi
                      // },

                      // ontap: () {
                      //   Navigator.of(context).push(
                      //     MaterialPageRoute(
                      //       builder: (ctx) => const PaymentSelectScreen(),
                      //     ),
                      //   );
                      // },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
