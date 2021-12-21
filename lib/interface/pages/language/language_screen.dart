import 'package:edu_ebook/interface/localization/demo_localizations.dart';
import 'package:edu_ebook/interface/localization/language.dart';
import 'package:edu_ebook/interface/localization/language_preferences.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _EbookExploresState createState() => _EbookExploresState();
}

class _EbookExploresState extends State<LanguageScreen> {

  @override
  Widget build(BuildContext context) {
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ebookTheme.themeMode().textColor,
        ),
        title: Text(DemoLocalizations.of(context).translate('language'), style: TextStyle(color: ebookTheme.themeMode().textColor),),
        centerTitle: true,
        backgroundColor: ebookTheme.themeMode().toggleButtonColor,
      ),
      body: listOfCountry(),
    );
  }

  Widget listOfCountry(){
    final ebookTheme = Provider.of<EbookTheme>(context);
    return ListView.builder(
      itemCount: Language.language().length,
      itemBuilder: (BuildContext context, int index){
        return GestureDetector(
          onTap: (){
            changeLang(Language.language()[index].code);
          },
          child: Card(
            elevation: 1,
            child: Row(
              children: [
                Container(child: Image.asset("${Language.language()[index].flag}"),
                  height: 67,
                  width: 67,),
                Text(Language.language()[index].name,
                  style: TextStyle(color: ebookTheme.themeMode().iconColor,
                  fontSize: 18),),
              ],
            ),
          ),
        );
      }
    );
  }

  void changeLang(String lang) async{
    Locale locale = await setLocaleLanguage(lang);
    MyApp.setLanguage(context, locale);
  }
}
