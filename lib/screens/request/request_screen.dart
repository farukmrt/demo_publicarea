import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:demo_publicarea/providers/request_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/screens/request/create_request_screen.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/widgets/custom_request_card.dart';
import 'package:demo_publicarea/widgets/custom_text_block.dart';
import 'package:demo_publicarea/widgets/custom_title.dart';
import 'package:demo_publicarea/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import 'a_request_screen.dart';

class RequestScreen extends StatefulWidget {
  static String routeName = '/request';
  const RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    RequestProvider requestProvider = Provider.of<RequestProvider>(context);

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
              toolbarHeight: 20,
              backgroundColor: mainBackgroundColor,
              title: CustomTitle(
                mainTitle: 'Yeni Talep',
                button: Icons.add,
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                    context,
                    settings: RouteSettings(
                      name: CreateRequestScreen.routeName,
                      arguments: {
                        'apartmentId': userProvider.user.apartmentId,
                        'userUid': userProvider.user.uid
                      },
                    ),
                    screen: const CreateRequestScreen(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
              ),
            ),
            body: Container(
              color: mainBackgroundColor,
              child: Column(
                children: <Widget>[
                  ButtonsTabBar(
                    backgroundColor: primaryColor,
                    unselectedBackgroundColor: borderccc,
                    unselectedLabelStyle: const TextStyle(color: buttonColor),
                    //renk değeri verilmiyor
                    labelStyle: const TextStyle(color: mainBackgroundColor),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    radius: 30,
                    tabs: [
                      Tab(
                        child: Row(
                          children: const [
                            Icon(
                              Icons.pending_outlined,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Güncel Talepler",
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          children: const [
                            Icon(
                              Icons.task_alt_outlined,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Tamamlanmış T.",
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Center(
                          child: Container(
                            color: backgroundColor,
                            child: Consumer<RequestProvider>(
                              builder: (context, data, index) {
                                return StreamBuilder(
                                  stream: data.fetchRequestByStatus(
                                    true,
                                    userProvider.user.apartmentId,
                                  ),
                                  builder: (BuildContext context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: LoadingIndicator(),
                                        );
                                      } else {
                                        if (snapshot.data?.isEmpty ?? true) {
                                          // Liste boşsa buradaki widget dönecek
                                          return Column(children: [
                                            const SizedBox(
                                              height: 80,
                                            ),
                                            Image.asset(
                                                'assets/images/rafiki.png'),
                                            const SizedBox(height: 25),
                                            const CustomTextBlock(
                                              maintext:
                                                  'Güncel Talebiniz Bulunmuyor',
                                              subtext:
                                                  'Öneri, talep ve şikayetlerinizi yönetiminize “Yeni Talep” oluşturarak iletebilirsiniz.',
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            CustomMainButton(
                                              edgeInsets:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 55),
                                              onTap: () {
                                                PersistentNavBarNavigator
                                                    .pushNewScreenWithRouteSettings(
                                                  context,
                                                  settings: RouteSettings(
                                                    name: CreateRequestScreen
                                                        .routeName,
                                                    arguments: {
                                                      'apartmentId':
                                                          userProvider
                                                              .user.apartmentId,
                                                      'userUid':
                                                          userProvider.user.uid
                                                    },
                                                  ),
                                                  screen:
                                                      const CreateRequestScreen(),
                                                  withNavBar: true,
                                                  pageTransitionAnimation:
                                                      PageTransitionAnimation
                                                          .cupertino,
                                                );
                                              },
                                              text: 'Yeni Talep ',
                                              icon: Icons.add,
                                            ),
                                          ]);
                                        } else {
                                          return ListView.builder(
                                            itemCount: snapshot.data?.length,
                                            itemBuilder: (context, index) {
                                              var request =
                                                  snapshot.data?[index];

                                              return CustomRequestCard(
                                                requestType:
                                                    request!.requestType,
                                                requestTitle:
                                                    request.requestTitle,
                                                apartmentNumber:
                                                    request.apartmentNumber,
                                                status: request.status,
                                                onTap: () {
                                                  PersistentNavBarNavigator
                                                      .pushNewScreenWithRouteSettings(
                                                    context,
                                                    settings: RouteSettings(
                                                      name: ARequestScreen
                                                          .routeName,
                                                      arguments: request
                                                          .requestId
                                                          .toString(),
                                                    ),
                                                    screen:
                                                        const ARequestScreen(),
                                                    withNavBar: true,
                                                    pageTransitionAnimation:
                                                        PageTransitionAnimation
                                                            .cupertino,
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        }
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
                        Center(
                          child: Container(
                            color: backgroundColor,
                            child: Consumer<RequestProvider>(
                              builder: (context, data, index) {
                                return StreamBuilder(
                                  stream: data.fetchRequestByStatus(
                                    false,
                                    userProvider.user.apartmentId,
                                  ),
                                  builder: (BuildContext context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: LoadingIndicator(),
                                        );
                                      } else {
                                        if (snapshot.data?.isEmpty ?? true) {
                                          // Liste boşsa buradaki widget dönecek
                                          return Column(children: [
                                            const SizedBox(
                                              height: 80,
                                            ),
                                            Image.asset(
                                                'assets/images/rafiki.png'),
                                            const SizedBox(height: 25),
                                            const CustomTextBlock(
                                              maintext:
                                                  'Tamamlanmış Talebiniz Bulunmuyor',
                                              subtext:
                                                  'Öneri, talep ve şikayetlerinizi yönetiminize “Yeni Talep” oluşturarak iletebilirsiniz.',
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            CustomMainButton(
                                              edgeInsets:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 55),
                                              onTap: () {
                                                PersistentNavBarNavigator
                                                    .pushNewScreenWithRouteSettings(
                                                  context,
                                                  settings: RouteSettings(
                                                      arguments: {
                                                        'apartmentId':
                                                            userProvider.user
                                                                .apartmentId,
                                                        'userUid': userProvider
                                                            .user.uid
                                                      },
                                                      name: CreateRequestScreen
                                                          .routeName),
                                                  screen:
                                                      const CreateRequestScreen(),
                                                  withNavBar: true,
                                                  pageTransitionAnimation:
                                                      PageTransitionAnimation
                                                          .cupertino,
                                                );
                                              },
                                              text: 'Yeni Talep ',
                                              icon: Icons.add,
                                            ),
                                          ]);
                                        } else {
                                          return ListView.builder(
                                            itemCount: snapshot.data?.length,
                                            itemBuilder: (context, index) {
                                              var request =
                                                  snapshot.data?[index];

                                              return CustomRequestCard(
                                                requestType:
                                                    request!.requestType,
                                                requestTitle:
                                                    request.requestTitle,
                                                apartmentNumber:
                                                    request.apartmentNumber,
                                                status: request.status,
                                                onTap: () {
                                                  PersistentNavBarNavigator
                                                      .pushNewScreenWithRouteSettings(
                                                    context,
                                                    settings: RouteSettings(
                                                      name: ARequestScreen
                                                          .routeName,
                                                      arguments: request
                                                          .requestId
                                                          .toString(),
                                                    ),
                                                    screen:
                                                        const ARequestScreen(),
                                                    withNavBar: true,
                                                    pageTransitionAnimation:
                                                        PageTransitionAnimation
                                                            .cupertino,
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        }
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


//Image.asset('assets/images/rafiki.png'),
//                 const SizedBox(height: 25),
//                 const CustomTextBlock(
//                   maintext: 'Güncel Talebiniz Bulunmuyor',
//                   subtext:
//                       'Öneri, talep ve şikayetlerinizi yönetiminize “Yeni Talep” oluşturarak iletebilirsiniz.',
//                 ),
//                 // const CustomTitle(
//                 //   mainTitle: 'Güncel Talebiniz Bulunmuyor',
//                 //   // subtitle:
//                 //   //     'Öneri, talep ve şikayetlerinizi yönetiminize “Yeni Talep” oluşturarak iletebilirsiniz.',
//                 // ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 CustomMainButton(
//                   edgeInsets: const EdgeInsets.symmetric(horizontal: 55),
//                   onTap: () {
//                     PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
//                       context,
//                       settings:
//                           RouteSettings(name: CreateRequestScreen.routeName),
//                       screen: const CreateRequestScreen(),
//                       withNavBar: true,
//                       pageTransitionAnimation:
//                           PageTransitionAnimation.cupertino,
//                     );
//                   },
//                   text: 'Yeni Talep ',
//                   icon: Icons.add,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );