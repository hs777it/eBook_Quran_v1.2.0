import 'package:edu_ebook/bloc/search/ebook_search_bloc.dart';
import 'package:edu_ebook/interface/localization/demo_localizations.dart';
import 'package:edu_ebook/interface/navigations/ebook_navigation.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:edu_ebook/widgets/screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class EbookAppBar extends StatefulWidget {
  @override
  _EbookAppBarState createState() => _EbookAppBarState();
}

class _EbookAppBarState extends State<EbookAppBar> {

  @override
  Widget build(BuildContext context) {
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil.statusBarHeight + 4,
        left: 16,
        right: 16,
      ),
      child: 
      Container(
        decoration: BoxDecoration(
          color: ebookTheme.themeMode().appBar,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                  child:
                   //EbookSearchBloc()
                   Text(DemoLocalizations.of(context).translate("favorite"))
              ),
            ),
            Expanded(
              child: Text(
                DemoLocalizations.of(context).translate('search_edu_book'),
                style: TextStyle(
                    fontSize: 17,
                    color: ebookTheme.themeMode().textAppBar
                ),
              ),
            ),
            GestureDetector(
              child: 
              Padding(
                padding: EdgeInsets.only(top: 1, bottom: 1, right: 10),
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: new ExactAssetImage('assets/images/menu.png'),
                      )
                  ),
                ),
              ),
              onTap: (){
                Navigator.of(context).push(new MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return EbookNavigation();
                    },
                    fullscreenDialog: true
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

