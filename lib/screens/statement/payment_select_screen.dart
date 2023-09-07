import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_publicarea/models/bill.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/providers/bill_provider.dart';
import 'package:demo_publicarea/widgets/custom_checkbox.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:demo_publicarea/widgets/custom_subtitle.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/widgets/loading_indicator.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/utils/date_amount_formatter.dart';
import 'package:demo_publicarea/widgets/custom_double_button.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:demo_publicarea/screens/statement/credit_card_screen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
  //ScrollController _scrollController = ScrollController();

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

  List<Bill> selectedBill = [];
  num summary = 0;

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

    var trnslt = AppLocalizations.of(context)!;

    return Container(
      color: mainBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(trnslt.lcod_lbl_payments),
            backgroundColor: mainBackgroundColor,
          ),
          body: Column(
            children: [
              CustomSubtitle(
                title: userProvider.currentUser.building,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () =>
                      Future.sync(() => _pagingController.refresh()),
                  child: PagedListView<int, Bill>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Bill>(
                      itemBuilder: (context, bill, index) => Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: CustomCheckBoxListItem(
                          title: bill.name,
                          subtitle:
                              '${trnslt.lcod_lbl_payment_date_bill} ${NoyaFormatter.generate(bill.date)}',
                          color: unpaidc,
                          leading:
                              Text(NoyaFormatter.generateAmount(bill.amount)),
                          valuee: selectedBill
                              .any((element) => element.id == bill.id),
                          mainList: bill,
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                selectedBill.add(bill);
                              } else if (value == false) {
                                selectedBill.removeWhere(
                                    (element) => element.id == bill.id);
                              }
                              summary = selectedBill.fold<num>(
                                  0, (sum, bill) => sum + bill.amount);

                              print(NoyaFormatter.generateAmount(summary));
                            });
                          },
                        ),
                      ),
                      noItemsFoundIndicatorBuilder: (context) => CustomListItem(
                        title: trnslt.lcod_lbl_payment_bill,
                        subtitle: trnslt.lcod_lbl_no_invoice_paid,
                        color: unpaidc,
                        leading: const Icon(
                          Icons.priority_high_outlined,
                          color: unpaidc,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                color: mainBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomMainButton(
                        onTap: () {
                          if (summary > 0) {
                            PersistentNavBarNavigator
                                .pushNewScreenWithRouteSettings(
                              context,
                              settings: RouteSettings(
                                name: CreditCardScreen.routeName,
                                arguments: {
                                  'summary':
                                      NoyaFormatter.generateAmount(summary),
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
                        icon: Icons.start_outlined,
                        text: trnslt.lcod_lbl_continue,
                        edgeInsets: const EdgeInsets.symmetric(horizontal: 20),
                        color: summary == 0 ? Colors.grey : primaryColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Consumer<BillProvider>(
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
                                      return Flexible(
                                        child: CustomDoubleIconbutton(
                                          title: trnslt.lcod_lbl_total_amount,
                                          rightText:
                                              NoyaFormatter.generateAmount(
                                                  snapshot.data),
                                          icon: Icons.receipt_outlined,
                                          size: 60,
                                          color: primaryColor.withOpacity(0.7),
                                        ),
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
                          Flexible(
                            child: CustomDoubleIconbutton(
                              title: trnslt.lcod_lbl_selected_amount_double,
                              rightText:
                                  (NoyaFormatter.generateAmount(summary)),
                              icon: Icons.credit_card_outlined,
                              size: 60,
                              color: primaryColor.withOpacity(0.7),
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
