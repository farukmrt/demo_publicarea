import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:demo_publicarea/models/bill.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:demo_publicarea/widgets/custom_subtitle.dart';
import 'package:demo_publicarea/providers/bill_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/widgets/loading_indicator.dart';
import 'package:demo_publicarea/utils/date_amount_formatter.dart';
import 'package:demo_publicarea/widgets/custom_double_button.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ItemizedAccountScreen extends StatefulWidget {
  static String routeName = '/itemizedAccount';

  const ItemizedAccountScreen({Key? key}) : super(key: key);

  @override
  State<ItemizedAccountScreen> createState() => _ItemizedAccountScreenState();
}

class _ItemizedAccountScreenState extends State<ItemizedAccountScreen> {
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

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    BillProvider billProvider = Provider.of<BillProvider>(context);
    _pagingController.addPageRequestListener((pageKey) {
      billProvider
          .fetchPageBillByPaidStatus(true, userProvider.currentUser.apartmentId,
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
          body: Column(
            children: [
              CustomSubtitle(
                title: trnslt.lcod_lbl_paid_bills,
                subtitle: userProvider.currentUser.building,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () =>
                      Future.sync(() => _pagingController.refresh()),
                  child: PagedListView<int, Bill>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Bill>(
                      itemBuilder: (context, paidBills, index) => Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: CustomListItem(
                            title: paidBills.name,
                            subtitle:
                                '${trnslt.lcod_lbl_payment_date_paid} ${NoyaFormatter.generate(paidBills.date)}',
                            color: paidc,
                            trailing: Text(
                                NoyaFormatter.generateAmount(paidBills.amount)),
                            leading: const Icon(
                              Icons.receipt_long_outlined,
                              color: paidc,
                              size: 30,
                            ),
                          ),
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
                  child: Row(
                    children: [
                      Container(
                        width: size.width / 2 - 2,
                        child: Consumer<BillProvider>(
                          builder: (context, data, index) {
                            return StreamBuilder<double>(
                              stream: data.fetchAmountTotalStatus(
                                  false, userProvider.currentUser.apartmentId),
                              builder: (BuildContext context, snapshot) {
                                //var bill = snapshot.data?;
                                if (snapshot.hasData) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: LoadingAnimationWidget
                                          .prograssiveDots(
                                              color: positive, size: 60),
                                    );
                                  } else {
                                    return CustomDoubleIconbutton(
                                      color: negative.shade200,
                                      title: trnslt.lcod_lbl_debt,
                                      rightText: NoyaFormatter.generateAmount(
                                          snapshot.data),
                                      icon: Icons.payments_outlined,
                                      size: 60,
                                    );
                                  }
                                } else if (snapshot.hasError) {
                                  return const Text('no data');
                                }
                                return LoadingAnimationWidget.prograssiveDots(
                                    color: positive, size: 60);
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
                              stream: data.fetchAmountTotalStatus(
                                  true, userProvider.currentUser.apartmentId),
                              builder: (BuildContext context, snapshot) {
                                //var bill = snapshot.data?;
                                if (snapshot.hasData) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: LoadingAnimationWidget
                                          .prograssiveDots(
                                              color: negative, size: 60),
                                    );
                                  } else {
                                    return CustomDoubleIconbutton(
                                      title: trnslt.lcod_lbl_paid,
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
                                return LoadingAnimationWidget.prograssiveDots(
                                    color: negative, size: 60);
                              },
                            );
                          },
                        ),
                      ),
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
