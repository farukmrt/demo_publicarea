import 'package:demo_publicarea/screens/request/live_request_screen.dart';
import 'package:demo_publicarea/screens/request/create_request_screen.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/widgets/custom_button.dart';
import 'package:demo_publicarea/widgets/custom_main_button.dart';
import 'package:demo_publicarea/widgets/custom_text_block.dart';
import 'package:demo_publicarea/widgets/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class RequestScreen extends StatefulWidget {
  static String routeName = '/request';
  const RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: backgroundColor,
          // padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomTitle(
                mainTitle: 'Yeni Talep',
                button: Icons.add,
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                    context,
                    settings:
                        RouteSettings(name: CreateRequestScreen.routeName),
                    screen: const CreateRequestScreen(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
              ),
              Container(
                color: mainBackgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconbutton(
                      title: 'Güncel Talepler',
                      icon: Icons.pending_outlined,
                      color: paidc.shade400,
                      onTap: () {
                        PersistentNavBarNavigator
                            .pushNewScreenWithRouteSettings(
                          context,
                          settings:
                              RouteSettings(name: LiveRequestScreen.routeName),
                          screen: const LiveRequestScreen(),
                          withNavBar: true,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                    ),
                    CustomIconbutton(
                      title: 'Tamamlanmış T.',
                      icon: Icons.task_alt_outlined,
                      color: paidc.shade400,
                      onTap: () {},
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Image.asset('assets/images/rafiki.png'),
              const SizedBox(height: 25),
              const CustomTextBlock(
                maintext: 'Güncel Talebiniz Bulunmuyor',
                subtext:
                    'Öneri, talep ve şikayetlerinizi yönetiminize “Yeni Talep” oluşturarak iletebilirsiniz.',
              ),
              // const CustomTitle(
              //   mainTitle: 'Güncel Talebiniz Bulunmuyor',
              //   // subtitle:
              //   //     'Öneri, talep ve şikayetlerinizi yönetiminize “Yeni Talep” oluşturarak iletebilirsiniz.',
              // ),
              const SizedBox(
                height: 30,
              ),
              CustomMainButton(
                edgeInsets: const EdgeInsets.symmetric(horizontal: 55),
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                    context,
                    settings:
                        RouteSettings(name: CreateRequestScreen.routeName),
                    screen: const CreateRequestScreen(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                text: 'Yeni Talep ',
                icon: Icons.add,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
