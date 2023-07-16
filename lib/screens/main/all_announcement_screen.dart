import 'package:demo_publicarea/providers/announcement_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/screens/main/an_announcement_screen.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/utils/date_amount_formatter.dart';
import 'package:demo_publicarea/widgets/custom_listitem_medium.dart';
import 'package:demo_publicarea/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class AllAnnouncementScreen extends StatefulWidget {
  static String routeName = '/allAnnouncement';

  const AllAnnouncementScreen({Key? key}) : super(key: key);

  @override
  State<AllAnnouncementScreen> createState() => _AllAnnouncementScreenState();
}

class _AllAnnouncementScreenState extends State<AllAnnouncementScreen> {
  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;

    // ScrollController _scrollController = ScrollController();
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Container(
      color: mainBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Duyurular'),
            backgroundColor: mainBackgroundColor,
          ),
          body: Container(
            //color: backgroundColor,
            padding: const EdgeInsets.all(2),
            child: Expanded(
              child: Consumer<AnnouncementProvider>(
                builder: (context, data, index) {
                  // var announcements = await data.fetchAnnouncement();
                  return StreamBuilder(
                    stream:
                        data.fetchAnnouncement(userProvider.user.buildingId),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: LoadingIndicator(),
                          );
                        } else {
                          //futurelistview<map<srting.dynamic>>{pagesize}
                          return ListView.builder(
                            //controller: _scrollController,
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              var announcement = snapshot.data?[index];

                              return CustomMediumListItem(
                                title: announcement!.title,
                                text: announcement.subtitle,
                                subtitle:
                                    NoyaFormatter.generate(announcement.date),
                                trailing: IconButton(
                                  onPressed: () {
                                    AnnouncementProvider().fetchAnAnnouncement(
                                        announcement.id.toString());

                                    print(index);
                                    PersistentNavBarNavigator
                                        .pushNewScreenWithRouteSettings(
                                      context,
                                      settings: RouteSettings(
                                        name: AnAnnouncementScreen.routeName,
                                        arguments: announcement.id.toString(),
                                      ),
                                      screen: const AnAnnouncementScreen(),
                                      withNavBar: true,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                    );
                                  },
                                  icon: const Icon(Icons.arrow_forward_ios),
                                ),
                                leading: const CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      AssetImage('assets/images/notice.png'),
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
          ),
        ),
      ),
    );
  }
}

// // class AllAnnouncementScreen extends StatefulWidget {
// //   static String routeName = '/allAnnouncement';

// //   const AllAnnouncementScreen({Key? key}) : super(key: key);

// //   @override
// //   State<AllAnnouncementScreen> createState() => _AllAnnouncementScreenState();
// // }

// // class _AllAnnouncementScreenState extends State<AllAnnouncementScreen> {
// //   static const _pageSize = 5;

// //   final PagingController<int, Announcement> _pagingController =
// //       PagingController(firstPageKey: 0);
// //   late AnnouncementProvider _announcementProvider;

// //   @override
// //   void initState() {
// //     _announcementProvider =
// //         Provider.of<AnnouncementProvider>(context, listen: false);
// //     _pagingController.addPageRequestListener((pageKey) {
// //       _fetchPage(pageKey);
// //     });
// //     super.initState();
// //   }

// //   Future<void> _fetchPage(int pageKey) async {
// //     try {
// //       final userProvider = Provider.of<UserProvider>(context, listen: false);
// //       final announcements = await _announcementProvider.fetchAnnouncement(
// //         userProvider.user.buildingId,
// //         limit: _pageSize,
// //       );
// //       final isLastPage = announcements.length < _pageSize;
// //       if (isLastPage) {
// //         _pagingController.appendLastPage(announcements);
// //       } else {
// //         final nextPageKey = pageKey + 1;
// //         _pagingController.appendPage(announcements, nextPageKey);
// //       }
// //     } catch (error) {
// //       _pagingController.error = error;
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       color: mainBackgroundColor,
// //       child: SafeArea(
// //         child: Scaffold(
// //           appBar: AppBar(
// //             title: const Text('Duyurular'),
// //             backgroundColor: mainBackgroundColor,
// //           ),
// //           body: Container(
// //             padding: const EdgeInsets.all(2),
// //             child: Consumer<UserProvider>(
// //               builder: (context, userProvider, _) {
// //                 return PagedListView<int, Announcement>(
// //                   pagingController: _pagingController,
// //                   builderDelegate: PagedChildBuilderDelegate<Announcement>(
// //                     itemBuilder: (context, announcement, index) {
// //                       return CustomMediumListItem(
// //                         title: announcement.title,
// //                         text: announcement.subtitle,
// //                         subtitle: NoyaFormatter.generate(announcement.date),
// //                         trailing: IconButton(
// //                           onPressed: () {
// //                             PersistentNavBarNavigator
// //                                 .pushNewScreenWithRouteSettings(
// //                               context,
// //                               settings: RouteSettings(
// //                                   name: AnAnnouncementScreen.routeName),
// //                               screen: const AnAnnouncementScreen(),
// //                               withNavBar: true,
// //                               pageTransitionAnimation:
// //                                   PageTransitionAnimation.cupertino,
// //                             );
// //                           },
// //                           icon: const Icon(Icons.arrow_forward_ios),
// //                         ),
// //                         leading: const CircleAvatar(
// //                           radius: 25,
// //                           backgroundImage:
// //                               AssetImage('assets/images/notice.png'),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _pagingController.dispose();
// //     super.dispose();
// //   }
// // }

