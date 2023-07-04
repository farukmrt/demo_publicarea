// import 'package:provider/provider.dart';
// import 'package:demo_publicarea/providers/user_providers.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/screens/main/main_screen.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/screens/request/request_screen.dart';
import 'package:demo_publicarea/screens/settings/settings_screen.dart';
import 'package:demo_publicarea/screens/statement/statement_screen.dart';
import 'package:demo_publicarea/screens/statement/payment_select_screen.dart';

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
    //const PaymentSelectScreen(),
    //
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
      //drawerScrimColor: Colors.red,
      backgroundColor: mainBackgroundColor,
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
          //BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'deneme'),
        ],
        //selectedIconTheme: const IconThemeData(color: buttonColor),
      ),
      body: pages[_page],
    );
  }
}

// import 'package:custom_navigator/custom_scaffold.dart';
// import 'package:demo_publicarea/screens/main_screen.dart';
// import 'package:demo_publicarea/screens/request/request_screen.dart';
// import 'package:demo_publicarea/screens/settings/settings_screen.dart';
// import 'package:demo_publicarea/screens/statement/statement_screen.dart';
// import 'package:flutter/material.dart';

// class TabsScreen extends StatelessWidget {
//   static String routeName = '/tabs';
//   const TabsScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       scaffold: Scaffold(
//         bottomNavigationBar: BottomNavigationBar(
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.abc), label: '1213'),
//             BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'sfd'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.add_to_drive), label: 'ghj'),
//             BottomNavigationBarItem(icon: Icon(Icons.album), label: 'uıop'),
//           ],
//         ),
//       ),
//       children: <Widget>[
//         const MainScreen(),
//         const StatementScreen(),
//         const RequestScreen(),
//         const SettingsScreen(),
//       ],
//     );
//   }
// }
