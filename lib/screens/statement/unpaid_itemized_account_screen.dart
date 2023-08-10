import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/models/bill.dart';
import 'package:demo_publicarea/providers/bill_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/screens/statement/payment_select_screen.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/utils/date_amount_formatter.dart';
import 'package:demo_publicarea/widgets/custom_button.dart';
import 'package:demo_publicarea/widgets/custom_double_button.dart';

import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/widgets/custom_subtitle.dart';

import 'package:demo_publicarea/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
  ScrollController _scrollController = ScrollController();
  PagingController<int, Bill> get pagingController => _pagingController;

  final PagingController<int, Bill> _pagingController =
      PagingController(firstPageKey: 0);

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
    _pagingController.addPageRequestListener((pageKey) {
      billProvider
          .fetchPageBillByPaidStatus(
              false, userProvider.currentUser.apartmentId,
              limit: 6, pageKey: pageKey)
          .listen((tempList) {
        final isLastPage = tempList.length < 6;

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
          // backgroundColor: backgroundColor,
          body: Column(
            children: [
              //const CustomTitle(mainTitle: 'Ödeme'),
              CustomSubtitle(
                title: trnslt.lcod_lbl_unpaid_bills,
                subtitle: userProvider.currentUser.building,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () =>
                      Future.sync(() => _pagingController.refresh()),
                  child: PagedListView<int, Bill>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Bill>(
                      itemBuilder: (context, unpaidBills, index) => Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: CustomListItem(
                          title: unpaidBills.name,
                          subtitle:
                              '${trnslt.lcod_lbl_payment_date_bill} ${NoyaFormatter.generate(unpaidBills.date)}',
                          color: unpaidc,
                          trailing: Text(
                              NoyaFormatter.generateAmount(unpaidBills.amount)),
                          leading: const Icon(
                            Icons.receipt_long_outlined,
                            color: unpaidc,
                            size: 30,
                          ),
                        ),
                      ),
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

                // Consumer<BillProvider>(
                //   builder: (context, data, index) {
                //     return StreamBuilder(
                //       stream: data.fetchPageBillByPaidStatus(
                //           false, userProvider.user.apartmentId,limit: ,pageKey: ),
                //       builder: (BuildContext context, snapshot) {
                //         if (snapshot.hasData) {
                //           if (snapshot.connectionState ==
                //               ConnectionState.waiting) {
                //             return const Center(
                //               child: LoadingIndicator(),
                //             );
                //           } else {
                //             var bill = snapshot.data;
                //             if (bill == null || bill.isEmpty) {
                //               return CustomListItem(
                //                 title: trnslt.lcod_lbl_thanks,
                //                 subtitle: trnslt.lcod_lbl_no_invoice_unpaid,
                //                 color: positive,
                //                 leading: const Icon(
                //                   Icons.done_outline_outlined,
                //                   color: positive,
                //                   size: 40,
                //                 ),
                //               );
                //             } else {
                //               return ListView.builder(
                //                 itemCount: bill.length,
                //                 itemBuilder: (context, index) {
                //                   var unpaidBills = bill[index];
                //                   return CustomListItem(
                //                     title: unpaidBills.name,
                //                     subtitle:
                //                         '${trnslt.lcod_lbl_payment_date_unpaid} ${NoyaFormatter.generate(unpaidBills.date)}',
                //                     color: unpaidc,
                //                     trailing: Text(NoyaFormatter.generateAmount(
                //                         unpaidBills.amount)),
                //                     leading: const Icon(
                //                       Icons.receipt_long_outlined,
                //                       color: unpaidc,
                //                       size: 30,
                //                     ),
                //                   );
                //                 },
                //               );
                //             }
                //           }
                //         } else if (snapshot.hasError) {
                //           return Text(
                //               '${trnslt.lcod_lbl_error_snapshot} ${snapshot.error}');
                //         }
                //         return const LoadingIndicator();
                //       },
                //     );
                //   },
                // ),
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
                          text: trnslt.lcod_lbl_to_pay),
                      Row(
                        //mainAxisSize: MainAxisSize.max,
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //toplam borc ve odenen tutarlari gosterebilmek icin verileri cekiyoruz
                          Container(
                            width: size.width / 2 - 2,
                            child: Consumer<BillProvider>(
                              builder: (context, data, index) {
                                return StreamBuilder<double>(
                                  stream: data.fetchAmountTotalStatus(false,
                                      userProvider.currentUser.apartmentId),
                                  builder: (BuildContext context, snapshot) {
                                    //var bill = snapshot.data?;
                                    if (snapshot.hasData) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: LoadingIndicator(),
                                        );
                                      } else {
                                        return CustomDoubleIconbutton(
                                          color: negative.shade200,
                                          title: trnslt.lcod_lbl_debt,
                                          rightText:
                                              NoyaFormatter.generateAmount(
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
                          ),
                          Container(
                            width: size.width / 2 - 2,
                            child: Consumer<BillProvider>(
                              builder: (context, data, index) {
                                return StreamBuilder<double>(
                                  stream: data.fetchAmountTotalStatus(true,
                                      userProvider.currentUser.apartmentId),
                                  builder: (BuildContext context, snapshot) {
                                    //var bill = snapshot.data?;
                                    if (snapshot.hasData) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: LoadingIndicator(),
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
