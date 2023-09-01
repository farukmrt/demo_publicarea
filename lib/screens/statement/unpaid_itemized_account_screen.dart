import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_publicarea/models/bill.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:demo_publicarea/widgets/custom_subtitle.dart';
import 'package:demo_publicarea/providers/bill_provider.dart';
import 'package:demo_publicarea/widgets/custom_checkbox.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/widgets/loading_indicator.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/utils/date_amount_formatter.dart';
import 'package:demo_publicarea/widgets/custom_double_button.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:demo_publicarea/screens/statement/credit_card_screen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class UnpaidItemizedAccountScreen extends StatefulWidget {
  static String routeName = '/unpaidItemizedAccount';

  const UnpaidItemizedAccountScreen({Key? key}) : super(key: key);

  @override
  State<UnpaidItemizedAccountScreen> createState() =>
      _UnpaidItemizedAccountScreenState();
}

class _UnpaidItemizedAccountScreenState
    extends State<UnpaidItemizedAccountScreen> {
  PagingController<int, Bill> get pagingController => _pagingController;
  final PagingController<int, Bill> _pagingController =
      PagingController(firstPageKey: 0);

  List<Bill> selectedBill =
      []; // liste olarak kredi kartı sayfasına verileri gönderdiğimiz değişken
  late num summary = 0; //listenin tutarının toplamını tutan değişken
  List<Bill> selectBill = []; //tek fatura gönderildiğindebu değer gönderiliyor
  num amountt =
      0; //genel yapının bozulmaması adına tekli faturayı da listeye ekleyip gönderiyoruz
  //Queue<Bill> newQ = Queue();

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    BillProvider billProvider = Provider.of<BillProvider>(context);
    // Future<double> SummaryT = billProvider.fetchAmountTotalStatus(
    //     true, userProvider.currentUser.apartmentId);
    // Future<double> SummaryF = billProvider.fetchAmountTotalStatus(
    //     false, userProvider.currentUser.apartmentId);
    //var _SummaryF;
    // Future<void> sumF() async {
    //   final SummayF = await billProvider.fetchAmountTotalStatus(
    //       false, userProvider.currentUser.apartmentId);
    //   final String SummaryF = await SummayF.toString();
    //   setState(() => _SummaryF = SummayF);
    // }

    _pagingController.addPageRequestListener((pageKey) {
      billProvider
          .fetchPageBillByPaidStatus(
              false, userProvider.currentUser.apartmentId,
              limit: 6, pageKey: pageKey)
          .listen((tempList) {
        final isLastPage = tempList.length < 6;

        _pagingController.itemList = [];

        if (isLastPage) {
          _pagingController.appendLastPage(tempList);
        } else {
          final nextPageKey = pageKey + 1;

          _pagingController.appendPage(tempList, nextPageKey);
        }
        print('Value from controller: $pageKey');
      });
    });

    final size = MediaQuery.of(context).size;
    var trnslt = AppLocalizations.of(context)!;

    return Container(
      color: mainBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(trnslt.lcod_lbl_statement),
            backgroundColor: mainBackgroundColor,
          ),
          body: Column(
            children: [
              CustomSubtitle(
                title: trnslt.lcod_lbl_unpaid_bills,
                subtitle: userProvider.currentUser.building,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () =>
                      Future.sync(() => _pagingController.refresh()),
                  child: PagedListView<int, Bill>(
                    //scrollController: _scrollController,
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Bill>(
                      itemBuilder: (context, unpaidBills, index) {
                        return Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: GestureDetector(
                            onLongPress: () {
                              amountt = unpaidBills.amount;
                              selectBill.add(unpaidBills);
                              print(NoyaFormatter.generateAmount(amountt));
                              PersistentNavBarNavigator
                                  .pushNewScreenWithRouteSettings(
                                context,
                                settings: RouteSettings(
                                  name: CreditCardScreen.routeName,
                                  arguments: {
                                    'amount':
                                        NoyaFormatter.generateAmount(amountt),
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
                            child: CustomCheckBoxListItem(
                              title: unpaidBills.name,
                              subtitle:
                                  '${trnslt.lcod_lbl_payment_date_bill} ${NoyaFormatter.generate(unpaidBills.date)}',
                              color: unpaidc,
                              leading: Text(NoyaFormatter.generateAmount(
                                  unpaidBills.amount)),
                              valuee: selectedBill
                                  .any((value) => value.id == unpaidBills.id),
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value == true) {
                                    selectedBill.add(unpaidBills);
                                  } else if (value == false) {
                                    selectedBill.removeWhere((templist) =>
                                        templist.id == unpaidBills.id);
                                  }
                                  //summary sorunsuz
                                  summary = selectedBill.fold<num>(
                                      0, (sum, bill) => sum + bill.amount);
                                  print(NoyaFormatter.generateAmount(summary));
                                });
                              },
                            ),
                          ),
                        );
                      },
                      noItemsFoundIndicatorBuilder: (context) => CustomListItem(
                        title: trnslt.lcod_lbl_thanks,
                        subtitle: trnslt.lcod_lbl_no_invoice_unpaid,
                        color: positive,
                        leading: const Icon(
                          Icons.done_outline_outlined,
                          color: positive,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              StatefulBuilder(
                builder: (context, setState) => Container(
                  width: double.infinity,
                  color: mainBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomMainButton(
                                edgeInsets: //custommain'e bu deger verilmediginde hata ekrani geliyor
                                    const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 8),
                                onTap: () {
                                  if (summary > 0) {
                                    PersistentNavBarNavigator
                                        .pushNewScreenWithRouteSettings(
                                      context,
                                      settings: RouteSettings(
                                        name: CreditCardScreen.routeName,
                                        arguments: {
                                          'summary':
                                              NoyaFormatter.generateAmount(
                                                  summary),
                                          'selectedBill': selectedBill,
                                        },
                                      ),
                                      screen: const CreditCardScreen(
                                        arguments: {},
                                      ),
                                      withNavBar: true,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                    );
                                  }
                                },
                                icon: Icons.redo_outlined,
                                color:
                                    summary == 0 ? Colors.grey : primaryColor,
                                text:
                                    '${trnslt.lcod_lbl_to_pay} ${NoyaFormatter.generateAmount(summary)}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //toplam borc ve odenen tutarlari gosterebilmek icin verileri cekiyoruz
                            Positioned(
                              top: 0,
                              child: Container(
                                width: size.width / 2 - 2,
                                child: Consumer<BillProvider>(
                                  builder: (context, data, index) {
                                    return FutureBuilder<double>(
                                      future: data.fetchAmountTotalStatus(false,
                                          userProvider.currentUser.apartmentId),
                                      builder:
                                          (BuildContext context, snapshot) {
                                        //var bill = snapshot.data?;
                                        if (snapshot.hasData) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return CustomDoubleIconbutton(
                                              color: negative.shade200,
                                              title: trnslt.lcod_lbl_debt,
                                              rightText:
                                                  NoyaFormatter.generateAmount(
                                                      snapshot.data),
                                              icon: Icons.payments_outlined,
                                              size: 60,
                                            );
                                          } else {
                                            return CustomDoubleIconbutton(
                                              color: negative.shade200,
                                              title: trnslt.lcod_lbl_debt,
                                              rightText: snapshot.hasData
                                                  ? NoyaFormatter
                                                      .generateAmount(
                                                          snapshot.data)
                                                  : '',
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
                              ),
                            ),

                            Positioned(
                              top: 0,
                              child: Container(
                                width: size.width / 2 - 2,
                                child: Consumer<BillProvider>(
                                  builder: (context, data, index) {
                                    return FutureBuilder<double>(
                                      future: data.fetchAmountTotalStatus(true,
                                          userProvider.currentUser.apartmentId),
                                      builder:
                                          (BuildContext context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.connectionState !=
                                              ConnectionState.waiting) {
                                            return CustomDoubleIconbutton(
                                              title: trnslt.lcod_lbl_paid,
                                              color: positive.shade200,
                                              rightText: snapshot.hasData
                                                  ? NoyaFormatter
                                                      .generateAmount(
                                                          snapshot.data)
                                                  : '',
                                              icon: Icons.credit_score_outlined,
                                              size: 60,
                                            );
                                          } else {
                                            return CustomDoubleIconbutton(
                                              title: trnslt.lcod_lbl_paid,
                                              color: positive.shade200,
                                              rightText:
                                                  NoyaFormatter.generateAmount(
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
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
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
