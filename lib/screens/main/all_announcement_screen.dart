import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_publicarea/models/announcement.dart';
import 'package:demo_publicarea/providers/announcement_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/screens/main/an_announcement_screen.dart';
import 'package:demo_publicarea/screens/main/pagenation.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/utils/date_amount_formatter.dart';
import 'package:demo_publicarea/widgets/custom_listitem_medium.dart';
import 'package:demo_publicarea/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class AllAnnouncementScreen extends StatefulWidget {
  static String routeName = '/allAnnouncement';

  const AllAnnouncementScreen({Key? key}) : super(key: key);

  @override
  State<AllAnnouncementScreen> createState() => _AllAnnouncementScreenState();
}

class _AllAnnouncementScreenState extends State<AllAnnouncementScreen> {
  // DocumentSnapshot? _lastDocument;

  // late bool _isLastPage;
  // late int _pageNumber;
  // late bool _error;
  // late bool _loading;
  // final int _numberOfPostsPerRequest = 5;
  // late List<Announcement> _announcement;
  // final int _nextPageTrigger = 3;

  // @override
  // void initState() {
  //   super.initState();
  //   _pageNumber = 0;
  //   _announcement = [];
  //   _isLastPage = false;
  //   _loading = true;
  //   _error = false;
  //   fetchData();
  // }

  // Future<void> fetchData() async {
  //   try {
  //     final response = await FirebaseFirestore.instance
  //         .collection('announcements')
  //         .orderBy('date',
  //             descending:
  //                 true) // İlgili alanı kullanarak sıralama yapabilirsiniz
  //         .limit(_numberOfPostsPerRequest) // Belirtilen sayıda belge getirir
  //         .startAfterDocument(
  //             _lastDocument!) // Sonraki sayfada başlamak için son belgeyi kullanır
  //         .get();

  //     if (response.docs.isNotEmpty) {
  //       List<Announcement> annoList = response.docs.map((doc) {
  //         // Her bir belgeyi Announcement modeline dönüştürün
  //         return Announcement(
  //           build_uid: doc['build_uid'],
  //           date: doc['date'],
  //           id: doc['id'],
  //           imageUrl: doc['imageUrl'],
  //           subtitle: doc['subtitle'],
  //           title: doc['title'],
  //         );
  //       }).toList();

  //       setState(() {
  //         _isLastPage = annoList.length < _numberOfPostsPerRequest;
  //         _loading = false;
  //         _pageNumber = _pageNumber + 1;
  //         _announcement.addAll(annoList);
  //         _lastDocument = response.docs
  //             .last; // Son belgeyi saklayın, sonraki sayfada kullanmak için
  //       });
  //     } else {
  //       // Veri kalmadıysa son sayfadayız
  //       setState(() {
  //         _isLastPage = true;
  //         _loading = false;
  //       });
  //     }
  //   } catch (e) {
  //     print("error --> $e");
  //     setState(() {
  //       _loading = false;
  //       _error = true;
  //     });
  //   }
  // }

  String? buildingId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> argument =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String? buildingId = argument['buildingId'];
    setState(() {
      this.buildingId = buildingId;
    });
  }

  final _numberOfPostsPerRequest = 1;

  final PagingController<int, Announcement> _pagingController =
      PagingController(firstPageKey: 0);

  DocumentSnapshot? lastDocument; // _fetchPage dışında bir yerde tanımlayın

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      var collection = FirebaseFirestore.instance.collection("announcements");
      var query = collection.where('build_id', isEqualTo: buildingId);

      if (pageKey > 0) {
        query = query.startAfterDocument(lastDocument!);
      }

      query = query.limit(_numberOfPostsPerRequest);

      var querySnapshot = await query.get();

      List<Announcement> tempList = [];
      var documents = querySnapshot.docs;
      if (documents.isNotEmpty) {
        lastDocument = documents[documents.length - 1];

        documents.forEach((element) {
          var announcement = Announcement(
            id: element.data()['id'],
            build_uid: element.data()['build_id'],
            title: element.data()['title'],
            subtitle: element.data()['subtitle'],
            date: element.data()['date'],
            imageUrl: element.data()['imageUrl'],
          );
          tempList.add(announcement);
        });
      }

      final isLastPage = documents.length < _numberOfPostsPerRequest;
      if (isLastPage) {
        _pagingController.appendLastPage(tempList);
      } else {
        // Son belgeyi sonraki sayfanın başlangıç noktası olarak geçirin
        _pagingController.appendPage(tempList, pageKey + 1);
      }
    } catch (e) {
      print("error --> $e");
      _pagingController.error = e;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

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
          body: //InfiniteScrollPaginatorDemo(),
              Container(
            //color: backgroundColor,
            padding: const EdgeInsets.all(2),
            child: Expanded(
                child: RefreshIndicator(
              onRefresh: () => Future.sync(() => _pagingController.refresh()),
              child: PagedListView<int, Announcement>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Announcement>(
                  itemBuilder: (context, item, index) => CustomMediumListItem(
                    title: item.title,
                    text: item.subtitle,
                    subtitle: NoyaFormatter.generate(item.date),
                    trailing: IconButton(
                      onPressed: () {
                        AnnouncementProvider()
                            .fetchAnAnnouncement(item.id.toString());

                        PersistentNavBarNavigator
                            .pushNewScreenWithRouteSettings(
                          context,
                          settings: RouteSettings(
                            name: AnAnnouncementScreen.routeName,
                            arguments: item.id.toString(),
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
                      backgroundImage: AssetImage('assets/images/notice.png'),
                    ),
                    image: item.imageUrl,
                  ),
                ),
              ),
            )),
          ), ///////
        ),
      ),
    );
  }
}

// class AllAnnouncementScreen extends StatefulWidget {
//   static String routeName = '/allAnnouncement';

//   const AllAnnouncementScreen({Key? key}) : super(key: key);

//   @override
//   State<AllAnnouncementScreen> createState() => _AllAnnouncementScreenState();
// }

// class _AllAnnouncementScreenState extends State<AllAnnouncementScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   DocumentSnapshot? lastDocument;
//   List<Map<String, dynamic>> list = [];
//   final ScrollController controller = ScrollController();
//   bool isLoadingData = false;
//   bool isMoreData = true;

//   @override
//   void initstate() {
//     super.initState();
//     paginatedData();

//     controller.addListener(() {
//       if (controller.position.pixels == controller.position.maxScrollExtent)
//         paginatedData();
//     });
//   }

//   void paginatedData() async {
//     if (isMoreData) {
//       setState(() {
//         isMoreData = true;
//       });

//       final collectionReference = _firestore.collection('announcements');
//       late QuerySnapshot<Map<String, dynamic>> querySnapshot;

//       if (lastDocument == null) {
//         querySnapshot = await collectionReference.limit(5).get();
//       } else {
//         querySnapshot = await collectionReference
//             .limit(5)
//             .startAfterDocument(lastDocument!)
//             .get();
//       }
//       lastDocument = querySnapshot.docs.last;
//       list.addAll(querySnapshot.docs.map((e) => e.data()));
//       isLoadingData = false;
//       print(list.length);
//       setState(() {});
//       if (querySnapshot.docs.length < 5) {
//         isMoreData = false;
//       }
//     } else {
//       print('no more data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
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
//             child: ListView.builder(
//               //controller: _scrollController,
//               controller: controller,
//               itemCount: list.length, //snapshot.data?.length,
//               itemBuilder: (context, index) {
//                 //var announcement = {list[index]};

// return CustomMediumListItem(
//   title: '${list[index]['title']}', // announcement!.title,
//   text: '${list[index]['subtitle']}', //announcement.subtitle,
//   subtitle: NoyaFormatter.generate(
//       '${list[index]['date']}' as Timestamp),
//   trailing: IconButton(
//     onPressed: () {
//       AnnouncementProvider().fetchAnAnnouncement(
//           '${list[index]['id']}'.toString());

//       // print(index);
//       PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
//         context,
//         settings: RouteSettings(
//           name: AnAnnouncementScreen.routeName,
//           arguments: '${list[index]['id']}'.toString(),
//         ),
//         screen: const AnAnnouncementScreen(),
//         withNavBar: true,
//         pageTransitionAnimation:
//             PageTransitionAnimation.cupertino,
//       );
//     },
//     icon: const Icon(Icons.arrow_forward_ios),
//   ),
//   leading: const CircleAvatar(
//     radius: 25,
//     backgroundImage: AssetImage('assets/images/notice.png'),
//   ),
//   image: '${list[index]['imageUrl']}',
// );
//           },
//         ),
//       ),
//     ),
//   ),
// );
//   }
// }

// // orjinal
// class AllAnnouncementScreen extends StatefulWidget {
//   static String routeName = '/allAnnouncement';

//   const AllAnnouncementScreen({Key? key}) : super(key: key);

//   @override
//   State<AllAnnouncementScreen> createState() => _AllAnnouncementScreenState();
// }

// class _AllAnnouncementScreenState extends State<AllAnnouncementScreen> {
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
//           body:

//           Container(
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
//                                         name: AnAnnouncementScreen.routeName,
//                                         arguments: announcement.id.toString(),
//                                       ),
//                                       screen: const AnAnnouncementScreen(),
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
//           ),//////////////
//         ),
//       ),
//     );
//   }
// }

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
