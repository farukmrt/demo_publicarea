import 'package:demo_publicarea/models/bill.dart';
import 'package:demo_publicarea/providers/bill_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/screens/main/tabs_screen.dart';
import 'package:demo_publicarea/screens/statement/credit_card_screen.dart';
import 'package:demo_publicarea/screens/statement/statement_screen.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/utils/date_amount_formatter.dart';
import 'package:demo_publicarea/widgets/custom_button.dart';
import 'package:demo_publicarea/widgets/custom_checkbox.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
//import 'package:demo_publicarea/widgets/custom_checkbox.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/widgets/custom_subtitle.dart';
//import 'package:demo_publicarea/widgets/custom_title.dart';
import 'package:demo_publicarea/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class PaymentSelectScreen extends StatefulWidget {
  static String routeName = '/paymentSelect';

  const PaymentSelectScreen({Key? key}) : super(key: key);

  @override
  State<PaymentSelectScreen> createState() => _PaymentSelectScreenState();
}

String _totalSelected(List<Bill> selectedBill) {
  double totalAmount = selectedBill.fold<double>(
    0,
    (sum, bill) => sum + bill.amount,
  );
  return NoyaFormatter.generateAmount(totalAmount);
}

class _PaymentSelectScreenState extends State<PaymentSelectScreen> {
  //final TextEditingController summaryController = TextEditingController();

  List<Bill> selectedBill = [];
  num summary = 0;
  //bool isChecked = false;
  // bool? isChecked = false;
  // bool? newBool = true;
  @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   summaryController.dispose();
  //   super.dispose();
  // }
  // void initState() {
  //   slimyCard.stream.listen((value) {
  //     if (value) {
  //       handleFuture();
  //     }
  //   });
  //   super.initState();
  // }
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      color: mainBackgroundColor,
      child: SafeArea(
        child: Scaffold(
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
                                // return CustomListItem(
                                //   title: bill!.name,
                                //   subtitle:
                                //       'Son Ödeme T: ${NoyaFormatter.generate(bill.date)}',
                                //   color: unpaidc,
                                //   trailing: Text(
                                //       NoyaFormatter.generateAmount(bill.amount)),
                                //   leading: Checkbox(
                                //       value: bill.isChecked,
                                //       onChanged: (bool? value) {
                                //         setState(() {
                                //           bill.isChecked = value!;
                                //         });
                                //       }),
                                // );
                                return CustomCheckBoxListItem(
                                  title: bill!.name,
                                  subtitle: //'Son Ödeme T: ${bill.date}',
                                      'Son Ödeme T: ${NoyaFormatter.generate(bill.date)}',
                                  color: unpaidc,
                                  leading: Text(NoyaFormatter.generateAmount(
                                      bill.amount)),
                                  //valuee: selectedBill.contains(bill),

                                  valuee: selectedBill
                                      .any((element) => element.id == bill.id),
                                  mainList: bill,
                                  // onChanged: (bool) {},

                                  // onChanged: (bool? value) {
                                  // if (value == true) {
                                  //   selectedList.add(mainList);
                                  // } else if (value == false) {
                                  //   selectedList.remove(mainList);
                                  // }
                                  // },

                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value == true) {
                                        selectedBill.add(bill);
                                      } else if (value == false) {
                                        selectedBill.removeWhere(
                                            (element) => element.id == bill.id);
                                      }
                                      //(_buildTotalAmountWidget(selectedBill));
                                      summary = selectedBill.fold<num>(
                                          0, (sum, bill) => sum + bill.amount);

                                      // print(summary);
                                      print(NoyaFormatter.generateAmount(
                                          summary));
                                    });
                                  },
                                );
                                // return CheckboxListTile(
                                //   title: Text(bill!.name),
                                //   subtitle: Text(
                                //       'Son Ödeme T: ${NoyaFormatter.generate(bill.date)}'),
                                //   //color: unpaidc,
                                //   secondary: Text(
                                //       NoyaFormatter.generateAmount(bill.amount)),
                                //   controlAffinity:
                                //       ListTileControlAffinity.leading,
                                //   value: bill.isChecked,
                                //   onChanged: (bool? check) {
                                //     setState(() {
                                //       bill.isChecked = check!;
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
                        onTap: () {
                          PersistentNavBarNavigator
                              .pushNewScreenWithRouteSettings(
                            context,
                            settings: RouteSettings(
                                name: CreditCardScreen.routeName,
                                arguments: {
                                  'summary':
                                      NoyaFormatter.generateAmount(summary),
                                  'selectedBill': selectedBill,
                                }),
                            screen: const CreditCardScreen(
                              arguments: {},
                            ),
                            withNavBar: true,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        icon: Icons.start_outlined,
                        text: 'Devam et ',
                        edgeInsets: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      Row(
                        //mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                                        title: 'Toplam\nTutar',
                                        rightText: NoyaFormatter.generateAmount(
                                            snapshot.data),
                                        icon: Icons.receipt_outlined,
                                        size: 60,
                                        // ontap: () {}
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

                          // return Text( NoyaFormatter.generateAmount(selectedBill
                          //     .fold<num>(0, (sum, bill) => sum + bill.amount))),
                          // TextField(
                          //   onChanged: (value) {
                          //     setState(() {
                          //       summary;
                          //     });
                          //   },
                          //   decoration: InputDecoration(hintText: '2345'),
                          // ),
                          //Text(_totalSelected(selectedBill)),
                          // TextField(
                          //   onChanged: (val) {
                          //     setState(() {
                          //       summary = val as num;
                          //     });
                          //   },
                          // ),

                          //Text('${NoyaFormatter.generateAmount(summary)}'),
                          CustomIconbutton(
                            title: 'Seçilen\nTutar',
                            rightText: (NoyaFormatter.generateAmount(summary)),
                            icon: Icons.credit_card_outlined,
                            size: 60,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),

          // bottomNavigationBar: BottomNavigationBar(
          //   selectedItemColor: buttonColor,
          //   unselectedItemColor: mainColor,
          //   showUnselectedLabels: false,
          //   onTap: onPageChange,
          //   currentIndex: _page,
          //   items: bottomNavigationBarItems,
          // ),

          //bottomNavigationBar: const StatementScreen(),
        ),
      ),
    );
  }
}
