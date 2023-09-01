import 'dart:async';
import 'package:demo_publicarea/screens/statement/credit_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/date_amount_formatter.dart';
import 'package:demo_publicarea/models/bill.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_title.dart';
import 'package:demo_publicarea/widgets/custom_button.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:demo_publicarea/widgets/custom_subtitle.dart';
import 'package:demo_publicarea/providers/bill_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/widgets/loading_indicator.dart';
import 'package:demo_publicarea/widgets/custom_text_button.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:demo_publicarea/screens/statement/itemized_account_screen.dart';
import 'package:demo_publicarea/screens/statement/unpaid_itemized_account_screen.dart';

class StatementScreen extends StatefulWidget {
  const StatementScreen({Key? key}) : super(key: key);

  @override
  State<StatementScreen> createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {
  void _refreshData() {
    _pagingControllerFalse.refresh();
    _pagingControllerTrue.refresh();
  }

//ScrollController _scrollController = ScrollController();

  PagingController<int, Bill> get pagingControllerTrue => _pagingControllerTrue;
  final PagingController<int, Bill> _pagingControllerTrue =
      PagingController(firstPageKey: 0);

  PagingController<int, Bill> get pagingControllerFalse =>
      _pagingControllerFalse;
  final PagingController<int, Bill> _pagingControllerFalse =
      PagingController(firstPageKey: 0);

  StreamSubscription<List<Bill>>? _billStreamSubscription;
  // ignore: unused_field
  List<Bill> _bills = [];

  @override
  void initState() {
    super.initState();
    _refreshData();
    _billStreamSubscription = BillProvider().billStream.listen((bills) {
      setState(() {
        _bills = bills;
      });
    });
  }

  List<Bill> selectedBill =
      []; //liste olarak kredi kartı sayfasına verileri gönderdiğimiz değişken
  num summary = 0; //listenin tutarının toplamını tutan değişken
  num? amountt; //tek fatura gönderildiğinde bu değer gönderiliyor
  List<Bill> selectBill =
      []; //genel yapının bozulmaması adına tekli faturayı da listeye ekleyip gönderiyoruz

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    BillProvider billProviderT = Provider.of<BillProvider>(context);
    BillProvider billProviderF = Provider.of<BillProvider>(context);
    // BillProvider billProvider =
    //     Provider.of<BillProvider>(context, listen: true);

    _pagingControllerTrue.addPageRequestListener((pageKey) {
      billProviderT
          .fetchPageBillByPaidStatus(true, userProvider.currentUser.apartmentId,
              limit: 6, pageKey: pageKey)
          .listen((tempList) {
        final isLastPage = tempList.length < 6;

        if (isLastPage) {
          _pagingControllerTrue.appendLastPage(tempList);
        } else {
          final nextPageKey = pageKey + 1;

          _pagingControllerTrue.appendPage(tempList, nextPageKey);
        }
        print('Value from controller: $pageKey');
      });
    });

    _pagingControllerFalse.addPageRequestListener((pageKey) {
      billProviderF
          .fetchPageBillByPaidStatus(
              false, userProvider.currentUser.apartmentId,
              limit: 6, pageKey: pageKey)
          .listen((tempList) {
        final isLastPage = tempList.length < 6;

        if (isLastPage) {
          _pagingControllerFalse.appendLastPage(tempList);
        } else {
          final nextPageKey = pageKey + 1;

          _pagingControllerFalse.appendPage(tempList, nextPageKey);
        }
        print('Value from controller: $pageKey');
      });
    });

    setState(() {
      _refreshData();
    });

    final size = MediaQuery.of(context).size;

    var trnslt = AppLocalizations.of(context)!;

    return Container(
      color: mainBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: null,
          body: Column(
            children: [
              CustomTitle(mainTitle: trnslt.lcod_lbl_statement_screen),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSubtitle(
                    title: trnslt.lcod_lbl_statement_unpaid,
                    subtitle: userProvider.currentUser.building,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomTextButton(
                            onTap: () {
                              PersistentNavBarNavigator
                                  .pushNewScreenWithRouteSettings(
                                context,
                                settings: RouteSettings(
                                    name:
                                        UnpaidItemizedAccountScreen.routeName),
                                screen: const UnpaidItemizedAccountScreen(),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            text: trnslt.lcod_lbl_see_all),
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
                          false, userProvider.currentUser.apartmentId,
                          limit: 4),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: LoadingIndicator(),
                            );
                          } else {
                            var bill = snapshot.data;
                            if (bill == null || bill.isEmpty) {
                              return CustomListItem(
                                title: trnslt.lcod_lbl_thanks,
                                subtitle: trnslt.lcod_lbl_no_invoice_unpaid,
                                color: positive,
                                leading: const Icon(
                                  Icons.done_outline_outlined,
                                  color: positive,
                                  size: 40,
                                ),
                              );
                            } else {
                              return ListView.builder(
                                itemCount: bill.length,
                                itemBuilder: (context, index) {
                                  var unpaidBills = bill[index];
                                  return GestureDetector(
                                    onTap: () {
                                      amountt = unpaidBills.amount;
                                      selectBill.add(unpaidBills);

                                      print(NoyaFormatter.generateAmount(
                                          amountt));
                                      PersistentNavBarNavigator
                                          .pushNewScreenWithRouteSettings(
                                        context,
                                        settings: RouteSettings(
                                          name: CreditCardScreen.routeName,
                                          arguments: {
                                            'amount':
                                                NoyaFormatter.generateAmount(
                                                    amountt),
                                            'selectBill': selectBill,
                                          },
                                        ),
                                        screen: const CreditCardScreen(
                                          arguments: {},
                                        ),
                                        withNavBar: true,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      );
                                    },
                                    child: CustomListItem(
                                      title: unpaidBills.name,
                                      subtitle:
                                          '${trnslt.lcod_lbl_payment_date_bill} ${NoyaFormatter.generate(unpaidBills.date)}',
                                      color: unpaidc,
                                      trailing: Text(
                                          NoyaFormatter.generateAmount(
                                              unpaidBills.amount)),
                                      leading: const Icon(
                                        Icons.receipt_long_outlined,
                                        color: unpaidc,
                                        size: 30,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          }
                        } else if (snapshot.hasError) {
                          return Text(
                              '${trnslt.lcod_lbl_error_snapshot} ${snapshot.error}');
                        }
                        return const LoadingIndicator();
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width / 80),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: mainBackgroundColor),
                  width: double.infinity,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(trnslt.lcod_lbl_statement_total),
                        Consumer<BillProvider>(
                          builder: (context, data, index) {
                            return FutureBuilder<double>(
                              future: data.fetchAmountTotalStatus(
                                  false, userProvider.currentUser.apartmentId),
                              builder: (BuildContext context, snapshot) {
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSubtitle(
                    title: trnslt.lcod_lbl_statement_paid,
                    subtitle: userProvider.currentUser.building,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomTextButton(
                            onTap: () {
                              PersistentNavBarNavigator
                                  .pushNewScreenWithRouteSettings(
                                context,
                                settings: RouteSettings(
                                    name: ItemizedAccountScreen.routeName),
                                screen: const ItemizedAccountScreen(),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            text: trnslt.lcod_lbl_see_all),
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
                          true, userProvider.currentUser.apartmentId,
                          limit: 4),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: LoadingIndicator(),
                            );
                          } else {
                            var bill = snapshot.data;
                            if (bill == null || bill.isEmpty) {
                              return CustomListItem(
                                title: trnslt.lcod_lbl_payment_bill,
                                subtitle: trnslt.lcod_lbl_no_invoice_paid,
                                color: unpaidc,
                                leading: const Icon(
                                  Icons.priority_high_outlined,
                                  color: unpaidc,
                                  size: 40,
                                ),
                              );
                            } else {
                              return ListView.builder(
                                itemCount: bill.length,
                                itemBuilder: (context, index) {
                                  var paidBills = bill[index];
                                  return CustomListItem(
                                    title: paidBills.name,
                                    subtitle:
                                        '${trnslt.lcod_lbl_payment_date_paid} ${NoyaFormatter.generate(paidBills.date)}',
                                    color: paidc,
                                    trailing: Text(NoyaFormatter.generateAmount(
                                        paidBills.amount)),
                                    leading: const Icon(
                                      Icons.receipt_long_outlined,
                                      color: paidc,
                                      size: 30,
                                    ),
                                  );
                                },
                              );
                            }
                          }
                        } else if (snapshot.hasError) {
                          return Text(
                              '${trnslt.lcod_lbl_error_snapshot} ${snapshot.error}');
                        }
                        return const LoadingIndicator();
                      },
                    );
                  },
                ),
              ),
              Container(
                width: size.width,
                color: mainBackgroundColor,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: size.width / 2,
                      child: CustomIconbutton(
                        textAlign: TextAlign.center,
                        title: trnslt.lcod_lbl_statement,
                        icon: Icons.insert_chart_outlined,
                        onTap: () {},
                      ),
                    ),
                    Container(
                      width: size.width / 2,
                      child: CustomIconbutton(
                        textAlign: TextAlign.center,
                        title: trnslt.lcod_lbl_to_pay,
                        icon: Icons.wallet_outlined,
                        onTap: () {
                          PersistentNavBarNavigator
                              .pushNewScreenWithRouteSettings(
                            context,
                            settings: RouteSettings(
                                name: UnpaidItemizedAccountScreen.routeName),
                            screen: const UnpaidItemizedAccountScreen(),
                            withNavBar: true,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                      ),
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

  @override
  void dispose() {
    _billStreamSubscription?.cancel();
    super.dispose();
  }
}
