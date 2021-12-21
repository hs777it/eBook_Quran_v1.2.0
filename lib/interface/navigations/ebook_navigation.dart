import 'package:edu_ebook/interface/bottombar/ebook_bottom_bar.dart';
import 'package:edu_ebook/interface/localization/demo_localizations.dart';
import 'package:edu_ebook/interface/navigations/navigation_drawer_item_list.dart';
import 'package:edu_ebook/interface/pages/contact/contactus.dart';
import 'package:edu_ebook/interface/pages/downloads/ebook_download_page.dart';
import 'package:edu_ebook/interface/pages/explores/ebook_explores.dart';
import 'package:edu_ebook/interface/pages/favorites/ebook_favorite_page.dart';
import 'package:edu_ebook/interface/pages/language/language_screen.dart';
import 'package:edu_ebook/routers/ebook_anim_route.dart';
import 'package:edu_ebook/routers/ebook_routers.dart';
import 'package:edu_ebook/source/core/app_constant.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:edu_ebook/widgets/size_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EbookNavigation extends StatefulWidget {

  @override
  _EbookProfileState createState() => _EbookProfileState();
}

class _EbookProfileState extends State<EbookNavigation> with SingleTickerProviderStateMixin{
  GlobalKey<ScaffoldState> global = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Scaffold(
      key: global,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30,),
            NavigationDrawerItemList(
              title: DemoLocalizations.of(context).translate('home'),
              icons: Icon(Icons.home, color: ebookTheme.themeMode().iconColor,),
              onTap: ()=>pushPage(context, EbookBottomBar()),
            ),
            NavigationDrawerItemList(
              title: DemoLocalizations.of(context).translate('library'),
              icons: Icon(Icons.library_books, color: ebookTheme.themeMode().iconColor,),
              onTap: ()=>pushPage(context, EbookExplores()),
            ),
            NavigationDrawerItemList(
              title: DemoLocalizations.of(context).translate('download'),
              icons: Icon(Icons.file_download, color: ebookTheme.themeMode().iconColor,),
              onTap: ()=>pushPage(context, EbookDownloadPage()),
            ),
            NavigationDrawerItemList(
              title: DemoLocalizations.of(context).translate('favorite'),
              icons: Icon(Icons.favorite, color: ebookTheme.themeMode().iconColor,),
              onTap: ()=>pushPage(context, EbookFavoritePage()),
            ),
            // NavigationDrawerItemList(
            //   title: DemoLocalizations.of(context).translate('language'),
            //   icons: Icon(Icons.language, color: ebookTheme.themeMode().iconColor,),
            //   onTap: ()=>pushPage(context, LanguageScreen()),
            // ),
            // NavigationDrawerItemList(
            //   title: DemoLocalizations.of(context).translate('contact_us'),
            //   icons: Icon(Icons.mail,color: ebookTheme.themeMode().iconColor,),
            //   onTap: ()=>pushPage(context, Contact(),),
            // ),
            
            Center(
              child: Text(
                DemoLocalizations.of(context).translate('theme'),
                style: TextStyle(
                  fontSize: 19,
                  color: Color(0xFF918f95)
                ),
              ),
            ),
            SizeSpace(number: 3,),
            EbookAnimRoute(
                text: [DemoLocalizations.of(context).translate('dark'),
                 DemoLocalizations.of(context).translate('light')],
                changed: (v) async{
                  await ebookTheme.toggleThemeData();
                  setState(() {
                  });
                }),
                 SizeSpace(number: 20,),
                 Column(
                   children: [
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                           Text(AppConstant.APP_TITLE),
                           Text("  v1.0",style: TextStyle(fontFamily: ""),),
                         ],
                       ),
                     ),
                     
                   ],
                 )
          ],
        ),
      ),
    );
  }
}
