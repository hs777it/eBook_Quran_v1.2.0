import 'package:edu_ebook/bloc/background/ebook_background_bloc.dart';
import 'package:edu_ebook/bloc/background/ebook_background_event.dart';
import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:edu_ebook/widgets/screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ebook_card_widget_animation.dart';

class EbookPageView extends StatefulWidget {

  final List<EbookEntity> ebook;
  final int initialPages;

  EbookPageView({@required this.ebook, this.initialPages});

  @override
  _EbookPageViewState createState() => _EbookPageViewState();
}

class _EbookPageViewState extends State<EbookPageView> {

  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: widget.initialPages,
      keepPage: false,
      viewportFraction: 0.55,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil.screenHeight * 0.3,
        child: PageView.builder(
          controller: pageController,
          itemBuilder: (context, index){
            final EbookEntity entity = widget.ebook[index];
            return EbookCardWidgetAnimation(
              ebookModel: entity,
              index: index,
              pageController: pageController,
              id: entity.id,
              status: entity.statusNews,
              photo: entity.photo,
              description: entity.description,
              title: entity.title,
              pdf: entity.pdf,
              authorName: entity.authorName,
              publisherName: entity.publisherName,
              pages: entity.pages,
              language: entity.language,
              price: entity.price,
            );
          },
          pageSnapping: true,
          itemCount: widget.ebook?.length ?? 0,
          onPageChanged: (index) {
            BlocProvider.of<EbookBackgroundBloc>(context).add(EbookBackgroundChangeEvent(widget.ebook[index]));
          },
        ),
    );
  }

}
