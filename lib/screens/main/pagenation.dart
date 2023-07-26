// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:demo_publicarea/models/announcement.dart';
// import 'package:flutter/material.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

// import '../../providers/announcement_provider.dart';
// import '../../utils/date_amount_formatter.dart';
// import '../../widgets/custom_listitem_medium.dart';
// import 'an_announcement_screen.dart';

// // class CharacterListView extends StatefulWidget {
// //   @override
// //   _CharacterListViewState createState() => _CharacterListViewState();
// // }

// // class _CharacterListViewState extends State<CharacterListView> {
// //   static const _pageSize = 20;

// //   final PagingController<int, Announcement> _pagingController =
// //       PagingController(firstPageKey: 0);

// //   @override
// //   void initState() {
// //     _pagingController.addPageRequestListener((pageKey) {
// //       _fetchPage(pageKey);
// //     });
// //     super.initState();
// //   }

// //   Future<void> _fetchPage(int pageKey) async {
// //     try {
// //       final newItems = await //RemoteApi.getCharacterList(pageKey, _pageSize);
// //       final isLastPage = newItems.length < _pageSize;
// //       if (isLastPage) {
// //         _pagingController.appendLastPage(newItems);
// //       } else {
// //         final nextPageKey = pageKey + newItems.length;
// //         _pagingController.appendPage(newItems, nextPageKey);
// //       }
// //     } catch (error) {
// //       _pagingController.error = error;
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) =>
// //       // Don't worry about displaying progress or error indicators on screen; the
// //       // package takes care of that. If you want to customize them, use the
// //       // [PagedChildBuilderDelegate] properties.
// //       PagedListView<int, Announcement>(
// //         pagingController: _pagingController,
// //         builderDelegate: PagedChildBuilderDelegate<Announcement>(

// //           itemBuilder: (context, index) {
// //                               var snapshot;
// //                               var announcement = snapshot.data?[index];

// //                               return CustomMediumListItem(
// //                                 title: announcement!.title,
// //                                 text: announcement.subtitle,
// //                                 subtitle:
// //                                     NoyaFormatter.generate(announcement.date),
// //                                 trailing: IconButton(
// //                                   onPressed: () {
// //                                     AnnouncementProvider().fetchAnAnnouncement(
// //                                         announcement.id.toString());

// //                                     // print(index);
// //                                     PersistentNavBarNavigator
// //                                         .pushNewScreenWithRouteSettings(
// //                                       context,
// //                                       settings: RouteSettings(
// //                                         name: AnAnnouncementScreen.routeName,
// //                                         arguments: announcement.id.toString(),
// //                                       ),
// //                                       screen: const AnAnnouncementScreen(),
// //                                       withNavBar: true,
// //                                       pageTransitionAnimation:
// //                                           PageTransitionAnimation.cupertino,
// //                                     );
// //                                   },
// //                                   icon: const Icon(Icons.arrow_forward_ios),
// //                                 ),
// //                                 leading: const CircleAvatar(
// //                                   radius: 25,
// //                                   backgroundImage:
// //                                       AssetImage('assets/images/notice.png'),
// //                                 ),
// //                                 image: announcement.imageUrl,
// //                               );
// //                             },
// //         ),
// //       );

// //   @override
// //   void dispose() {
// //     _pagingController.dispose();
// //     super.dispose();
// //   }
// // // }

// // import 'package:flutter/material.dart';

// // class CharacterListView extends StatefulWidget {
// //   @override
// //   _CharacterListViewState createState() => _CharacterListViewState();
// // }

// // class _CharacterListViewState extends State<CharacterListView> {
// //   static const _pageSize = 2;

// //   final PagingController<int, Announcement> _pagingController =
// //       PagingController(firstPageKey: 0);

// //   @override
// //   void initState() {
// //     _pagingController.addPageRequestListener((pageKey) {
// //       _fetchPage(5);
// //     });
// //     super.initState();
// //   }

// //   Future<void> _fetchPage(int pageKey) async {
// //     try {
// //       final querySnapshot = await FirebaseFirestore.instance
// //           .collection('announcements')
// //           .orderBy('id')
// //           .startAfter([pageKey])
// //           .limit(_pageSize)
// //           .get();

// //       final newItems = querySnapshot.docs
// //           .map((doc) => Announcement(
// //                 id: doc['id'],
// //                 build_uid: doc['build_id'],
// //                 title: doc['title'],
// //                 subtitle: doc['subtitle'],
// //                 date: doc['date'],
// //                 imageUrl: doc['imageUrl'],
// //               ))
// //           .toList();

// //       final isLastPage = newItems.length < _pageSize;
// //       if (isLastPage) {
// //         _pagingController.appendLastPage(newItems);
// //       } else {
// //         final nextPageKey = pageKey + 1;
// //         _pagingController.appendPage(newItems, nextPageKey);
// //       }
// //     } catch (error) {
// //       _pagingController.error = error;
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return PagedListView<int, Announcement>(
// //       pagingController: _pagingController,
// //       builderDelegate: PagedChildBuilderDelegate<Announcement>(
// //         itemBuilder: (context, item, index) {
// //           return CustomMediumListItem(
// //             title: item.title, // announcement!.title,
// //             text: item.subtitle, //announcement.subtitle,
// //             subtitle: NoyaFormatter.generate(item.date),
// //             trailing: IconButton(
// //               onPressed: () {
// //                 AnnouncementProvider().fetchAnAnnouncement(item.id);

// //                 // print(index);
// //                 PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
// //                   context,
// //                   settings: RouteSettings(
// //                     name: AnAnnouncementScreen.routeName,
// //                     arguments: item.id.toString(),
// //                   ),
// //                   screen: const AnAnnouncementScreen(),
// //                   withNavBar: true,
// //                   pageTransitionAnimation: PageTransitionAnimation.cupertino,
// //                 );
// //               },
// //               icon: const Icon(Icons.arrow_forward_ios),
// //             ),
// //             leading: const CircleAvatar(
// //               radius: 25,
// //               backgroundImage: AssetImage('assets/images/notice.png'),
// //             ),
// //             image: item.imageUrl,
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _pagingController.dispose();
// //     super.dispose();
// //   }
// // }

// class Post {
//   final String title;
//   final String body;
//   Post(this.title, this.body);

// }

// class PostItem extends StatelessWidget {

//   final String title;
//   final String body;

//   PostItem(this.title, this.body);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 220,
//       width: 200,
//       decoration: const BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(15)),
//           color: Colors.amber
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Text(title,
//               style: const TextStyle(
//                   color: Colors.purple,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold
//               ),),
//             const SizedBox(height: 10,),
//             Text(body,
//               style: const TextStyle(
//                   fontSize: 15
//               ),)
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PostsOverviewScreen extends StatefulWidget {

//   @override
//   _PostsOverviewScreenState createState() => _PostsOverviewScreenState();
// }
// class _PostsOverviewScreenState extends State<PostsOverviewScreen> {
//   late bool _isLastPage;
//   late int _pageNumber;
//   late bool _error;
//   late bool _loading;
//   final int _numberOfPostsPerRequest = 10;
//   late List<Post> _posts;
//   final int _nextPageTrigger = 3;

//   @override
//   void initState() {
//     super.initState();
//     _pageNumber = 0;
//     _posts = [];
//     _isLastPage = false;
//     _loading = true;
//     _error = false;
//     fetchData();
//   }

// }
// Future<void> fetchData() async {
//     try {
//       final FirebaseFirestore firestore = FirebaseFirestore.instance;

// CollectionReference annoCollection = firestore.collection('announcements');

// annoCollection.get().then((querySnapshot) {
//   List<Announcement> annoList = [];
//   querySnapshot.docs.forEach((documentSnapshot) {
//     // Her belge için alanları alıp Announcement sınıfından bir nesne oluşturma
//     var data = documentSnapshot.data();
//     Announcement anno = Announcement(
//           id: data['id'],
//           build_uid: data['build_id'],
//           title: data['title'],
//           subtitle:data['subtitle'],
//           date: data['date'],
//           imageUrl: data['imageUrl'],
//         );
//     annoList.add(anno);
//   });

//       annoCollection.snapshots().map((querySnapshot) {
//       List<Announcement> tempList = [];
//       querySnapshot.docs.forEach((element) {
//         var announcement = Announcement(
//           id: element.data()['id'],
//           build_uid: element.data()['build_id'],
//           title: element.data()['title'],
//           subtitle: element.data()['subtitle'],
//           date: element.data()['date'],
//           imageUrl: element.data()['imageUrl'],
//         );
//         tempList.add(announcement);
//       });
//       return tempList;
//     });

//       setState(() {
//         _isLastPage = postList.length < _numberOfPostsPerRequest;
//         _loading = false;
//         _pageNumber = _pageNumber + 1;
//         _posts.addAll(postList);
//       });
//     } catch (e) {
//       print("error --> $e");
//       setState(() {
//         _loading = false;
//         _error = true;
//       });
//     }
//   }

//   Widget errorDialog({required double size}){
//     return SizedBox(
//       height: 180,
//       width: 200,
//       child:  Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('An error occurred when fetching the posts.',
//             style: TextStyle(
//                 fontSize: size,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black
//             ),
//           ),
//           const SizedBox(height: 10,),
//           FlatButton(
//               onPressed:  ()  {
//                 setState(() {
//                   _loading = true;
//                   _error = false;
//                   fetchData();
//                 });
//               },
//               child: const Text("Retry", style: TextStyle(fontSize: 20, color: Colors.purpleAccent),)),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Blog App"), centerTitle: true,),
//       body: buildPostsView(),
//     );
//   }

//   Widget buildPostsView() {
//     if (_posts.isEmpty) {
//       if (_loading) {
//         return const Center(
//             child: Padding(
//               padding: EdgeInsets.all(8),
//               child: CircularProgressIndicator(),
//             ));
//       } else if (_error) {
//         return Center(
//             child: errorDialog(size: 20)
//         );
//       }
//     }
//       return ListView.builder(
//           itemCount: _posts.length + (_isLastPage ? 0 : 1),
//           itemBuilder: (context, index) {

//             if (index == _posts.length - _nextPageTrigger) {
//               fetchData();
//             }
//             if (index == _posts.length) {
//               if (_error) {
//                 return Center(
//                     child: errorDialog(size: 15)
//                 );
//               } else {
//                 return const Center(
//                     child: Padding(
//                       padding: EdgeInsets.all(8),
//                       child: CircularProgressIndicator(),
//                     ));
//               }
//             }
//             final Post post = _posts[index];
//             return Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: PostItem(post.title, post.body)
//             );
//           });
//     }

//     import 'package:flutter/material.dart';

// import 'package:infinte_scroll/base_infinite_scroll/post_overview_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(

//         primarySwatch: Colors.purple,
//       ),
//       home:  MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PostsOverviewScreen()
//     );
//   }
// }

// class ScrollControllerDemo extends StatefulWidget {

//   @override
//   _ScrollControllerDemoState createState() => _ScrollControllerDemoState();
// }
// class _ScrollControllerDemoState extends State<ScrollControllerDemo> {
//   late bool _isLastPage;
//   late int _pageNumber;
//   late bool _error;
//   late bool _loading;
//   late int _numberOfPostsPerRequest;
//   late List<Post> _posts;
//   late ScrollController _scrollController;

//   @override
//   void initState() {
//     super.initState();
//     _pageNumber = 0;
//     _posts = [];
//     _isLastPage = false;
//     _loading = true;
//     _error = false;
//     _numberOfPostsPerRequest = 10;
//     _scrollController = ScrollController();
//     fetchData();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _scrollController.dispose();
//   }

// }

// @override
//   Widget build(BuildContext context) {
//     _scrollController.addListener(() {
// // nextPageTrigger will have a value equivalent to 80% of the list size.
//       var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;

// // _scrollController fetches the next paginated data when the current postion of the user on the screen has surpassed
//       if (_scrollController.position.pixels > nextPageTrigger) {
//         _loading = true;
//         fetchData();
//       }
//     });

//     return Scaffold(
//       appBar: AppBar(title: const Text("Blog App"), centerTitle: true,),
//       body: buildPostsView(),
//     );
//   }

//   Widget buildPostsView() {
//     if (_posts.isEmpty) {
//       if (_loading) {
//         return const Center(
//             child: Padding(
//               padding: EdgeInsets.all(8),
//               child: CircularProgressIndicator(),
//             ));
//       } else if (_error) {
//         return Center(
//             child: errorDialog(size: 20)
//         );
//       }
//     }
//     return ListView.builder(
//         controller: _scrollController,
//         itemCount: _posts.length + (_isLastPage ? 0 : 1),
//         itemBuilder: (context, index) {

//           if (index == _posts.length) {
//             if (_error) {
//               return Center(
//                   child: errorDialog(size: 15)
//               );
//             }
//             else {
//               return const Center(
//                   child: Padding(
//                     padding: EdgeInsets.all(8),
//                     child: CircularProgressIndicator(),
//                   ));
//             }
//           }

//             final Post post = _posts[index];
//             return Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: PostItem(post.title, post.body)
//             );
//         }
//         );
//   }

// //   class InfiniteScrollPaginatorDemo extends StatefulWidget {
// //   @override
// //   _InfiniteScrollPaginatorDemoState createState() => _InfiniteScrollPaginatorDemoState();
// // }

// // class _InfiniteScrollPaginatorDemoState extends State<InfiniteScrollPaginatorDemo> {
// //   final _numberOfPostsPerRequest = 10;

// //   final PagingController<int, Announcement> _pagingController =
// //   PagingController(firstPageKey: 0);

// //   @override
// //   void initState() {
// //     _pagingController.addPageRequestListener((pageKey) {
// //       _fetchPage(pageKey);
// //     });
// //     super.initState();
// //   }

// //  @override
// //   void dispose() {
// //     _pagingController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     // TODO: implement build
// //     throw UnimplementedError();
// //   }

// // }

// // Future<void> _fetchPage(int pageKey) async {
// //     try {
// //       final response = await get(Uri.parse(
// //           "https://jsonplaceholder.typicode.com/posts?_page=$pageKey&_limit=$_numberOfPostsPerRequest"));
// //       List responseList = json.decode(response.body);
// //       List<Announcement> postList = responseList.map((data) =>
// //           Announcement(id: id, build_uid: build_uid, title: title, subtitle: subtitle, date: date, imageUrl: imageUrl)).toList();
// //       final isLastPage = postList.length < _numberOfPostsPerRequest;
// //       if (isLastPage) {
// //         _pagingController.appendLastPage(postList);
// //       } else {
// //         final nextPageKey = pageKey + 1;
// //         _pagingController.appendPage(postList, nextPageKey);
// //       }
// //     } catch (e) {
// //       print("error --> $e");
// //       _pagingController.error = e;
// //     }
// //   }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_publicarea/models/announcement.dart';
import 'package:demo_publicarea/providers/announcement_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/screens/main/an_announcement_screen.dart';
import 'package:demo_publicarea/utils/date_amount_formatter.dart';
import 'package:demo_publicarea/widgets/custom_listitem_medium.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

// class PostsOverviewScreen extends StatefulWidget {
//   @override
//   _PostsOverviewScreenState createState() => _PostsOverviewScreenState();
// }

// late ScrollController _scrollController;

// class _PostsOverviewScreenState extends State<PostsOverviewScreen> {
//   late bool _isLastPage;
//   late int _pageNumber;
//   late bool _error;
//   late bool _loading;
//   final int _numberOfPostsPerRequest = 10;
//   late List<Announcement> _annos;
//   final int _nextPageTrigger = 3;

//   @override
//   void initState() {
//     super.initState();

//     _scrollController = ScrollController();
//     _scrollController.addListener(_scrollListener);
//     _pageNumber = 0;
//     _annos = [];
//     _isLastPage = false;
//     _loading = true;
//     _error = false;
//     fetchData();
//   }

//   void _scrollListener() {
//     if (_scrollController.offset >=
//             _scrollController.position.maxScrollExtent &&
//         !_scrollController.position.outOfRange) {
//       if (!_loading && !_isLastPage) {
//         setState(() {
//           _loading = true;
//         });
//         fetchData();
//       }
//     }
//   }

//   Future<void> fetchData() async {
//     if (_loading) {
//       return;
//     }
//     try {
//       var collection = FirebaseFirestore.instance.collection("announcements");
//       var query = collection.where('build_id', isEqualTo: '0001');
//       query.limit(_numberOfPostsPerRequest);

//       // Firestore'dan verileri alın
//       var querySnapshot = await query.get();

//       List<Announcement> tempList = [];
//       querySnapshot.docs.forEach((element) {
//         var announcement = Announcement(
//           id: element.data()['id'],
//           build_uid: element.data()['build_id'],
//           title: element.data()['title'],
//           subtitle: element.data()['subtitle'],
//           date: element.data()['date'],
//           imageUrl: element.data()['imageUrl'],
//         );
//         tempList.add(announcement);
//       });

//       setState(() {
//         _isLastPage = tempList.length < _numberOfPostsPerRequest;
//         _loading = false;
//         _pageNumber = _pageNumber + 1;
//         _annos.addAll(tempList);
//       });
//     } catch (e) {
//       print("Hata --> $e");
//       setState(() {
//         _loading = false;
//         _error = true;
//       });
//     }
//   }

//   Widget errorDialog({required double size}) {
//     return SizedBox(
//       height: 180,
//       width: 200,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'An error occurred when fetching the posts.',
//             style: TextStyle(
//                 fontSize: size,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           TextButton(
//               onPressed: () {
//                 setState(() {
//                   _loading = true;
//                   _error = false;
//                   fetchData();
//                 });
//               },
//               child: const Text(
//                 "Retry",
//                 style: TextStyle(fontSize: 20, color: Colors.purpleAccent),
//               )),
//         ],
//       ),
//     );
//   }

//   Widget build(BuildContext context) {
//     UserProvider userProvider = Provider.of<UserProvider>(context);
//     _scrollController.addListener(() {
// // nextPageTrigger will have a value equivalent to 80% of the list size.
//       var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;

// // _scrollController fetches the next paginated data when the current postion of the user on the screen has surpassed
//       if (_scrollController.position.pixels > nextPageTrigger) {
//         _loading = true;
//         fetchData();
//       }
//     });
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Blog App"),
//         centerTitle: true,
//       ),
//       body: buildPostsView(),
//     );
//   }

//   Widget buildPostsView() {
//     if (_annos.isEmpty) {
//       if (_loading) {
//         return const Center(
//             child: Padding(
//           padding: EdgeInsets.all(8),
//           child: CircularProgressIndicator(),
//         ));
//       } else if (_error) {
//         return Center(child: errorDialog(size: 20));
//       }
//     }
//     return ListView.builder(
//       controller: _scrollController,
//       itemCount: _annos.length + (_isLastPage ? 0 : 1),
//       itemBuilder: (context, index) {
//         if (index == _annos.length) {
//           if (_loading) {
//             return const Center(
//               child: Padding(
//                 padding: EdgeInsets.all(8),
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           } else if (_error) {
//             return Center(child: errorDialog(size: 15));
//           } else {
//             return const Center(
//               child: Padding(
//                 padding: EdgeInsets.all(8),
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }
//         }
//         final Announcement anno = _annos[index];
//         if (index == _annos.length - _nextPageTrigger) {
//           fetchData(); // Yeni verileri burada yüklüyoruz
//         }
//         return Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: CustomMediumListItem(
//             title: anno.title,
//             text: anno.subtitle,
//             subtitle: NoyaFormatter.generate(anno.date),
//             trailing: IconButton(
//               onPressed: () {
//                 AnnouncementProvider().fetchAnAnnouncement(anno.id.toString());

//                 PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
//                   context,
//                   settings: RouteSettings(
//                     name: AnAnnouncementScreen.routeName,
//                     arguments: anno.id.toString(),
//                   ),
//                   screen: const AnAnnouncementScreen(),
//                   withNavBar: true,
//                   pageTransitionAnimation: PageTransitionAnimation.cupertino,
//                 );
//               },
//               icon: const Icon(Icons.arrow_forward_ios),
//             ),
//             leading: const CircleAvatar(
//               radius: 25,
//               backgroundImage: AssetImage('assets/images/notice.png'),
//             ),
//             image: anno.imageUrl,
//           ),
//         );
//       },
//     );
//   }
// },

//son hali çalışıyor
class InfiniteScrollPaginatorDemo extends StatefulWidget {
  @override
  _InfiniteScrollPaginatorDemoState createState() =>
      _InfiniteScrollPaginatorDemoState();
}

class _InfiniteScrollPaginatorDemoState
    extends State<InfiniteScrollPaginatorDemo> {
  final _numberOfPostsPerRequest = 3;

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
      var query = collection.where('build_id', isEqualTo: '0002');

      if (pageKey > 0) {
        // Sorguyu önceki sayfanın son belgesinden başlatın
        query = query
            .startAfterDocument(lastDocument!); // lastDocument null olamaz.
      }

      // Sorguyu belirli sayıda belge alacak şekilde sınırlayın
      query = query.limit(_numberOfPostsPerRequest);

      // Firestore'dan verileri alın
      var querySnapshot = await query.get();

      List<Announcement> tempList = [];
      var documents = querySnapshot.docs;
      if (documents.isNotEmpty) {
        // Şu anki sayfanın son belgesini kaydedin
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
    return RefreshIndicator(
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
                AnnouncementProvider().fetchAnAnnouncement(item.id.toString());

                PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                  context,
                  settings: RouteSettings(
                    name: AnAnnouncementScreen.routeName,
                    arguments: item.id.toString(),
                  ),
                  screen: const AnAnnouncementScreen(),
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
            image: item.imageUrl,
          ),
        ),
      ),
    );
  }
}
