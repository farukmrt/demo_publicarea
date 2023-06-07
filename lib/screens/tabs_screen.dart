import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/screens/main_screen.dart';
import 'package:demo_publicarea/screens/request_screen.dart';
import 'package:demo_publicarea/screens/settings_screen.dart';
import 'package:demo_publicarea/screens/statement_screen.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  static String routeName = '/tabs';
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _page = 0;
  List<Widget> pages = [
    const MainScreen(),
    const StatementScreen(),
    const RequestScreen(),
    const SettingsScreen(),
    // const Center(
    //   child: Text('slşdfkg'),
    // )
  ];

  onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      drawerScrimColor: Colors.red,
      //backgroundColor: Colors.red,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: buttonColor,
        unselectedItemColor: mainColor,
        showUnselectedLabels: false,
        unselectedLabelStyle: const TextStyle(color: mainColor),
        onTap: onPageChange,
        currentIndex: _page,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'Anasayfa',
            //activeIcon: Align(alignment: Alignment.centerRight),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.description_outlined,
            ),
            label: 'Hesap Özeti',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.textsms_outlined,
            ),
            label: 'Taleplerim',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.view_headline_outlined,
            ),
            label: 'Ayarlar',
          ),
        ],
      ),
      body: pages[_page],
    );
  }
}
