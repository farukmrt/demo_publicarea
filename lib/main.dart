import 'package:demo_publicarea/providers/bill_provider.dart';
import 'package:demo_publicarea/providers/description_provider.dart';

import 'firebase_options.dart';
import 'models/user.dart' as model;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo_publicarea/utils/colors.dart';
//import 'package:demo_publicarea/firebase_options.dart';
import 'package:demo_publicarea/screens/tabs_screen.dart';
import 'package:demo_publicarea/screens/login_screen.dart';
import 'package:demo_publicarea/screens/signup_screen.dart';
import 'package:demo_publicarea/resources/auth_methods.dart';
import 'package:demo_publicarea/screens/onboard_screen.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/widgets/loading_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
    ChangeNotifierProvider<DescriptionProvider>(
        create: (_) => DescriptionProvider()),
    ChangeNotifierProvider<BillProvider>(create: (_) => BillProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'publicarea',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: backgroundColor,
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
      },
      home: FutureBuilder(
        future: AuthMethods()
            .getCurrentUser(FirebaseAuth.instance.currentUser != null
                ? FirebaseAuth.instance.currentUser!.uid
                : null)
            .then((value) {
          if (value != null) {
            Provider.of<UserProvider>(context, listen: false).setUser(
              model.User.fromMap(value),
            );
          }
          return value;
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }

          //eger kullanici mevcutsa direk ana ekrana yonlendirir
          // if (snapshot.hasData) {
          //   return const MainScreen();
          // }
          return const OnboardingScreen();
        },
      ),
    );
  }
}
