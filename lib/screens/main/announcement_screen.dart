import 'package:demo_publicarea/providers/building_provider.dart';
import 'package:demo_publicarea/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/models/announcement.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/utils/date_amount_formatter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:demo_publicarea/widgets/custom_listitem_medium.dart';
import 'package:demo_publicarea/providers/announcement_provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:demo_publicarea/screens/main/announcement_detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class AnnouncementScreen extends StatefulWidget {
  static String routeName = '/announcement';

  const AnnouncementScreen({Key? key}) : super(key: key);

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  ScrollController _scrollController = ScrollController();
  PagingController<int, Announcement> get pagingController => _pagingController;

  final PagingController<int, Announcement> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Widget getShimmerLoading() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
          margin: const EdgeInsets.fromLTRB(5, 3, 5, 3),
          color: mainBackgroundColor,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                ListTile(
                  leading: Container(
                    child: CircleAvatar(
                      radius: 35,
                    ),
                  ),
                  trailing: Container(
                    child: CircleAvatar(
                      radius: 15,
                    ),
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          width: double.infinity,
                          height: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          width: double.infinity,
                          height: 15,
                        ),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 2, 85, 2),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      width: double.infinity,
                      height: 10,
                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        width: double.infinity,
                        height: 12,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        width: double.infinity,
                        height: 12,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 2, 50, 8),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        width: double.infinity,
                        height: 12,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 155,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(35), top: Radius.circular(5)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget datascreen(announcement) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: GestureDetector(
        onTap: () {
          AnnouncementProvider()
              .fetchAnnouncementDetails(announcement.id.toString());
          PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
            context,
            settings: RouteSettings(
              name: AnnouncementDetailScreen.routeName,
              arguments: announcement.id.toString(),
            ),
            screen: const AnnouncementDetailScreen(),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
        child: CustomMediumListItem(
          title: announcement.title,
          text: announcement.subtitle,
          image: announcement.imageUrl,
          subtitle: NoyaFormatter.generateDetail(announcement.date),
          trailing: IconButton(
            onPressed: () {
              AnnouncementProvider()
                  .fetchAnnouncementDetails(announcement.id.toString());
              PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                context,
                settings: RouteSettings(
                  name: AnnouncementDetailScreen.routeName,
                  arguments: announcement.id.toString(),
                ),
                screen: const AnnouncementDetailScreen(),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
          leading: const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/images/notice.png'),
          ),
        ),
      ),
    );
  }

  List<Widget> createShimmerLoadings(int count) {
    List<Widget> shimmerLoadings = [];
    for (int i = 0; i < count; i++) {
      shimmerLoadings.add(
          getShimmerLoading()); // getShimmerLoading'ın ne olduğunu bilmemiz gerekiyor
    }
    return shimmerLoadings;
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    BuildingProvider buildingProvider = Provider.of<BuildingProvider>(context);
    AnnouncementProvider announcementProvider =
        Provider.of<AnnouncementProvider>(context);
    _pagingController.addPageRequestListener((pageKey) {
      announcementProvider
          .fetchPageAnnouncement(userProvider.currentUser.buildingId,
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
    //final size = MediaQuery.of(context).size;
    bool loading = true;

    return Container(
      color: mainBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(trnslt.lcod_lbl_announcements),
            backgroundColor: mainBackgroundColor,
          ),
          body: RefreshIndicator(
            onRefresh: () => Future.sync(() => _pagingController.refresh()),
            child: PagedListView<int, Announcement>(
              scrollController: _scrollController,
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Announcement>(
                itemBuilder: (context, announcement, index) => Container(
                    child: datascreen(announcement)

                    //     StreamBuilder<Announcement?>(
                    //   stream: announcementProvider
                    //       .fetchAnnouncementDetails(announcement.id),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState == ConnectionState.waiting) {
                    //       loading = true;
                    //       print(snapshot.connectionState);
                    //       return loading
                    //           ? getShimmerLoading()
                    //           : datascreen(snapshot.data);
                    //     } else {
                    //       loading = false;
                    //       return //loading
                    //           //? getShimmerLoading()
                    //           datascreen(snapshot.data);
                    //     }
                    //   },
                    // ),
                    ),

                // Padding(
                //   padding: const EdgeInsets.all(1.0),
                //   child: GestureDetector(
                //     onTap: () {
                //       AnnouncementProvider()
                //           .fetchAnnouncementDetails(announcement.id.toString());
                //       PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                //         context,
                //         settings: RouteSettings(
                //           name: AnnouncementDetailScreen.routeName,
                //           arguments: announcement.id.toString(),
                //         ),
                //         screen: const AnnouncementDetailScreen(),
                //         withNavBar: true,
                //         pageTransitionAnimation:
                //             PageTransitionAnimation.cupertino,
                //       );
                //     },
                //     child: CustomMediumListItem(
                //       title: announcement.title,
                //       text: announcement.subtitle,
                //       image: announcement.imageUrl,
                //       subtitle: NoyaFormatter.generate(announcement.date),
                //       trailing: IconButton(
                //         onPressed: () {
                //           AnnouncementProvider().fetchAnnouncementDetails(
                //               announcement.id.toString());
                //           PersistentNavBarNavigator
                //               .pushNewScreenWithRouteSettings(
                //             context,
                //             settings: RouteSettings(
                //               name: AnnouncementDetailScreen.routeName,
                //               arguments: announcement.id.toString(),
                //             ),
                //             screen: const AnnouncementDetailScreen(),
                //             withNavBar: true,
                //             pageTransitionAnimation:
                //                 PageTransitionAnimation.cupertino,
                //           );
                //         },
                //         icon: const Icon(Icons.arrow_forward_ios),
                //       ),
                //       leading: const CircleAvatar(
                //         radius: 25,
                //         backgroundImage: AssetImage('assets/images/notice.png'),
                //       ),
                //     ),
                //   ),
                // ),

                noMoreItemsIndicatorBuilder: (context) {
                  return CustomMediumListItem(
                    title: buildingProvider.currentBuilding.buildName,
                    text:
                        'Duyuruların sonuna geldiniz, \ngüncel duyurular için takipte kalın',
                    image: buildingProvider.currentBuilding.imageUrl,
                    leading: const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('assets/images/notice.png'),
                    ),
                    subtitle:
                        '${buildingProvider.currentBuilding.country}/${buildingProvider.currentBuilding.town}',
                  );
                },
                animateTransitions: true,
                transitionDuration: Duration(milliseconds: 450),

                firstPageProgressIndicatorBuilder: (context) {
                  return Column(
                    children: createShimmerLoadings(
                        6), // İlk açılışta 6 adet ShimmerLoading oluştur
                  );
                },

                newPageProgressIndicatorBuilder: (context) {
                  return Column(
                    children: createShimmerLoadings(
                        6), // Yeni liste yüklendiğinde 6 adet ShimmerLoading oluşturur
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// noMoreItemsIndicatorBuilder: (context) {
//                   return CustomMediumListItem(
//                     title: buildingProvider.currentBuilding.buildName,
//                     text:
//                         'Duyuruların sonuna geldiniz, \ngüncel duyurular için takipte kalın',
//                     image: Image.network(
//                       buildingProvider.currentBuilding.imageUrl,
//                       loadingBuilder: (context, child, loadingProgress) {
//                         if (loadingProgress == null) {
//                           return child;
//                         } else {
//                           return LoadingIndicator(); 
//                         }
//                       },
//                     ),
//                     leading: const CircleAvatar(
//                       radius: 25,
//                       backgroundImage: AssetImage('assets/images/notice.png'),
//                     ),
//                     subtitle:
//                         '${buildingProvider.currentBuilding.country}/${buildingProvider.currentBuilding.town}',
//                   );
//                 },