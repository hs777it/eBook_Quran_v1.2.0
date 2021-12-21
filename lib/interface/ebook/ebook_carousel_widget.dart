//import 'package:edu_ebook/interface/pages/appbar/ebook_app_bar.dart';
import 'package:edu_ebook/interface/background/ebook_background_widget.dart';
import 'package:edu_ebook/interface/pages/appbar/ebook_app_bar.dart';
import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:edu_ebook/widgets/screenutil.dart';
import 'package:edu_ebook/widgets/size_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ebook_data_widget.dart';
import 'ebook_page_view.dart';

class EbookCarouselWidget extends StatelessWidget {

  final List<EbookEntity> ebook;
  final int defaultIndex;

  const EbookCarouselWidget({@required this.ebook, this.defaultIndex});

  @override
  Widget build(BuildContext context) {
    return Stack(
        fit: StackFit.expand,
        children: [
          // carousel background
          EbookBackgroundWidget(),
          Column(
          children: [
            //EbookAppBar(),
            Padding(
              padding: EdgeInsets.only(
                //top: ScreenUtil.statusBarHeight + 62,
                top: 10,
                left: 1,
                right: 1,
              ),
            ),
            EbookPageView(ebook: ebook,initialPages: defaultIndex),
            SizeSpace(number: 3,),
            EbookDataWidget(),
            ],
          ),
        ],
    );
  }
}
