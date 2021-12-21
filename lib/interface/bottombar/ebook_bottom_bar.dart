import 'package:edu_ebook/interface/home.dart';
import 'package:edu_ebook/interface/localization/demo_localizations.dart';
import 'package:edu_ebook/interface/pages/favorites/ebook_favorite_home.dart';
import 'package:edu_ebook/interface/pages/librarybottom/ebook_library_bottom.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
//import 'package:edu_ebook/widgets/hex_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EbookBottomBar extends StatefulWidget {
  @override
  _EbookBottomBarState createState() => _EbookBottomBarState();
}

class _EbookBottomBarState extends State<EbookBottomBar> {

  int _currentIndex = 0;
  PageController _pageController;
  final pageSelected = [
    Home(),
    EbookLibraryBottom(),
    EbookFavoriteHome()
  ];

  final List<Widget> bodys =[
    Home(),
    EbookLibraryBottom(),
    EbookFavoriteHome()
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Scaffold(
      body: bodys[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapBM,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: ebookTheme.themeMode().bottomNav,
        items: [
          BottomNavigationBarItem(
            //icon: new Icon(Icons.home, color: getColorFromHex("#e2e2e2"),),
            icon: new Icon(Icons.home, color: Colors.blue[400],),
            label: DemoLocalizations.of(context).translate('home'),
            activeIcon: new Icon(Icons.home_outlined, color: Colors.blue[900],),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.library_books, color: Colors.blue[400],),
            label: DemoLocalizations.of(context).translate('library'),
            activeIcon: new Icon(Icons.library_books, color: Colors.blue[900],),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.favorite_border, color: Colors.blue[400],),
            label: DemoLocalizations.of(context).translate('favorite'),
            activeIcon: new Icon(Icons.favorite, color: Colors.blue[900],),
          ),
        ],
      ),
    );
  }

  void onTapBM(int index){
    setState(() {
      _currentIndex = index;
    });
  }
}
