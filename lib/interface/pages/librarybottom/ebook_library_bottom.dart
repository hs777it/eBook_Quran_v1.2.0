import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_ebook/bloc/search/ebook_search_bloc.dart';
import 'package:edu_ebook/bloc/shops/ebook_explores_bloc.dart';
import 'package:edu_ebook/bloc/shops/ebook_explores_event.dart';
import 'package:edu_ebook/bloc/shops/ebook_explores_state.dart';
import 'package:edu_ebook/di/dependency_injection.dart';
//import 'package:edu_ebook/interface/pages/appbar/ebook_app_bar.dart';
import 'package:edu_ebook/interface/pages_detials/ebook_detail.dart';
import 'package:edu_ebook/routers/ebook_routers.dart';
import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:edu_ebook/widgets/progress_indicator.dart';
import 'package:edu_ebook/widgets/screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class EbookLibraryBottom extends StatefulWidget {
  @override
  _EbookExploresState createState() => _EbookExploresState();
}

class _EbookExploresState extends State<EbookLibraryBottom> {

  EbookExploresBloc ebookExploresBloc;

  @override
  void initState() {
    super.initState();
    ebookExploresBloc = getItInstance<EbookExploresBloc>();
    ebookExploresBloc.add(EbookExploresEventList());
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=> SearchBloc(),
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil.statusBarHeight + 45,
              ),
              child: _ebookExplores(),
            ),
            //EbookAppBar(),
          ],
        ),
      ),
    );
  }

  Widget _ebookExplores(){
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Container(
      child: BlocProvider(
        create: (_) => ebookExploresBloc,
        child: BlocListener<EbookExploresBloc, EbookExploresState>(
          listener: (context, state){
            if (state is EbookExploresStateError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                )
              );
            }  
          },
          child: BlocBuilder<EbookExploresBloc, EbookExploresState>(
            bloc: ebookExploresBloc,
            builder: (context, state){
              if (state is EbookExploresStateInitial) {
                return Center(
                  child: HSWidget.linearProgressIndicator(),
                );
              } else if (state is EbookExploresStateLoading) {
                return Center(
                  child: HSWidget.linearProgressIndicator(),
                );
              } else if (state is EbookExploresStateSuccess) {
                return _ebookExploresSuccess(context, state.ebookModel);
              } else {
                return Center(
                  child: Text('Any problem with internal Server', style: TextStyle(fontSize: 16, color: ebookTheme.themeMode().textColor),)
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
            crossAxisCount: 1,
            childAspectRatio: 2.8
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
            child: Row(
              children: [
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 1,
                  color: ebookTheme.themeData().backgroundColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: CachedNetworkImage(
                          imageUrl: entities.photo,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.height / 7,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.5),
                          child: Container(
                            child: Text(
                              entities.title,
                              maxLines: 3,
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
          );
        }
    );
  }
}
