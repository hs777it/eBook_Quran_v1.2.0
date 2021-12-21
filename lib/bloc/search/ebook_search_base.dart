import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_ebook/bloc/shops/ebook_explores_bloc.dart';
import 'package:edu_ebook/bloc/shops/ebook_explores_event.dart';
import 'package:edu_ebook/bloc/shops/ebook_explores_state.dart';
import 'package:edu_ebook/di/dependency_injection.dart';
import 'package:edu_ebook/interface/pages_detials/ebook_detail.dart';
import 'package:edu_ebook/routers/ebook_routers.dart';
import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EbookSearchBase extends StatefulWidget {
  @override
  _EbookSearchBaseState createState() => _EbookSearchBaseState();
}

class _EbookSearchBaseState extends State<EbookSearchBase> {

  EbookExploresBloc ebookExploresBloc;

  @override
  void initState() {
    super.initState();
    ebookExploresBloc = getItInstance<EbookExploresBloc>();
    ebookExploresBloc.add(EbookExploresEventList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
          create: (_) => ebookExploresBloc,
          child: BlocBuilder<EbookExploresBloc, EbookExploresState>(
              bloc: ebookExploresBloc,
              builder: (context, state) {
                if (state is EbookExploresStateSuccess) {
                  print('benar');
                }
                return IconButton(
                    onPressed: () {
                      showSearch(context: context, delegate: EbookSearch());
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 22,
                    )
                );
              }
          )
      ),
    );
  }
}

class EbookSearch extends SearchDelegate<String>{

  final dataku = [
    'makan',
    'hore',
    'tau',
    'bakso testing',
    'bakso tes'
  ];

  final recentData = [
    'makan',
    'bakso',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: (){
      query = "";
    },)];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Card(
        color: Colors.red,
        child: Center(
          child: Text(query, style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    return BlocBuilder<EbookExploresBloc, EbookExploresState>(
        builder: (context, state){
          if (state is EbookExploresStateSuccess) {
            return GridView.builder(
                itemCount: state.ebookModel.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 2.8
                ),
                itemBuilder: (context, index){
                  EbookEntity entities = state.ebookModel[index];
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 7),
                              child: CachedNetworkImage(
                                imageUrl: entities.photo,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width / 5,
                                height: MediaQuery.of(context).size.height / 7,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
                              child: Container(
                                child: Text(
                                  entities.title,
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
                              child: Container(
                                child: Text(
                                  entities.authorName,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
                              child: Container(
                                child: Text(
                                  entities.publisherName,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: (){
                            //_share(entities);
                          },
                          icon: Icon(Icons.share),
                          color: Colors.greenAccent,
                        ),
                      ],
                    ),
                  );
                }
            );
          }
          return const SizedBox.shrink();
        }
    );

    // return ListView.builder(
    //   itemBuilder: (context, index) =>
    //       ListTile(
    //         onTap: (){
    //           showResults(context);
    //         },
    //         leading: Icon(Icons.photo, color: Colors.white,),
    //         title: Text(finalQuery[index], style: TextStyle(color: Colors.white),),
    //       ),
    //   itemCount: finalQuery.length,
    // );
  }
}