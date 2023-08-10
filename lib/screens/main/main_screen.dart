import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/providers/bill_provider.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/widgets/loading_indicator.dart';
import 'package:demo_publicarea/widgets/custom_text_button.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/utils/date_amount_formatter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:demo_publicarea/widgets/custom_listitem_medium.dart';
import 'package:demo_publicarea/providers/announcement_provider.dart';
import 'package:demo_publicarea/screens/main/announcement_screen.dart';
import 'package:demo_publicarea/screens/main/announcement_detail_screen.dart';
import 'package:demo_publicarea/screens/statement/payment_select_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);

    var trnslt = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return Container(
      color: primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                height: size.height /
                    3.5, // screenHeight / 4,//iphone8 ekranına uyumlu hale geldi
                width: size.width, // double.infinity,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${userProvider.currentUser.name} ${userProvider.currentUser.surname}',
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: mainBackgroundColor),
                                      ),
                                      Text(
                                        userProvider.currentUser.building,
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
                                    foregroundImage: NetworkImage(
                                        userProvider.currentUser.imageUrl),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              userProvider
                                                  .currentUser.apartmentId,
                                            ),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<double>
                                                    snapshot) {
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
              CustomMainButton(
                edgeInsets:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                    context,
                    settings:
                        RouteSettings(name: PaymentSelectScreen.routeName),
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
                            'buildingId': userProvider.currentUser.buildingId,
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
                        userProvider.currentUser.buildingId,
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
                                    child: CustomListItem(
                                      title: announcementList.title,
                                      subtitle: announcementList.subtitle,
                                      trailing: IconButton(
                                        onPressed: () {
                                          AnnouncementProvider()
                                              .fetchAnAnnouncement(
                                                  announcementList.id
                                                      .toString());

                                          PersistentNavBarNavigator
                                              .pushNewScreenWithRouteSettings(
                                            context,
                                            settings: RouteSettings(
                                              name: AnnouncementDetailScreen
                                                  .routeName,
                                              arguments: announcementList.id
                                                  .toString(),
                                            ),
                                            screen:
                                                const AnnouncementDetailScreen(),
                                            withNavBar: true,
                                            pageTransitionAnimation:
                                                PageTransitionAnimation
                                                    .cupertino,
                                          );
                                        },
                                        icon:
                                            const Icon(Icons.arrow_forward_ios),
                                      ),
                                      leading: const CircleAvatar(
                                        radius: 25,
                                        backgroundImage: AssetImage(
                                            'assets/images/notice.png'),
                                      ),
                                    ),
                                  );
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
