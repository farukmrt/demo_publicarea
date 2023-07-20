// import 'package:demo_publicarea/models/user.dart';
// import 'package:demo_publicarea/providers/announcement_provider.dart';
// import 'package:demo_publicarea/providers/bill_provider.dart';
// import 'package:demo_publicarea/providers/user_providers.dart';
// import 'package:demo_publicarea/screens/main/all_announcement_screen.dart';
// import 'package:demo_publicarea/screens/main/an_announcement_screen.dart';
// import 'package:demo_publicarea/screens/statement/payment_select_screen.dart';
// import 'package:demo_publicarea/utils/colors.dart';
// import 'package:demo_publicarea/utils/date_amount_formatter.dart';
// import 'package:demo_publicarea/widgets/custom_listItem.dart';
// import 'package:demo_publicarea/widgets/custom_main_button.dart';
// import 'package:demo_publicarea/widgets/custom_text_button.dart';
// import 'package:demo_publicarea/widgets/loading_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// import 'package:provider/provider.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({Key? key}) : super(key: key);

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     // DescriptionProvider descriptionProvider =
//     //     Provider.of<DescriptionProvider>(context);
//     // for (int i = 0; i < 3; i++) {
//     //   Description description = Description(
//     //     titlee: 'Duyuru Başlığı $i',
//     //     subtitlee: 'Duyuru Alt Başlığı $i',
//     //   );
//     //   descriptionProvider.addDescription(description);
//     // }
//     UserProvider userProvider = Provider.of<UserProvider>(context);

//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             Container(
//               height: screenHeight / 4,
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 color: primaryColor,
//                 borderRadius: BorderRadius.only(
//                   bottomRight: Radius.circular(45),
//                 ),
//               ),
//               child: Stack(
//                 children: [
//                   Positioned(
//                     left: 0,
//                     child: Image.asset(
//                       'assets/images/oval.png',
//                       scale: 1,
//                       alignment: Alignment.centerLeft,
//                     ),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Column(
//                         children: [
//                           Row(
//                             children: [
//                               const Padding(
//                                 padding: EdgeInsets.all(5),
//                               ),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       '${userProvider.user.name} ${userProvider.user.surname}',
//                                       style: const TextStyle(
//                                           fontSize: 17,
//                                           fontWeight: FontWeight.bold,
//                                           color: mainBackgroundColor),
//                                     ),
//                                     Text(
//                                       userProvider.user.building,
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         color: mainBackgroundColor,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               //bu kısmın firebase üzerinden güncelleme yaptığım zaman anlık olarak değişmesini istiyorum ancak
//                               // değişiklik firebase'e ve storage kısımlarına anında yansımasına rağmen anlık güncellenmiyor
//                               Padding(
//                                 padding: const EdgeInsets.all(10),
//                                 child:
//                                     //  Consumer<UserProvider>(
//                                     //   builder: (context, data, index) {
//                                     StreamBuilder<User>(
//                                   stream: userProvider.userStream,
//                                   builder: (context, snapshot) {
//                                     if (snapshot.hasData) {
//                                       User auser = snapshot.data!;
//                                       return CircleAvatar(
//                                         foregroundImage:
//                                             NetworkImage(auser.imageUrl),
//                                         radius: 45,
//                                       );
//                                     } else {
//                                       return const LoadingIndicator();
//                                     }
//                                   },
//                                 ),
//                                 //   },
//                                 // ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 15),
//                           Row(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(10),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       'Borcunuz',
//                                       style: TextStyle(
//                                           fontSize: 15, color: Colors.white),
//                                     ),
//                                     Consumer<BillProvider>(
//                                       builder: (context, data, index) {
//                                         return StreamBuilder<double>(
//                                           stream: data.fetchAmountTotalStatus(
//                                               false,
//                                               userProvider.user.apartmentId),
//                                           builder: (BuildContext context,
//                                               AsyncSnapshot<double> snapshot) {
//                                             if (snapshot.connectionState ==
//                                                 ConnectionState.waiting) {
//                                               return const Center(
//                                                 child:
//                                                     CircularProgressIndicator(),
//                                               );
//                                             } else if (snapshot.hasError) {
//                                               return const Text(
//                                                   'Hata: Veriler alınamadı.');
//                                             } else {
//                                               double totalAmount =
//                                                   snapshot.data ?? 0.0;
//                                               return Text(
//                                                 NoyaFormatter.generateAmount(
//                                                     totalAmount),
//                                                 style: const TextStyle(
//                                                   fontSize: 20,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.white,
//                                                 ),
//                                               );
//                                             }
//                                           },
//                                         );
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             // //1.TASARIM
//             CustomMainButton(
//                 edgeInsets: //custommain'e bu deger verilmediginde hata ekrani geliyor
//                     const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
//                 onTap: () {
//                   PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
//                     context,
//                     settings:
//                         RouteSettings(name: PaymentSelectScreen.routeName),
//                     screen: const PaymentSelectScreen(),
//                     withNavBar: true,
//                     pageTransitionAnimation: PageTransitionAnimation.cupertino,
//                   );
//                 },
//                 icon: Icons.redo_outlined,
//                 text: 'Ödeme Yap'),

//             // //2.TASARIM
//             // CustomIconbutton(
//             //   title: 'Ödeme Yap',
//             //   size: 50,
//             //   icon: Icons.wallet_outlined,
//             //   ontap: () {
//             //     Navigator.of(context, rootNavigator: false).push(
//             //         MaterialPageRoute(
//             //             builder: (context) => const PaymentSelectScreen(),
//             //             maintainState: true));
//             //   },
//             // ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 CustomTextButton(
//                     onTap: () {
//                       PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
//                         context,
//                         settings: RouteSettings(
//                             name: AllAnnouncementScreen.routeName),
//                         screen: const AllAnnouncementScreen(),
//                         withNavBar: true,
//                         pageTransitionAnimation:
//                             PageTransitionAnimation.cupertino,
//                       );
//                     },
//                     text: 'Tümünü gör ->'),
//                 const SizedBox(width: 10),
//               ],
//             ),

//             Expanded(
//               child: Consumer<AnnouncementProvider>(
//                 builder: (context, data, index) {
//                   // var announcements = await data.fetchAnnouncement();

//                   return StreamBuilder(
//                     stream: data.fetchAnnouncement(userProvider.user.buildingId,
//                         limit: 6),
//                     builder: (BuildContext context, snapshot) {
//                       if (snapshot.hasData) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return const Center(
//                             child: LoadingIndicator(),
//                           );
//                         } else {
//                           return ListView.builder(
//                             itemCount: snapshot.data?.length,
//                             itemBuilder: (context, index) {
//                               var announcement = snapshot.data?[index];

//                               return CustomListItem(
//                                 title: announcement!.title,
//                                 subtitle: announcement.subtitle,
//                                 trailing: IconButton(
//                                   onPressed: () {
//                                     AnnouncementProvider().fetchAnAnnouncement(
//                                         announcement.id.toString());

//                                     //print(index);
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
//                               );

//                               // ListTile(
//                               //   title: Text(announcement!['title']),
//                               //   subtitle: Text(announcement!['subtitle']),
//                               //   //  IconButton(
//                               //   //   icon: Icon(Icons.edit),
//                               //   //   onPressed: () async {
//                               //   //     try {
//                               //   //       AnnouncementProvider().updateAnnouncement(
//                               //   //         announcement['id'],
//                               //   //         announcement['title'],
//                               //   //         announcement['subtitle'],
//                               //   //       );
//                               //   //     } on Exception catch (_) {}
//                               //   //   },
//                               //   // ),
//                               // );
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
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:demo_publicarea/models/user.dart';
import 'package:demo_publicarea/providers/announcement_provider.dart';
import 'package:demo_publicarea/providers/bill_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/screens/main/all_announcement_screen.dart';
import 'package:demo_publicarea/screens/main/an_announcement_screen.dart';
import 'package:demo_publicarea/screens/statement/payment_select_screen.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/utils/date_amount_formatter.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/widgets/custom_text_button.dart';
import 'package:demo_publicarea/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Kullanıcı verilerini saklamak için bir değişken
  // UserModel? _user; // Kullanıcı verilerini saklamak için bir değişken
  UserModel? _user; // Kullanıcı verilerini saklamak için bir değişken

  // @override
  // void initState() {
  //   super.initState();
  //   // UserProvider'ı dinleyin ve aldığınız UserModel'i _user değişkenine atayın
  //   UserProvider userProvider =
  //       Provider.of<UserProvider>(context, listen: false);
  //   userProvider.userStream.listen((user) {
  //     setState(() {
  //       _user = user;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: screenHeight / 4,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(45),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    child: Image.asset(
                      'assets/images/oval.png',
                      scale: 1,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(5),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${userProvider.user.name} ${userProvider.user.surname}',
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: mainBackgroundColor),
                                    ),
                                    Text(
                                      userProvider.user.building,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: mainBackgroundColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: StreamBuilder<UserModel>(
                                  stream: userProvider
                                      .userStream, // UserProvider'daki veri akışını dinleyin
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      UserModel user = snapshot.data!;
                                      return CircleAvatar(
                                        foregroundImage:
                                            NetworkImage(user.imageUrl),
                                        radius: 45,
                                      );
                                    } else {
                                      return const LoadingIndicator();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Borcunuz',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    Consumer<BillProvider>(
                                      builder: (context, data, index) {
                                        return StreamBuilder<double>(
                                          stream: data.fetchAmountTotalStatus(
                                              false,
                                              userProvider.user.apartmentId),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<double> snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else if (snapshot.hasError) {
                                              return const Text(
                                                  'Hata: Veriler alınamadı.');
                                            } else {
                                              double totalAmount =
                                                  snapshot.data ?? 0.0;
                                              return Text(
                                                NoyaFormatter.generateAmount(
                                                    totalAmount),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              );
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // //1.TASARIM
            CustomMainButton(
              edgeInsets:
                  const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              onTap: () {
                PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                  context,
                  settings: RouteSettings(name: PaymentSelectScreen.routeName),
                  screen: const PaymentSelectScreen(),
                  withNavBar: true,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              icon: Icons.redo_outlined,
              text: 'Ödeme Yap',
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomTextButton(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                      context,
                      settings: RouteSettings(
                        name: AllAnnouncementScreen.routeName,
                      ),
                      screen: const AllAnnouncementScreen(),
                      withNavBar: true,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  text: 'Tümünü gör ->',
                ),
                const SizedBox(width: 10),
              ],
            ),

            Expanded(
              child: Consumer<AnnouncementProvider>(
                builder: (context, data, index) {
                  return StreamBuilder(
                    stream: data.fetchAnnouncement(
                      userProvider.user.buildingId,
                      limit: 6,
                    ),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: LoadingIndicator(),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              var announcement = snapshot.data?[index];

                              return CustomListItem(
                                title: announcement!.title,
                                subtitle: announcement.subtitle,
                                trailing: IconButton(
                                  onPressed: () {
                                    AnnouncementProvider().fetchAnAnnouncement(
                                        announcement.id.toString());

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
          ],
        ),
      ),
    );
  }
}
