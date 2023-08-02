import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';

const String LAGUAGE_CODE = 'languageCode';

//languages code
const String ARABIC = 'ar';
const String ENGLISH = 'en';
const String FRENCH = 'fr';
const String TURKEY = 'tr';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? TURKEY;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return const Locale(ENGLISH, '');
    case FRENCH:
      return const Locale(FRENCH, "");
    case ARABIC:
      return const Locale(ARABIC, "");
    case TURKEY:
      return const Locale(TURKEY, "");
    default:
      return const Locale(TURKEY, '');
  }
}

AppLocalizations translation(BuildContext context) {
  return AppLocalizations.of(context)!;
}
