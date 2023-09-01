import 'package:demo_publicarea/widgets/custom_button.dart';

import 'request_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:demo_publicarea/models/request.dart';
import 'package:demo_publicarea/widgets/custom_title.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/providers/request_provider.dart';
import 'package:demo_publicarea/widgets/custom_request_card.dart';
import 'package:demo_publicarea/widgets/custom_empty_request.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:demo_publicarea/screens/request/create_request_screen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RequestScreen extends StatefulWidget {
  static String routeName = '/request';
  const RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  //ScrollController _scrollController = ScrollController();

  PagingController<int, Request> get pagingControllerTrue =>
      _pagingControllerTrue;
  final PagingController<int, Request> _pagingControllerTrue =
      PagingController(firstPageKey: 0);

  PagingController<int, Request> get pagingControllerFalse =>
      _pagingControllerFalse;
  final PagingController<int, Request> _pagingControllerFalse =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    RequestProvider requestProviderT = Provider.of<RequestProvider>(context);
    RequestProvider requestProviderF = Provider.of<RequestProvider>(context);
    _pagingControllerTrue.addPageRequestListener((pageKey) {
      requestProviderT
          .fetchPageRequestByStatus(true, userProvider.currentUser.apartmentId,
              limit: 6, pageKey: pageKey)
          .listen((tempList) {
        final isLastPage = tempList.length < 6;
        //_pagingControllerTrue.itemList = [];

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
      requestProviderF
          .fetchPageRequestByStatus(false, userProvider.currentUser.apartmentId,
              limit: 6, pageKey: pageKey)
          .listen((tempList) {
        final isLastPage = tempList.length < 6;
        // _pagingControllerFalse.itemList = [];

        if (isLastPage) {
          _pagingControllerFalse.appendLastPage(tempList);
        } else {
          final nextPageKey = pageKey + 1;

          _pagingControllerFalse.appendPage(tempList, nextPageKey);
        }
        print('Value from controller: $pageKey');
      });
    });

    var trnslt = AppLocalizations.of(context)!;

    final size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Container(
        color: mainBackgroundColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 0,
              backgroundColor: mainBackgroundColor,

              // title: CustomTitle(
              //   mainTitle: trnslt.lcod_lbl_new_request,
              //   button: Icons.add,
              //   onTap: () {
              //     PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
              //       context,
              //       settings: RouteSettings(
              //         name: CreateRequestScreen.routeName,
              //         arguments: {
              //           'apartmentId': userProvider.currentUser.apartmentId,
              //           'userUid': userProvider.currentUser.uid
              //         },
              //       ),
              //       screen: const CreateRequestScreen(),
              //       withNavBar: true,
              //       pageTransitionAnimation: PageTransitionAnimation.cupertino,
              //     );
              //   },
              // ),
            ),
            body: Container(
              width: double.infinity,
              color: mainBackgroundColor,
              child: Column(
                children: <Widget>[
                  Container(
                    width: size.width,
                    child: Stack(
                      children: [
                        Center(
                          child: ButtonsTabBar(
                            backgroundColor: backgroundColor,
                            unselectedBackgroundColor: mainBackgroundColor,
                            //unselectedLabelStyle: TextStyle(color: mainBackgroundColor),
                            //renk değeri verilmiyor
                            // labelStyle: TextStyle(
                            //   color: Colors.red,
                            //   //fontWeight: FontWeight.bold,
                            // ),
                            // unselectedLabelStyle: TextStyle(
                            //   color: Colors.red,
                            //   //fontWeight: FontWeight.bold,
                            // ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            radius: 30,
                            tabs: [
                              Tab(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.pending_outlined,
                                      color: primaryColor,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      trnslt.lcod_lbl_current_request,
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.task_alt_outlined,
                                      color: primaryColor,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      trnslt.lcod_lbl_complete_request,
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: size.width / 100,
                          child: IconButton(
                            iconSize: size.width / 12,
                            onPressed: () {
                              PersistentNavBarNavigator
                                  .pushNewScreenWithRouteSettings(
                                context,
                                settings: RouteSettings(
                                  name: CreateRequestScreen.routeName,
                                  arguments: {
                                    'apartmentId':
                                        userProvider.currentUser.apartmentId,
                                    'userUid': userProvider.currentUser.uid
                                  },
                                ),
                                screen: const CreateRequestScreen(),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Center(
                          child: Container(
                            color: backgroundColor,
                            child: RefreshIndicator(
                              onRefresh: () => Future.sync(
                                  () => _pagingControllerTrue.refresh()),
                              child: PagedListView<int, Request>(
                                pagingController: _pagingControllerTrue,
                                builderDelegate:
                                    PagedChildBuilderDelegate<Request>(
                                  itemBuilder: (context, requestT, index) =>
                                      Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        PersistentNavBarNavigator
                                            .pushNewScreenWithRouteSettings(
                                          context,
                                          settings: RouteSettings(
                                            name: RequestDetailScreen.routeName,
                                            arguments:
                                                requestT.requestId.toString(),
                                          ),
                                          screen: const RequestDetailScreen(),
                                          withNavBar: true,
                                          pageTransitionAnimation:
                                              PageTransitionAnimation.cupertino,
                                        );
                                      },
                                      child: CustomRequestCard(
                                        requestType: requestT.requestType,
                                        requestTitle: requestT.requestTitle,
                                        apartmentNumber:
                                            requestT.apartmentNumber,
                                        status: requestT.status,
                                        onTap: () {
                                          PersistentNavBarNavigator
                                              .pushNewScreenWithRouteSettings(
                                            context,
                                            settings: RouteSettings(
                                              name:
                                                  RequestDetailScreen.routeName,
                                              arguments:
                                                  requestT.requestId.toString(),
                                            ),
                                            screen: const RequestDetailScreen(),
                                            withNavBar: true,
                                            pageTransitionAnimation:
                                                PageTransitionAnimation
                                                    .cupertino,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  noItemsFoundIndicatorBuilder: (context) =>
                                      const CustomEmptyRequest(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            color: backgroundColor,
                            child: RefreshIndicator(
                              onRefresh: () => Future.sync(
                                  () => _pagingControllerFalse.refresh()),
                              child: PagedListView<int, Request>(
                                pagingController: _pagingControllerFalse,
                                builderDelegate:
                                    PagedChildBuilderDelegate<Request>(
                                  itemBuilder: (context, requestF, index) =>
                                      Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        PersistentNavBarNavigator
                                            .pushNewScreenWithRouteSettings(
                                          context,
                                          settings: RouteSettings(
                                            name: RequestDetailScreen.routeName,
                                            arguments:
                                                requestF.requestId.toString(),
                                          ),
                                          screen: const RequestDetailScreen(),
                                          withNavBar: true,
                                          pageTransitionAnimation:
                                              PageTransitionAnimation.cupertino,
                                        );
                                      },
                                      child: CustomRequestCard(
                                        requestType: requestF.requestType,
                                        requestTitle: requestF.requestTitle,
                                        apartmentNumber:
                                            requestF.apartmentNumber,
                                        status: requestF.status,
                                        onTap: () {
                                          PersistentNavBarNavigator
                                              .pushNewScreenWithRouteSettings(
                                            context,
                                            settings: RouteSettings(
                                              name:
                                                  RequestDetailScreen.routeName,
                                              arguments:
                                                  requestF.requestId.toString(),
                                            ),
                                            screen: const RequestDetailScreen(),
                                            withNavBar: true,
                                            pageTransitionAnimation:
                                                PageTransitionAnimation
                                                    .cupertino,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  noItemsFoundIndicatorBuilder: (context) =>
                                      const CustomEmptyRequest(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
