import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'demo_localizations.dart';

String key = 'language_code';

Future<Locale> setLocaleLanguage(String language) async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(key, language);
  return _locale(language);
}

Future<Locale> getLocaleLanguage() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(key) ?? "ar";
  return _locale(languageCode);
}

String getTranslated(BuildContext context, String key) {
  return DemoLocalizations.of(context).translate(key);
}

Locale _locale(String language){
  switch(language){
    case 'ar':
      return Locale('ar', 'SA');
      break;
    case 'en':
      return Locale('en', 'US');
      break;
    default:
      return Locale('ar', 'SA');
  }
}