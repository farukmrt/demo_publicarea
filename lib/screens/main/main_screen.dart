// import 'package:uuid/uuid.dart';
// import 'package:demo_publicarea/utils/utils.dart';
// import 'package:demo_publicarea/widgets/custom_main_button.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:demo_publicarea/models/announcement.dart';
// import 'package:demo_publicarea/models/user.dart';
import 'package:demo_publicarea/providers/announcement_provider.dart';
import 'package:demo_publicarea/providers/bill_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/screens/statement/payment_select_screen.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/utils/date_amount_formatter.dart';
import 'package:demo_publicarea/widgets/custom_button.dart';
import 'package:demo_publicarea/widgets/custom_column_button.dart';
import 'package:demo_publicarea/widgets/custom_listItem.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // DescriptionProvider descriptionProvider =
    //     Provider.of<DescriptionProvider>(context);
    // for (int i = 0; i < 3; i++) {
    //   Description description = Description(
    //     titlee: 'Duyuru Başlığı $i',
    //     subtitlee: 'Duyuru Alt Başlığı $i',
    //   );
    //   descriptionProvider.addDescription(description);
    // }
    UserProvider userProvider = Provider.of<UserProvider>(context);
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
                              const Padding(
                                padding: EdgeInsets.all(10),
                                child: CircleAvatar(
                                  foregroundImage:
                                      AssetImage('assets/images/pp.png'),
                                  radius: 35,
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
                                        return FutureBuilder<double>(
                                          future: data
                                              .fetchAmountTotalStatus(false),
                                          builder:
                                              (BuildContext context, snapshot) {
                                            //var bill = snapshot.data?;
                                            if (snapshot.hasData) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                  child: LoadingIndicator(),
                                                );
                                              } else {
                                                return Text(
                                                  NoyaFormatter.generateAmount(
                                                      snapshot.data),
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                );
                                              }
                                            } else if (snapshot.hasError) {
                                              return const Text('no data');
                                            }
                                            return const LoadingIndicator();
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
                edgeInsets: //custommain'e bu deger verilmediginde hata ekrani geliyor
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                onTap: () {
                  Navigator.of(context, rootNavigator: false).push(
                      MaterialPageRoute(
                          builder: (context) => const PaymentSelectScreen(),
                          maintainState: true));
                },
                icon: Icons.redo_outlined,
                text: 'Ödeme Yap'),

            // //2.TASARIM
            // CustomIconbutton(
            //   title: 'Ödeme Yap',
            //   size: 50,
            //   icon: Icons.wallet_outlined,
            //   ontap: () {
            //     Navigator.of(context, rootNavigator: false).push(
            //         MaterialPageRoute(
            //             builder: (context) => const PaymentSelectScreen(),
            //             maintainState: true));
            //   },
            // ),

            Expanded(child: Consumer<AnnouncementProvider>(
              builder: (context, data, index) {
                // var announcements = await data.fetchAnnouncement();

                return FutureBuilder(
                  future: data.fetchAnnouncement(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                                onPressed: () {},
                                icon: const Icon(Icons.arrow_forward_ios),
                              ),
                              leading: const CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage('assets/images/notice.png'),
                              ),
                            );

                            // ListTile(
                            //   title: Text(announcement!['title']),
                            //   subtitle: Text(announcement!['subtitle']),
                            //   //  IconButton(
                            //   //   icon: Icon(Icons.edit),
                            //   //   onPressed: () async {
                            //   //     try {
                            //   //       AnnouncementProvider().updateAnnouncement(
                            //   //         announcement['id'],
                            //   //         announcement['title'],
                            //   //         announcement['subtitle'],
                            //   //       );
                            //   //     } on Exception catch (_) {}
                            //   //   },
                            //   // ),
                            // );
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
            )),
          ],
        ),
      ),
    );
  }
}
