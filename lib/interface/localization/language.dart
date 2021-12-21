import 'package:flutter/cupertino.dart';

class Language {

  int id;
  String name;
  String flag;
  String code;

  Language({
    @required this.id, @required this.name, @required this.flag, @required this.code});

  static List<Language> language(){
    return<Language>[
      Language(id: 1, name: "Arabic", flag: "assets/flags/ar-SA.png", code: "ar"),
      Language(id: 2, name: "English", flag: "assets/flags/en-US.png", code: "en"),
    ];
  }

}