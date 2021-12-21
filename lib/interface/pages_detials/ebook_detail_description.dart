import 'package:edu_ebook/interface/localization/demo_localizations.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EbookDetailDescription extends StatefulWidget {

  final String description;

  EbookDetailDescription({@required this.description});

  @override
  _EbookDetailDescriptionState createState() => _EbookDetailDescriptionState();
}

class _EbookDetailDescriptionState extends State<EbookDetailDescription> {
  @override
  Widget build(BuildContext context) {
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).translate('detail_book'), style: TextStyle(color: ebookTheme.themeMode().subTitle),),
        backgroundColor: ebookTheme.themeMode().toggleButtonColor,
        leading: BackButton(
          color: ebookTheme.themeMode().textColor,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Text(
            removeAllHtmlTags(widget.description),
            style: TextStyle(
                color: ebookTheme.themeMode().textColor,
                fontSize: 16
            ),
          ),
        ),
      )
    );
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(
        r"<[^>]*>",
        multiLine: true,
        caseSensitive: true
    );
    return htmlText.replaceAll(exp, '');
  }
}
