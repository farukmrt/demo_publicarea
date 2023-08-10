import 'models/user.dart' as model;
import 'utils/languages/lang.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/providers/bill_provider.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/providers/photo_provider.dart';
import 'package:demo_publicarea/screens/main/tabs_screen.dart';
import 'package:demo_publicarea/widgets/loading_indicator.dart';
import 'package:demo_publicarea/providers/request_provider.dart';
import 'package:demo_publicarea/providers/payment_provider.dart';
import 'package:demo_publicarea/screens/login/login_screen.dart';
import 'package:demo_publicarea/screens/login/signup_screen.dart';
import 'package:demo_publicarea/screens/login/onboard_screen.dart';
import 'package:demo_publicarea/screens/settings/kvkk_screen.dart';
import 'package:demo_publicarea/screens/request/request_screen.dart';
import 'package:demo_publicarea/screens/settings/user_agreement.dart';
import 'package:demo_publicarea/providers/announcement_provider.dart';
import 'package:demo_publicarea/screens/main/announcement_screen.dart';
import 'package:demo_publicarea/screens/settings/update_email_screen.dart';
import 'package:demo_publicarea/screens/statement/credit_card_screen.dart';
import 'package:demo_publicarea/screens/request/request_detail_screen.dart';
import 'package:demo_publicarea/screens/request/create_request_screen.dart';
import 'package:demo_publicarea/screens/settings/update_username_screen.dart';
import 'package:demo_publicarea/screens/main/announcement_detail_screen.dart';
import 'package:demo_publicarea/screens/settings/update_password_screen.dart';
import 'package:demo_publicarea/screens/statement/payment_select_screen.dart';
import 'package:demo_publicarea/screens/settings/profile_settings_screen.dart';
import 'package:demo_publicarea/screens/statement/itemized_account_screen.dart';
import 'package:demo_publicarea/screens/settings/update_phonenumber_screen.dart';
import 'package:demo_publicarea/screens/settings/update_profilphoto_screen.dart';
import 'package:demo_publicarea/screens/statement/unpaid_itemized_account_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

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

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
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
        CreateRequestScreen.routeName: (context) => const CreateRequestScreen(),
        RequestScreen.routeName: (context) => const RequestScreen(),
        AnnouncementScreen.routeName: (context) => const AnnouncementScreen(),
        AnnouncementDetailScreen.routeName: (context) =>
            const AnnouncementDetailScreen(),
        RequestDetailScreen.routeName: (context) => const RequestDetailScreen(),
        ProfileSettingsScreen.routeName: (context) =>
            const ProfileSettingsScreen(),
        KvkkScreen.routeName: (context) => const KvkkScreen(),
        UserAgreementScreen.routeName: (context) => const UserAgreementScreen(),
        UpdateEmailScreen.routeName: (context) => const UpdateEmailScreen(),
        UpdatePasswordScreen.routeName: (context) =>
            const UpdatePasswordScreen(),
        UpdatePhonenumberScreen.routeName: (context) =>
            const UpdatePhonenumberScreen(),
        UpdateProfilphotoScreen.routeName: (context) =>
            const UpdateProfilphotoScreen(),
        UpdateUsernameScreen.routeName: (context) =>
            const UpdateUsernameScreen(),
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
                .updateCurrentUser(snapshot.data!);
            return const TabsScreen();
          }

          return const OnboardingScreen();
        },
      ),
    );
  }
}
