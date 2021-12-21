import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_ebook/bloc/random/ebook_random_bloc.dart';
import 'package:edu_ebook/bloc/random/ebook_random_event.dart';
import 'package:edu_ebook/bloc/random/ebook_random_state.dart';
import 'package:edu_ebook/bloc/search/ebook_search_bloc.dart';
import 'package:edu_ebook/bloc/shops/ebook_explores_state.dart';
import 'package:edu_ebook/interface/pages_detials/ebook_detail.dart';
import 'package:edu_ebook/routers/ebook_routers.dart';
import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class EbookRandom extends StatefulWidget {
  @override
  _EbookExploresState createState() => _EbookExploresState();
}

class _EbookExploresState extends State<EbookRandom> {

  EbookRandomBloc ebookExploresBloc;

  @override
  void initState() {
    super.initState();
    ebookExploresBloc = EbookRandomBloc();
    ebookExploresBloc.add(EbookRandomEventList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=> SearchBloc(),
      child: _ebookExplores(),
    );
  }

  Widget _ebookExplores(){
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Container(
      child: BlocProvider(
        create: (_) => ebookExploresBloc,
        child: BlocListener<EbookRandomBloc, EbookRandomState>(
          listener: (context, state){
            if (state is EbookRandomStateError) {
              Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  )
              );
            }
          },
          child: BlocBuilder<EbookRandomBloc, EbookRandomState>(
            bloc: ebookExploresBloc,
            builder: (context, state){
              if (state is EbookExploresStateInitial) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is EbookExploresStateLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is EbookRandomStateSuccess) {
                return _ebookExploresSuccess(context, state.ebookPurchased);
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
      padding: EdgeInsets.all(3 ),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        addAutomaticKeepAlives: true,
        itemCount: entity.length,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 3,
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
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 1,
              color: ebookTheme.themeData().backgroundColor,
                child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:7,right: 3),
                        child: CachedNetworkImage(
                          imageUrl: entities.photo,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.height / 7,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.5),
                          child: Container(
                            child: Text(
                              entities.title,
                              maxLines: 3,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: ebookTheme.themeMode().textColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.5),
                          child: Container(
                            child: Text(
                              entities.authorName,
                              maxLines: 2,
                              style: TextStyle(
                                color: ebookTheme.themeMode().textAppBar,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.5),
                          child: Container(
                            child: Text(
                              entities.publisherName,
                              maxLines: 2,
                              style: TextStyle(
                                color: ebookTheme.themeMode().textAppBar,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
            ),
          );
        }
    );
  }
}
