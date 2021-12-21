import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_ebook/bloc/ebookbycat/ebook_bycat_bloc.dart';
import 'package:edu_ebook/bloc/ebookbycat/ebook_bycat_event.dart';
import 'package:edu_ebook/bloc/ebookbycat/ebook_bycat_state.dart';
import 'package:edu_ebook/bloc/search/ebook_search_bloc.dart';
import 'package:edu_ebook/interface/localization/demo_localizations.dart';
import 'package:edu_ebook/interface/pages_detials/ebook_detail.dart';
import 'package:edu_ebook/routers/ebook_routers.dart';
import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:edu_ebook/widgets/progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class EbookByCategory extends StatefulWidget {

  final int id;
  final String catName;

  EbookByCategory({@required this.id,@required this.catName});

  @override
  _EbookByCategoryState createState() => _EbookByCategoryState();
}

class _EbookByCategoryState extends State<EbookByCategory> {

  EbookByCatsBloc ebookByCatBloc;

  @override
  void initState() {
    super.initState();
    ebookByCatBloc = EbookByCatsBloc(id: widget.id);
    ebookByCatBloc.add(EbookByCatEventList());
  }

  @override
  Widget build(BuildContext context) {
    final ebookTheme = Provider.of<EbookTheme>(context);
    return BlocProvider(
      create: (_)=> SearchBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: ebookTheme.themeMode().textColor,
          ),
          title: Text(
            "كتب" + " " + widget.catName,
            //DemoLocalizations.of(context).translate('ebook_libraries'),
             style: TextStyle(color: ebookTheme.themeMode().textColor),),
          centerTitle: true,
          backgroundColor: ebookTheme.themeMode().toggleButtonColor,
          actions: [
            Container(
              child: EbookSearchBloc(),
            )
          ],
        ),
        body: _ebookExplores(),
      ),
    );
  }

  Widget _ebookExplores(){
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Container(
      child: BlocProvider(
        create: (_) => ebookByCatBloc,
        child: BlocListener<EbookByCatsBloc, EbookByCatState>(
          listener: (context, state){
            if (state is EbookExploresStateError) {
              Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  )
              );
            }
          },
          child: BlocBuilder<EbookByCatsBloc, EbookByCatState>(
            bloc: ebookByCatBloc,
            builder: (context, state){
              if (state is EbookExploresStateInitial) {
                return Center(
                  child: HSWidget.circularProgressIndicator(),
                );
              } else if (state is EbookExploresStateLoading) {
                return Center(
                  child: HSWidget.circularProgressIndicator(),
                );
              } else if (state is EbookExploresStateSuccess) {
                return _ebookExploresSuccess(context, state.ebookModel);
              } else {
                return Center(
                    child: Text('الرجاء الانتظار', style: TextStyle(fontSize: 16, color: ebookTheme.themeMode().textColor),)
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _ebookExploresSuccess(BuildContext context, List<EbookEntity> entity){
    final ebookTheme = Provider.of<EbookTheme>(context);
    return GridView.builder(
        itemCount: entity.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1),
        ),
        itemBuilder: (context, index){
          EbookEntity entities = entity[index];
          return GestureDetector(
            onTap: () => pushPage(context, EbookDetail(ebookModel: entities,
              id: entities.id,
              status: entities.statusNews,
              title: entities.title,
              photo: entities.photo,
              description: entities.description,
              pdf: entities.pdf,
              authorName: entities.authorName,
              publisherName: entities.publisherName,
              pages: entities.pages,
              language: entities.language,
              price: entities.price,
            )),
            child: Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CachedNetworkImage(
                    imageUrl: entities.photo,
                    fit: BoxFit.cover,
                    height: 240.0,
                    width: 170.0,
                  ),
                  Text(
                    entities.title,
                    maxLines: 3,
                    style: TextStyle(
                        color: ebookTheme.themeMode().textColor,
                        fontSize: 17
                    ),
                  ),
                  // RatingBarIndicator(
                  //   rating: entities.rating.toDouble(),
                  //   unratedColor: ebookTheme.themeMode().ratingBar,
                  //   itemBuilder: (context, index) => Icon(
                  //     Icons.star,
                  //     color: Colors.amber,
                  //   ),
                  //   itemCount: 5,
                  //   itemSize: 16,
                  //   direction: Axis.horizontal,
                  // ),
                ],
              ),
            ),
          );
        }
    );
  }
}
