import 'package:edu_ebook/interface/localization/demo_localizations.dart';
import 'package:edu_ebook/interface/localization/language_preferences.dart';
import 'package:edu_ebook/source/core/api_constant.dart';
import 'package:edu_ebook/source/core/api_title.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:edu_ebook/widgets/progress_indicator.dart';
import 'package:edu_ebook/widgets/screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProviders;
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';
import 'di/dependency_injection.dart' as getIt;
import 'downloads/utils/download_details.dart';
import 'downloads/utils/favorite/ebook_favorite_notifier.dart';
import 'interface/pages/splash/ebook_splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  unawaited(ApiTitle().ebookEntity());
  unawaited(getIt.init());
  final appdd = await pathProviders.getApplicationDocumentsDirectory();
  Hive.init(appdd.path);
  final settings = await Hive.openBox('settings');
  bool isLight = settings.get('isLightTheme') ?? true;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=>DownloadDetails(),),
      ChangeNotifierProvider(create: (_)=>EbookFavoriteNotifier(),),
      ChangeNotifierProvider(create: (_)=>EbookTheme(isLight: isLight),)
    ],
    child: EbookAppStart(),
  ));
}

class EbookAppStart extends StatelessWidget{

  const EbookAppStart({Key key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    EbookTheme et = Provider.of<EbookTheme>(context);
    return MyApp(
      ebookTheme: et,
    );
  }

}

class MyApp extends StatefulWidget {

  final EbookTheme ebookTheme;

  const MyApp({Key key, this.ebookTheme}) : super(key:key);

  static void setLanguage(BuildContext context, Locale locale){
    _MyAppState myState = context.findRootAncestorStateOfType<_MyAppState>();
    myState.setLanguage(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale locale;
  setLanguage(Locale local){
    setState(() {
      locale = local;
    });
  }

  @override
  void didChangeDependencies() {
    getLocaleLanguage().then((locale) {
      setState(() {
        this.locale = locale;
      });
    });
    super.didChangeDependencies();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (this.locale == null) {
      return Container(
        child: Center(
          child: HSWidget.circularProgressIndicator(),
        ),
      );
    }  else {
      ScreenUtil.init();
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: ApiConstant.APP_TITLE,
        theme: widget.ebookTheme.themeData(),
        //theme: ThemeData(fontFamily: 'FontFamilyName'),
        locale: locale,
        supportedLocales: [
          Locale('ar', 'SA'),
          Locale('en', 'US'),
        ],
        localizationsDelegates: [
          DemoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        localeResolutionCallback: (deviceLocal, supportDevice){
          for(var locale in supportDevice){
            if (locale.languageCode == deviceLocal.languageCode && locale.countryCode == deviceLocal.countryCode) {
              return deviceLocal;
            }
          }
          return supportDevice.first;
        },
        home: EbookSplash(),
      );
    }
  }
}

