import 'package:demo_publicarea/utils/languages/lang.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/screens/main/main_screen.dart';
import 'package:demo_publicarea/screens/request/request_screen.dart';
import 'package:demo_publicarea/screens/settings/settings_screen.dart';
import 'package:demo_publicarea/screens/statement/statement_screen.dart';

class TabsScreen extends StatefulWidget {
  static String routeName = '/tabs';

  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _page = 0;

  final List<Widget> _pageOptions = [
    const MainScreen(),
    const StatementScreen(),
    const RequestScreen(),
    const SettingsScreen(),
  ];

  PersistentTabController? _controller;

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_outlined),
        title: translation(context).lcod_lbl_main_screen,
        activeColorPrimary: buttonColor,
        inactiveColorPrimary: mainColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.description_outlined),
        title: translation(context).lcod_lbl_statement_screen,
        activeColorPrimary: buttonColor,
        inactiveColorPrimary: mainColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.textsms_outlined),
        title: translation(context).lcod_lbl_request_screen,
        activeColorPrimary: buttonColor,
        inactiveColorPrimary: mainColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.view_headline_outlined),
        title: translation(context).lcod_lbl_settings_screen,
        activeColorPrimary: buttonColor,
        inactiveColorPrimary: mainColor,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: _page);
  }

  @override
  Widget build(BuildContext context) {
    // var trnslt = AppLocalizations.of(context)!;

    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _pageOptions,
        items: _navBarItems(),
        confineInSafeArea: true,
        backgroundColor: mainBackgroundColor,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        popAllScreensOnTapOfSelectedTab: true,
        navBarStyle: NavBarStyle.style1,
        popAllScreensOnTapAnyTabs: true,
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
        ),
      ),
    );
  }
}
