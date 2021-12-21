import 'package:delayed_display/delayed_display.dart';
import 'package:edu_ebook/bloc/background/ebook_background_bloc.dart';
import 'package:edu_ebook/bloc/carousels/ebook_carousel_bloc.dart';
import 'package:edu_ebook/bloc/carousels/ebook_carousel_event.dart';
import 'package:edu_ebook/bloc/carousels/ebook_carousel_state.dart';
import 'package:edu_ebook/bloc/search/ebook_search_bloc.dart';
import 'package:edu_ebook/bloc/tabs/ebook_tab_bloc.dart';
import 'package:edu_ebook/di/dependency_injection.dart';
//import 'package:edu_ebook/interface/navigations/navigation_drawer.dart';
import 'package:edu_ebook/interface/pages/appbar/ebook_app_bar.dart';
import 'package:edu_ebook/interface/pages/category/ebook_category.dart';
import 'package:edu_ebook/interface/pages/suggestion/ebook_random.dart';
import 'package:edu_ebook/interface/tabs/ebook_tabs_widget.dart';
import 'package:edu_ebook/source/core/app_constant.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:edu_ebook/widgets/progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'ebook/ebook_carousel_widget.dart';
import 'navigations/ebook_navigation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  EbookCarouselBloc ebookCarouselBloc;
  EbookBackgroundBloc ebookBackgroundBloc;
  EbookTabBloc ebookTabBloc;

  @override
  void initState() {
    super.initState();
    ebookCarouselBloc = getItInstance<EbookCarouselBloc>();
    ebookBackgroundBloc = ebookCarouselBloc.ebookBackgroundBloc;
    ebookTabBloc = getItInstance<EbookTabBloc>();
    ebookCarouselBloc.add(CarouselLoadEvent());
  }

  @override
  void dispose() {
    super.dispose();
    ebookCarouselBloc?.close();
    ebookBackgroundBloc?.close();
    ebookTabBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    final ebookTheme = Provider.of<EbookTheme>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ebookCarouselBloc,
        ),
        BlocProvider(
          create: (context) => ebookBackgroundBloc,
        ),
        BlocProvider(
          create: (context) => ebookTabBloc,
        ),
        BlocProvider(
          create: (_)=> SearchBloc(),
        )
      ],
      child: Scaffold(
        //drawer: NavigationDrawer(),
       drawer:  GestureDetector(
              child: 
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.3),
                 child:EbookNavigation(),
                // Container(
                //   width: 35,
                //   height: 35,
                //   decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       image: new DecorationImage(
                //         fit: BoxFit.cover,
                //         image: new ExactAssetImage('assets/images/menu.png'),
                //       )
                //   ),
                // ),
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
        // App Background
         appBar:AppBar(
          backgroundColor: ebookTheme.themeMode().appBar,
          centerTitle: true,
          title: Text(AppConstant.APP_TITLE),
          // title: RichText(
          //         textAlign: TextAlign.center,
          //         text: TextSpan(text: AppConstant.APP_TITLE,style: TextStyle(fontSize: 20),
          //             children: <TextSpan>[TextSpan( text: '\nTrip List',style: TextStyle(fontSize: 16,),
          //               ),
          //             ]
          //         ),
          //       ),
          actions: [
            EbookSearchBloc()
          ],
          ),
            
        backgroundColor:ebookTheme.themeMode().backgroundColor,
        body: Stack(
          children: [
            //EbookAppBar(),
            BlocBuilder<EbookCarouselBloc, EbookCarouselState>(
                builder: (context, state){
                  if (state is EbookCarouselInitial) {
                    return Center(
                      child: HSWidget.circularProgressIndicator(),
                    );
                  } else if (state is EbookCarouselLoaded) {
                    return Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [              
                              Container(
                              height: 270,
                               child: EbookCarouselWidget(
                                   ebook: state.ebook,
                                   defaultIndex: state.defaultIndex
                               )
                                ),

                             // EbookCategory(),
                              
                              Padding(
                                padding: EdgeInsets.only(bottom: 3),
                                child: Container(
                                  child: DelayedDisplay(delay: Duration(seconds: 2) ,child: EbookRandom()),
                                ),
                              ),
                              
                              Padding(
                                padding: EdgeInsets.only(top: 6, bottom: 2,),
                                child: Container(
                                  height: 300,
                                  child: EbookTabsWidget(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return SizedBox.shrink();
                }
            ),
           
          ],
        ),
      ),
    );
  }
}
