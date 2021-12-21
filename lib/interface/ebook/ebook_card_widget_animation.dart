import 'package:edu_ebook/source/models/ebook_model.dart';
import 'package:edu_ebook/widgets/screenutil.dart';
import 'package:flutter/cupertino.dart';

import 'ebook_card_widget.dart';

// ignore: must_be_immutable
class EbookCardWidgetAnimation extends StatelessWidget {

  EbookModel ebookModel;
  final int index;
  final int id, pages, status, price;
  final String photo, description, title, pdf, authorName, publisherName, language;
  final PageController pageController;

  EbookCardWidgetAnimation({@required this.ebookModel,
    @required this.index,
    @required this.id,
    @required this.status,
    @required this.price,
    @required this.photo,
    @required this.description,
    @required this.title,
    @required this.pdf,
    @required this.pageController,
    @required this.authorName,
    @required this.publisherName,
    @required this.pages,
    @required this.language});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child){
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = pageController.page - index;
          value = (1 - (value.abs() * 0.1)).clamp(0.0, 1.0);
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: Curves.easeIn.transform(value) * ScreenUtil.screenHeight * 0.3,
              width: 190,
              child: child,
            ),
          );
        }  else {
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: Curves.easeIn.transform(index == 0 ? value : value * 0.1) * ScreenUtil.screenHeight * 0.32,
              width: 160,
              child: child,
            ),
          );
        }
      },
      child: EbookCardWidget(
        ebookModel: ebookModel,
        id: id,
        status: status,
        photo: photo,
        description: description,
        title: title,
        pdf: pdf,
        authorName: authorName,
        publisherName: publisherName,
        pages: pages,
        language: language,
        price: price,
      ),
    );
  }
}
