import 'package:edu_ebook/widgets/hex_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class EbookTheme extends ChangeNotifier {
  bool isLight;

  EbookTheme({@required this.isLight});

  getNavigationBarTheme() {
    if (isLight) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Color(0xFFFFFFFF),
          systemNavigationBarIconBrightness: Brightness.dark));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Color(0xFF26242E),
          systemNavigationBarIconBrightness: Brightness.light));
    }
  }

  toggleThemeData() async {
    final settings = await Hive.openBox('settings');
    settings.put('isLightTheme', !isLight);
    isLight = !isLight;
    getNavigationBarTheme();
    notifyListeners();
  }

  ThemeData themeData() {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: isLight ? Colors.grey : Colors.grey,
      primaryColor: isLight ? Colors.black : Color(0xFF1E1F28),
      brightness: isLight ? Brightness.light : Brightness.dark,
      backgroundColor: isLight ? Color(0xFFFFFFFF) : Color(0xFF26242e),
      //bottomAppBarColor: Colors.grey[100],
      scaffoldBackgroundColor:
          isLight ? Color(0xFFFFFFFF) : getColorFromHex("#000000"),
      textTheme: TextTheme(
          headline6: TextStyle(
              color: isLight ? Colors.black : Color(0xFF1E1F28), fontSize: 12)),
      fontFamily: 'Insan',
    );
  }

  ThemeColor themeMode() {
    return ThemeColor(
        gradient: [
          if (isLight) ...[Color(0xDDFF0080), Color(0xDDFF8C00)],
          if (!isLight) ...[Color(0xFF8983F7), Color(0xFFA3DAFB)]
        ],
        backgroundColor:
            isLight ? getColorFromHex("#FFFFFF") : getColorFromHex("#000000"),
        textColor:
            isLight ? getColorFromHex("#000000") : getColorFromHex("#FFFFFF"),
        toggleButtonColor: isLight ? Color(0xFFFFFFFF) : Color(0xFf34323d),
        toggleBackgroundColor: isLight ? Color(0xFFe7e7e8) : Color(0xFF222029),
        iconColor:
            isLight ? getColorFromHex("#000000") : getColorFromHex("#FFFFFF"),
        ratingBar:
            isLight ? getColorFromHex("#666666") : getColorFromHex("#2e8ec1"),
        shadow: [
          if (isLight)
            BoxShadow(
                color: Color(0xFFd8d7da),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 5)),
          if (!isLight)
            BoxShadow(
                color: Color(0x66000000),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 5))
        ],
        boxWrap:
            isLight ? getColorFromHex("#d6d6d6") : getColorFromHex("#3f3f3f"),
        //appBar: isLight ? getColorFromHex("#efefef") : getColorFromHex("#494949"),
        appBar: isLight ? Colors.blue : getColorFromHex("#494949"),
        bottomNav: isLight ? Colors.white : getColorFromHex("#494949"),
        textAppBar: isLight ? getColorFromHex("#727272") : Color(0xB3FFFFFF),
        textButton:
            isLight ? getColorFromHex("#FFFFFF") : getColorFromHex("#FFFFFF"),
        checkList: isLight ? Color(0xDDFF0080) : getColorFromHex("#18871d"),
        subTitle:
            isLight ? getColorFromHex("#636363") : getColorFromHex("#fcfcfc"));
  }
}

class ThemeColor {
  List<Color> gradient;
  Color backgroundColor;
  Color toggleButtonColor;
  Color toggleBackgroundColor;
  Color textColor;
  Color iconColor;
  Color ratingBar;
  List<BoxShadow> shadow;
  Color boxWrap;
  Color appBar;
  Color bottomNav;
  Color textAppBar;
  Color textButton;
  Color checkList;
  Color subTitle;

  ThemeColor(
      {this.gradient,
      this.backgroundColor,
      this.toggleBackgroundColor,
      this.toggleButtonColor,
      this.textColor,
      this.iconColor,
      this.ratingBar,
      this.shadow,
      this.boxWrap,
      this.appBar,
      this.bottomNav,
      this.textAppBar,
      this.textButton,
      this.checkList,
      this.subTitle});
}
