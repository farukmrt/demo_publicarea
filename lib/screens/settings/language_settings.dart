// // import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';

// // class LocalizationChecker {
// //   static changeLanguage(BuildContext context) {
// //     Locale? currentLocal = EasyLocalization.of(context)!.currentLocale;
// //     switch (context) {
// //       case 1:
// //         EasyLocalization.of(context)!.setLocale(const Locale('ar', 'AE'));
// //         break;
// //       case 2: EasyLocalization.of(context)!.setLocale(const Locale('en', 'US'));
// //         break;
// //       case 3: EasyLocalization.of(context)!.setLocale(const Locale('fr', 'FR'));
// //         break;
// //       case 4: EasyLocalization.of(context)!.setLocale(const Locale('tr', 'TR'));
// //         break;
// //     }
// //   }
// // }
// // class LocalizationChecker {
// //   static void changeLanguage(BuildContext context) {
// //     Locale currentLocal = EasyLocalization.of(context)!.currentLocale!;
// //     Locale newLocale;
// //     switch (currentLocal.languageCode) {
// //       case 'ar':
// //       newLocale= const Locale('ar', 'AE');
// //         break;
// //       case 'en':
// //         const Locale('en', 'US');
// //         break;
// //       case 'fr':
// //         const Locale('fr', 'FR');
// //         break;
// //       case 'tr':
// //         const Locale('tr', 'TR');
// //         break;
// //       default:
// //        newLocale = const Locale('tr', 'TR');
// //         break;
// //     }
// //     EasyLocalization.of(context)!.setLocale(newLocale);
// //   }
// // }

// class LocalizationChecker {
//   static void changeLanguage(BuildContext context) {
//     Locale currentLocale = EasyLocalization.of(context)!.currentLocale!;
//     Locale newLocale;

//     // Determine the next language based on the current language
//     switch (currentLocale.languageCode) {
//       case 'ar':
//         newLocale = const Locale('en', 'US'); // English (United States)
//         break;
//       case 'en':
//         newLocale = const Locale('fr', 'FR'); // French (France)
//         break;
//       case 'fr':
//         newLocale = const Locale('tr', 'TR'); // Turkish (Turkey)
//         break;
//       case 'tr':
//         newLocale = const Locale('ar', 'AE'); // Arabic (United Arab Emirates)
//         break;
//       default:
//         // Default fallback to English
//         newLocale = const Locale('en', 'US');
//         break;
//     }

//     // Set the new language
//     EasyLocalization.of(context)!.setLocale(newLocale);
//   }
// }
