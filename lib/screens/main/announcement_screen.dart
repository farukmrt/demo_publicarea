import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/models/announcement.dart';
import 'package:demo_publicarea/providers/announcement_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/screens/main/announcement_detail_screen.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/utils/date_amount_formatter.dart';
import 'package:demo_publicarea/widgets/custom_listitem_medium.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class AnnouncementScreen extends StatefulWidget {
  static String routeName = '/announcement';

  const AnnouncementScreen({Key? key}) : super(key: key);

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  ScrollController _scrollController = ScrollController();
  PagingController<int, Announcement> get pagingController => _pagingController;

  final PagingController<int, Announcement> _pagingController =
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
    // _scrollController.addListener(() {
    //   var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;
    // });
    UserProvider userProvider = Provider.of<UserProvider>(context);
    AnnouncementProvider announcementProvider =
        Provider.of<AnnouncementProvider>(context);
    _pagingController.addPageRequestListener((pageKey) {
      announcementProvider
          .fetchPage(userProvider.user.buildingId, limit: 6, pageKey: pageKey)
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
            title: Text(trnslt.lcod_lbl_announcements),
            backgroundColor: mainBackgroundColor,
          ),
          body: RefreshIndicator(
            onRefresh: () => Future.sync(() => _pagingController.refresh()),
            child: PagedListView<int, Announcement>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Announcement>(
                itemBuilder: (context, announcement, index) => Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: GestureDetector(
                    onTap: () {
                      AnnouncementProvider()
                          .fetchAnAnnouncement(announcement.id.toString());

                      PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                        context,
                        settings: RouteSettings(
                          name: AnnouncementDetailScreen.routeName,
                          arguments: announcement.id.toString(),
                        ),
                        screen: const AnnouncementDetailScreen(),
                        withNavBar: true,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    child: CustomMediumListItem(
                      title: announcement.title,
                      text: announcement.subtitle,
                      subtitle: NoyaFormatter.generate(announcement.date),
                      trailing: IconButton(
                        onPressed: () {
                          AnnouncementProvider()
                              .fetchAnAnnouncement(announcement.id.toString());

                          // print(index);
                          PersistentNavBarNavigator
                              .pushNewScreenWithRouteSettings(
                            context,
                            settings: RouteSettings(
                              name: AnnouncementDetailScreen.routeName,
                              arguments: announcement.id.toString(),
                            ),
                            screen: const AnnouncementDetailScreen(),
                            withNavBar: true,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
                      leading: const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/images/notice.png'),
                      ),
                      image: announcement.imageUrl,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// // orjinal
// class AnnouncementScreen extends StatefulWidget {
//   static String routeName = '/announcement';
//   const AnnouncementScreen({Key? key}) : super(key: key);
//   @override
//   State<AnnouncementScreen> createState() => _AnnouncementScreenState();
// }
// class _AnnouncementScreenState extends State<AnnouncementScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // double screenHeight = MediaQuery.of(context).size.height;
//     // ScrollController _scrollController = ScrollController();
//     UserProvider userProvider = Provider.of<UserProvider>(context);
//     return Container(
//       color: mainBackgroundColor,
//       child: SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text('Duyurular'),
//             backgroundColor: mainBackgroundColor,
//           ),
//           body: Container(
//             //color: backgroundColor,
//             padding: const EdgeInsets.all(2),
//             child: Expanded(
//               child: Consumer<AnnouncementProvider>(
//                 builder: (context, data, index) {
//                   // var announcements = await data.fetchAnnouncement();
//                   return StreamBuilder(
//                     stream:
//                         data.fetchAnnouncement(userProvider.user.buildingId),
//                     builder: (BuildContext context, snapshot) {
//                       if (snapshot.hasData) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return const Center(
//                             child: LoadingIndicator(),
//                           );
//                         } else {
//                           //futurelistview<map<srting.dynamic>>{pagesize}
//                           return ListView.builder(
//                             //controller: _scrollController,
//                             itemCount: snapshot.data?.length,
//                             itemBuilder: (context, index) {
//                               var announcement = snapshot.data?[index];
//                               return CustomMediumListItem(
//                                 title: announcement!.title,
//                                 text: announcement.subtitle,
//                                 subtitle:
//                                     NoyaFormatter.generate(announcement.date),
//                                 trailing: IconButton(
//                                   onPressed: () {
//                                     AnnouncementProvider().fetchAnAnnouncement(
//                                         announcement.id.toString());
//                                     // print(index);
//                                     PersistentNavBarNavigator
//                                         .pushNewScreenWithRouteSettings(
//                                       context,
//                                       settings: RouteSettings(
//                                         name:
//                                             AnnouncementDetailScreen.routeName,
//                                         arguments: announcement.id.toString(),
//                                       ),
//                                       screen: const AnnouncementDetailScreen(),
//                                       withNavBar: true,
//                                       pageTransitionAnimation:
//                                           PageTransitionAnimation.cupertino,
//                                     );
//                                   },
//                                   icon: const Icon(Icons.arrow_forward_ios),
//                                 ),
//                                 leading: const CircleAvatar(
//                                   radius: 25,
//                                   backgroundImage:
//                                       AssetImage('assets/images/notice.png'),
//                                 ),
//                                 image: announcement.imageUrl,
//                               );
//                             },
//                           );
//                         }
//                       } else if (snapshot.hasError) {
//                         return Text('Hata: ${snapshot.error}');
//                       }
//                       return const LoadingIndicator();
//                     },
//                   );
//                 },
//               ),
//             ),
//           ), //////////////
//         ),
//       ),
//     );
//   }
// }
