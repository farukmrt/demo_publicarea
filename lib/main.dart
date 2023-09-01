import 'package:google_fonts/google_fonts.dart';
import 'package:demo_publicarea/models/userData.dart';
import 'package:demo_publicarea/providers/building_provider.dart';
import 'package:demo_publicarea/screens/login/extra_signup_screen.dart';

import 'providers/userData_provider.dart';
import 'utils/languages/lang.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    ChangeNotifierProvider<AnnouncementProvider>(
        create: (_) => AnnouncementProvider()),
    ChangeNotifierProvider<BillProvider>(create: (_) => BillProvider()),
    ChangeNotifierProvider<BuildingProvider>(create: (_) => BuildingProvider()),
    ChangeNotifierProvider<PaymentProvider>(create: (_) => PaymentProvider()),
    ChangeNotifierProvider<PhotoProvider>(create: (_) => PhotoProvider()),
    ChangeNotifierProvider<RequestProvider>(create: (_) => RequestProvider()),
    ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
    ChangeNotifierProvider<UserDataProvider>(create: (_) => UserDataProvider()),
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
      theme: ThemeData.
              //fontFamily: 'JosefinSans').
              //use material açılınca tonlamalar düzeliyor
              light() //(useMaterial3: true)
          .copyWith(
        //textTheme: GoogleFonts.josefinSansTextTheme(),
        //textTheme: GoogleFonts.robotoTextTheme(),
        textTheme: GoogleFonts.lexendDecaTextTheme(),

        scaffoldBackgroundColor: backgroundColor,
        //elevatedbutton'un varsayilan rengi veriliyor
        //iconTheme: IconThemeData(color: primaryColor),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: const BorderSide(
              color: buttonColor,
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: const BorderSide(
              color: buttonColor,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: const BorderSide(
              color: buttonColor,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: const BorderSide(
              color: negative,
              width: 2.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: const BorderSide(
              color: buttonColor,
              width: 2,
            ),
          ),
        ),
        //cardColor: Color.fromARGB(255, 88, 39, 39),
        cardTheme: CardTheme.of(context).copyWith(color: Colors.white),
        //cardColor: Color(: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.0),
            )),
            backgroundColor: MaterialStateProperty.all(buttonColor),
          ),
        ),
        appBarTheme: AppBarTheme.of(context).copyWith(
          // toolbarTextStyle: TextStyle(
          //     fontFamily:
          //         '${GoogleFonts.qwitcherGrypen}'), //lexendDecaTextTheme()}'),
          backgroundColor: backgroundColor,
          elevation: 0,
          titleTextStyle: const TextStyle(
            fontFamily: 'lexendDeca',
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
        ExtraSignupScreen.routeName: (context) => const ExtraSignupScreen(),
      },
      home: FutureBuilder<UserData>(
        future: UserDataProvider().getUserData(),
        builder: (context, AsyncSnapshot<UserData> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator(); // Yükleme göstergesi
          }

          // if (snapshot.hasError) {
          //   // return OnboardingScreen();
          //   return Text("Hata: ${snapshot.error}");
          // }

          if (snapshot.hasData && snapshot.data != null) {
            // if (snapshot.data!.user !=
            //     null) //&& snapshot.data!.building != null)
            Provider.of<UserProvider>(context, listen: false)
                .updateCurrentUser(snapshot.data!.user!);

            Provider.of<BuildingProvider>(context, listen: false)
                .updateCurrentBuilder(snapshot.data!.building!);

            return const TabsScreen();
          }
          return const OnboardingScreen();
        },
      ),

      //     // FutureBuilder<model.UserModel?>(
      //     //   future: UserProvider().getCurrentUser(
      //     //       FirebaseAuth.instance.currentUser != null
      //     //           ? FirebaseAuth.instance.currentUser!.uid
      //     //           : null),
      //     //   builder: (context, AsyncSnapshot snapshot) {
      //     //     if (snapshot.connectionState == ConnectionState.waiting) {
      //     //       return const LoadingIndicator();
      //     //     }

      //         // eger kullanici mevcutsa direk ana ekrana yonlendirir

      //         //snapashot'ın datasını incele
      //         if (snapshot.hasData && snapshot.data != null) {
      //           Provider.of<UserProvider>(context, listen: false)
      //               .updateCurrentUser(snapshot.data!);

      //           Provider.of<BuildingProvider>(context, listen: false)
      //               .fetchBuilding(snapshot.data!.buildingId);

      //           //BuildingProvider().buildingStream.;
      //           // Provider.of<BuildingProvider>(context, listen: true)
      //           //     .updateCurrentBuilder(BuildingProvider().currentBuilding);

      //           return const TabsScreen();
      //         }

      //         return const OnboardingScreen();
      //       },
      //     ),
    );
  }
}
