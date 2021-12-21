import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class DemoLocalizations{
  final Locale locale;

  DemoLocalizations(this.locale);

  static DemoLocalizations of(BuildContext context){
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  Map<String, String> _value;

  Future load() async {
    String jsonValues = await rootBundle.loadString('lib/language/${locale.languageCode}.json');
    Map<String, dynamic> decode = json.decode(jsonValues);
   _value = decode.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String translate){
    return _value[translate];
  }

  static const LocalizationsDelegate<DemoLocalizations> delegate = DemoLocalizationsDelegate();
}

class DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalizations>{

  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['ar', 'en'].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalizations> load(Locale locale) async{
    DemoLocalizations dl = new DemoLocalizations(locale);
    await dl.load();
    return dl;
  }

  @override
  bool shouldReload(LocalizationsDelegate<DemoLocalizations> old) => false;

}