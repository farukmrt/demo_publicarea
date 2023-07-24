import 'package:demo_publicarea/providers/bill_provider.dart';
import 'package:demo_publicarea/providers/payment_provider.dart';
import 'package:demo_publicarea/providers/photo_provider.dart';
import 'package:demo_publicarea/providers/request_provider.dart';
import 'package:demo_publicarea/screens/main/all_announcement_screen.dart';
import 'package:demo_publicarea/screens/main/an_announcement_screen.dart';
import 'package:demo_publicarea/screens/request/a_request_screen.dart';
import 'package:demo_publicarea/screens/request/create_request_screen.dart';
import 'package:demo_publicarea/screens/request/request_screen.dart';
import 'package:demo_publicarea/screens/settings/kvkk_screen.dart';
import 'package:demo_publicarea/screens/settings/profile_settings_screen.dart';
import 'package:demo_publicarea/screens/settings/user_agreement.dart';
import 'package:demo_publicarea/screens/statement/credit_card_screen.dart';
import 'package:demo_publicarea/screens/statement/itemized_account_screen.dart';
import 'package:demo_publicarea/screens/statement/payment_select_screen.dart';
import 'package:demo_publicarea/providers/announcement_provider.dart';
import 'package:demo_publicarea/screens/statement/unpaid_itemized_account_screen.dart';
import 'models/user.dart' as model;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/screens/main/tabs_screen.dart';
import 'package:demo_publicarea/screens/login/login_screen.dart';
import 'package:demo_publicarea/screens/login/signup_screen.dart';
import 'package:demo_publicarea/screens/login/onboard_screen.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/widgets/loading_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //options: DefaultFirebaseOptions.currentPlatform,
      );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
    ChangeNotifierProvider<AnnouncementProvider>(
        create: (_) => AnnouncementProvider()),
    ChangeNotifierProvider<BillProvider>(create: (_) => BillProvider()),
    ChangeNotifierProvider<PaymentProvider>(create: (_) => PaymentProvider()),
    ChangeNotifierProvider<RequestProvider>(create: (_) => RequestProvider()),
    ChangeNotifierProvider<PhotoProvider>(create: (_) => PhotoProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'publicarea',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        //elevatedbutton'un varsayilan rengi veriliyor
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonColor),
          ),
        ),
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: backgroundColor,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        useMaterial3: true,
      ),
      routes: {
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignupScreen.routeName: (context) => const SignupScreen(),
        TabsScreen.routeName: (context) => const TabsScreen(),
        PaymentSelectScreen.routeName: (context) => const PaymentSelectScreen(),
        ItemizedAccountScreen.routeName: (context) =>
            const ItemizedAccountScreen(),
        UnpaidItemizedAccountScreen.routeName: (context) =>
            const UnpaidItemizedAccountScreen(),
        CreditCardScreen.routeName: (context) => const CreditCardScreen(
              arguments: {},
            ),
        // LiveRequestScreen.routeName: (context) => const LiveRequestScreen(),
        CreateRequestScreen.routeName: (context) => const CreateRequestScreen(),
        RequestScreen.routeName: (context) => const RequestScreen(),
        // CompleteRequestScreen.routeName: (context) =>
        //     const CompleteRequestScreen(),
        AllAnnouncementScreen.routeName: (context) =>
            const AllAnnouncementScreen(),
        AnAnnouncementScreen.routeName: (context) =>
            const AnAnnouncementScreen(),
        ARequestScreen.routeName: (context) => const ARequestScreen(),
        ProfileSettingsScreen.routeName: (context) =>
            const ProfileSettingsScreen(),
        KvkkScreen.routeName: (context) => const KvkkScreen(),
        UserAgreementScreen.routeName: (context) => const UserAgreementScreen(),
      },
      home: FutureBuilder<model.UserModel?>(
        future: UserProvider().getCurrentUser(
            FirebaseAuth.instance.currentUser != null
                ? FirebaseAuth.instance.currentUser!.uid
                : null),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }

          // eger kullanici mevcutsa direk ana ekrana yonlendirir

          //snapashot'ın datasını incele
          if (snapshot.hasData && snapshot.data != null) {
            Provider.of<UserProvider>(context, listen: false)
                .updateUser(snapshot.data!);
            return const TabsScreen();
          }

          return const OnboardingScreen();
        },
      ),
      // FutureBuilder(
      //   future:

      //       // UserProvider().getCurrentUser(
      //       //     FirebaseAuth.instance.currentUser != null
      //       //         ? FirebaseAuth.instance.currentUser!.uid
      //       //         : null),

      //       UserProvider()
      //           .getCurrentUser(FirebaseAuth.instance.currentUser != null
      //               ? FirebaseAuth.instance.currentUser!.uid
      //               : null)
      //           .then((value) {
      //     if (value != null) {
      //       Provider.of<UserProvider>(context, listen: false).setUser(
      //         model.UserModel.fromMap(value as Map<String, dynamic>),
      //       );
      //     }
      //     return value;
      //   }),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const LoadingIndicator();
      //     }

      //     //eger kullanici mevcutsa direk ana ekrana yonlendirir
      //     if (snapshot.hasData) {
      //       return const TabsScreen();
      //     }
      //     return const OnboardingScreen();
      //   },
      // ),
    );
  }
}
