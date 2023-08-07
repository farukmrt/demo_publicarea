import 'package:demo_publicarea/providers/bill_provider.dart';
import 'package:demo_publicarea/providers/payment_provider.dart';
import 'package:demo_publicarea/providers/photo_provider.dart';
import 'package:demo_publicarea/providers/request_provider.dart';
import 'package:demo_publicarea/screens/main/announcement_screen.dart';
import 'package:demo_publicarea/screens/main/announcement_detail_screen.dart';
import 'package:demo_publicarea/screens/request/request_detail_screen.dart';
import 'package:demo_publicarea/screens/request/create_request_screen.dart';
import 'package:demo_publicarea/screens/request/request_screen.dart';
import 'package:demo_publicarea/screens/settings/custom_update_email.dart';
import 'package:demo_publicarea/screens/settings/custom_update_password.dart';
import 'package:demo_publicarea/screens/settings/custom_update_phonenumber.dart';
import 'package:demo_publicarea/screens/settings/custom_update_profilphoto.dart';
import 'package:demo_publicarea/screens/settings/custom_update_username.dart';
import 'package:demo_publicarea/screens/settings/kvkk_screen.dart';
import 'package:demo_publicarea/screens/settings/profile_settings_screen.dart';
import 'package:demo_publicarea/screens/settings/user_agreement.dart';
import 'package:demo_publicarea/screens/statement/credit_card_screen.dart';
import 'package:demo_publicarea/screens/statement/itemized_account_screen.dart';
import 'package:demo_publicarea/screens/statement/payment_select_screen.dart';
import 'package:demo_publicarea/providers/announcement_provider.dart';
import 'package:demo_publicarea/screens/statement/unpaid_itemized_account_screen.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'l10n/app_localizations.dart';
import 'models/user.dart' as model;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/screens/main/tabs_screen.dart';
import 'package:demo_publicarea/screens/login/login_screen.dart';
import 'package:demo_publicarea/screens/login/signup_screen.dart';
import 'package:demo_publicarea/screens/login/onboard_screen.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/widgets/loading_indicator.dart';

import 'utils/languages/lang.dart';
// import 'package:.dart_tool/flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await EasyLocalization.ensureInitialized();
  // //  await Firebase.initializeApp(
  // // options: DefaultFirebaseOptions().currentPlatform,
  // // );

  // runApp(EasyLocalization(
  //     supportedLocales: const [
  //       Locale('ar', 'AE'),
  //       Locale('en', 'US'),
  //       Locale('fr', 'FR'),
  //       Locale('tr', 'TR'),
  //     ],
  //     fallbackLocale: const Locale('tr', 'TR'),
  //     path: 'assets/lang',
  //     child: const MyApp()));

  // EasyLocalization(
  //   child: MyApp(),
  //   supportedLocales: Languagemanager .instance.supportedLocales,
  //   path: ApplicationConstants.LANG_ASSET_PATH));
  // EasyLocalization.ensureInitialized();
  // await Firebase.initializeApp(
  //options: DefaultFirebaseOptions.currentPlatform,
  // );

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

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   UserProvider userProvider =
  //       Provider.of<UserProvider>(context, listen: false);

  //   userProvider.userStream.listen((user) {
  //     setState(() {
  //       // _user = user;
  //     });
  //   });
  // }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
    // UserProvider userProvider =
    //     Provider.of<UserProvider>(context, listen: false);

    // userProvider.userStream.listen((user) {
    //   setState(() {
    //     // _user = user;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,

      // /// Delegate: Temsilci Listesi
      // localizationsDelegates: AppLocalizations.localizationsDelegates,

      // /// Desteklenen Diller
      // supportedLocales: AppLocalizations.supportedLocales,

      // localeResolutionCallback:
      //     (Locale? locale, Iterable<Locale> supportedLocales) {
      //   /// [locale]: Cihazın dili null değilse
      //   if (locale != null) {
      //     log("Algılanan cihaz dili: Dil Kodu: ${locale.languageCode}, Ülke Kodu: ${locale.countryCode}");

      //     /// for döngüsü yardımıyla [supportedLocales] listesi içinde arama yapıyoruz
      //     for (var supportedLocale in supportedLocales) {
      //       /// Cihazın dil kodu [locale.languageCode] ve ülke kodu [locale.countryCode]
      //       /// desteklenen diller arasındaki dil ve ülke kodlarının içinde [supportedLocale] var mı?
      //       if (supportedLocale.languageCode == locale.languageCode &&
      //           locale.countryCode == locale.countryCode) {
      //         /// Varsa desteklenen dili döndür
      //         return supportedLocale;
      //       }
      //     }
      //   }
      //   log("Algılanan cihaz dili desteklenen diller arasında bulunmuyor.");

      //   /// Yoksa [supportedLocales] Listesindeki ilk sonucu döndür.
      //   log("Uygulamanın başlatılması istenen dil: Dil Kodu: ${supportedLocales.first.languageCode}, Ülke Kodu: ${supportedLocales.first.countryCode}");
      //   return supportedLocales.first;
      // },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: [
      //   Locale('ar', ''),
      //   Locale('en', ''),
      //   Locale('fr', ''),
      //   Locale('tr', ''),
      // ],
      // locale: Locale('tr', ''),

      // supportedLocales: context.supportedLocales ?? [const Locale('tr', 'TR')],
      // localizationsDelegates: context.localizationDelegates ??
      //     EasyLocalization.of(context)!.delegates,
      // locale: context.locale ?? const Locale('tr', 'TR'),

      // supportedLocales: context.supportedLocales,
      // localizationsDelegates: context.localizationDelegates,
      // locale: context.locale,
      //debugShowCheckedModeBanner: false,

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
        AnnouncementScreen.routeName: (context) => const AnnouncementScreen(),
        AnnouncementDetailScreen.routeName: (context) =>
            const AnnouncementDetailScreen(),
        RequestDetailScreen.routeName: (context) => const RequestDetailScreen(),
        ProfileSettingsScreen.routeName: (context) =>
            const ProfileSettingsScreen(),
        KvkkScreen.routeName: (context) => const KvkkScreen(),
        UserAgreementScreen.routeName: (context) => const UserAgreementScreen(),
        CustomUpdateEmail.routeName: (context) => const CustomUpdateEmail(),
        CustomUpdatePassword.routeName: (context) =>
            const CustomUpdatePassword(),
        CustomUpdatePhonenumber.routeName: (context) =>
            const CustomUpdatePhonenumber(),
        CustomUpdateProfilphoto.routeName: (context) =>
            const CustomUpdateProfilphoto(),
        CustomUpdateUsername.routeName: (context) =>
            const CustomUpdateUsername(),
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
