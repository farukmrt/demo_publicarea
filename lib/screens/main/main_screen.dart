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
//                                     StreamBuilder<UserModel>(
//                                   stream: userProvider.userStream,
//                                   builder: (context, snapshot) {
//                                     if (snapshot.hasData) {
//                                       UserModel auser = snapshot.data!;
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
//                              );
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

import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/models/user.dart';
import 'package:demo_publicarea/providers/announcement_provider.dart';
import 'package:demo_publicarea/providers/bill_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/screens/main/announcement_screen.dart';
import 'package:demo_publicarea/screens/main/announcement_detail_screen.dart';
import 'package:demo_publicarea/screens/statement/payment_select_screen.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/utils/date_amount_formatter.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:demo_publicarea/widgets/custom_listitem_medium.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/widgets/custom_text_button.dart';
import 'package:demo_publicarea/widgets/loading_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  UserModel? _user; // Kullanıcı verilerini sakla

  @override
  void initState() {
    super.initState();
    // UserProvider'ı dinle alınan UserModel'i _user değişkenine ata
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    userProvider.userStream.listen((user) {
      setState(() {
        _user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size;

    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false); //degistirr

    var trnslt = AppLocalizations.of(context)!;

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
                                      //'${_user?.name} ${_user?.surname}',
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: mainBackgroundColor),
                                    ),
                                    Text(
                                      userProvider.user.building,
                                      //_user!.building,
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
                                child: CircleAvatar(
                                  foregroundImage:
                                      NetworkImage(//_user!.imageUrl),
                                          userProvider.user.imageUrl),
                                  radius: size.width / 8.6,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height / 115),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      trnslt.lcod_lbl_your_debt,
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    Consumer<BillProvider>(
                                      builder: (context, data, index) {
                                        return StreamBuilder<double>(
                                          stream: data.fetchAmountTotalStatus(
                                            false,
                                            //_user!.apartmentId,
                                            userProvider.user.apartmentId,
                                          ),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<double> snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text(trnslt
                                                  .lcod_lbl_error_data_not_received);
                                            } else if (snapshot.hasData) {
                                              // Veri mevcut olduğunda erişim yapın
                                              double totalAmount =
                                                  snapshot.data!;
                                              return Text(
                                                NoyaFormatter.generateAmount(
                                                    totalAmount),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              );
                                            } else {
                                              return Text(trnslt
                                                  .lcod_lbl_data_not_received);
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
              text: trnslt.lcod_lbl_to_pay,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomTextButton(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                      context,
                      settings: RouteSettings(
                        arguments: {
                          'buildingId': //_user!.buildingId,
                              userProvider.user.buildingId,
                        },
                        name: AnnouncementScreen.routeName,
                      ),
                      screen: const AnnouncementScreen(),
                      withNavBar: true,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  text: trnslt.lcod_lbl_see_all,
                ),
                const SizedBox(width: 10),
              ],
            ),

            Expanded(
              child: Consumer<AnnouncementProvider>(
                builder: (context, data, index) {
                  return StreamBuilder(
                    stream: data.fetchPage(
                      //_user!.buildingId,
                      userProvider.user.buildingId,
                      limit: 6,
                      // pageKey: 6,
                    ),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: LoadingIndicator(),
                          );
                        } else {
                          var announcement = snapshot.data;
                          if (announcement == null || announcement.isEmpty) {
                            return CustomMediumListItem(
                              image:
                                  'https://firebasestorage.googleapis.com/v0/b/fir-publicarea.appspot.com/o/images%2Fmain%2Fempty.png?alt=media&token=d8fd106f-ce63-4f9d-96e1-3e2fc6c20458',
                              text: trnslt.lcod_lbl_no_announcement_1,
                              title: trnslt.lcod_lbl_no_announcement_2,
                              subtitle: trnslt.lcod_lbl_no_announcement_3,
                              color: primaryColor,
                              leading: const Icon(
                                Icons.quiz_outlined,
                                color: primaryColor,
                                size: 40,
                              ),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: announcement.length,
                              itemBuilder: (context, index) {
                                var announcementList = announcement[index];

                                return GestureDetector(
                                  onTap: () {
                                    AnnouncementProvider().fetchAnAnnouncement(
                                        announcementList.id.toString());

                                    PersistentNavBarNavigator
                                        .pushNewScreenWithRouteSettings(
                                      context,
                                      settings: RouteSettings(
                                        name:
                                            AnnouncementDetailScreen.routeName,
                                        arguments:
                                            announcementList.id.toString(),
                                      ),
                                      screen: const AnnouncementDetailScreen(),
                                      withNavBar: true,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                    );
                                  },
                                  child: CustomListItem(
                                    title: announcementList.title,
                                    subtitle: announcementList.subtitle,
                                    trailing: IconButton(
                                      onPressed: () {
                                        AnnouncementProvider()
                                            .fetchAnAnnouncement(
                                                announcementList.id.toString());

                                        PersistentNavBarNavigator
                                            .pushNewScreenWithRouteSettings(
                                          context,
                                          settings: RouteSettings(
                                            name: AnnouncementDetailScreen
                                                .routeName,
                                            arguments:
                                                announcementList.id.toString(),
                                          ),
                                          screen:
                                              const AnnouncementDetailScreen(),
                                          withNavBar: true,
                                          pageTransitionAnimation:
                                              PageTransitionAnimation.cupertino,
                                        );
                                      },
                                      icon: const Icon(Icons.arrow_forward_ios),
                                    ),
                                    leading: const CircleAvatar(
                                      radius: 25,
                                      backgroundImage: AssetImage(
                                          'assets/images/notice.png'),
                                      //NetworkImage(announcement.imageUrl),
                                    ),
                                  ),
                                ); /////
                              },
                            );
                          }
                        }
                      } else if (snapshot.hasError) {
                        return Text(
                            '${trnslt.lcod_lbl_error_snapshot} ${snapshot.error}');
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

  @override
  void dispose() {
    // Kaynakları serbest bırakır
    super.dispose();
  }
}
