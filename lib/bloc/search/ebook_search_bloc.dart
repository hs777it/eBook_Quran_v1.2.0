import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_ebook/interface/pages_detials/ebook_detail.dart';
import 'package:edu_ebook/routers/ebook_routers.dart';
import 'package:edu_ebook/source/core/api_constant.dart';
import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:edu_ebook/source/models/ebook_result_model.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class EbookSearchBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final ebookTheme = Provider.of<EbookTheme>(context);
    return IconButton(
        onPressed: () async{
          await showSearch(context: context, delegate: EbookSearch(BlocProvider.of<SearchBloc>(context)));
        },
        icon: Icon(
          Icons.search,
          //color: ebookTheme.themeMode().textAppBar,
          //size: 32,
        )
    );
  }
}

class EbookEntityTitle{
  final String name;
  EbookEntityTitle({@required this.name});
}

class EbookSearch extends SearchDelegate<EbookEntity>{

  final Bloc<EbookSearchEvent, EbookSearchState> ebookBloc;

  EbookSearch(this.ebookBloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: (){
      query = "";
    },)];
  }

  @override
  Widget buildLeading(BuildContext context) {
    final ebookTheme = Provider.of<EbookTheme>(context);
    return IconButton(
      focusColor: ebookTheme.themeMode().ratingBar,
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  // ignore: missing_return
  Widget buildResults(BuildContext context) {

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final ebookTheme = Provider.of<EbookTheme>(context);
    ebookBloc.add(EbookSearchEvent(query));
    return BlocBuilder<SearchBloc, EbookSearchState>(
      bloc: ebookBloc,
      builder: (context, state){
        final datas = query.isEmpty ? state.entities : state.entities;
        return ListView.builder(
          itemBuilder: (context, index){
            EbookEntity entity = state.entities[index];
            return GestureDetector(
              onTap: () => pushPage(context, EbookDetail(ebookModel: entity,
                id: entity.id,
                status: entity.statusNews,
                title: entity.title,
                photo: entity.photo,
                description: entity.description,
                pdf: entity.pdf,
                authorName: entity.authorName,
                publisherName: entity.publisherName,
                pages: entity.pages,
                language: entity.language,
                price: entity.price,
              )),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 7),
                          child: CachedNetworkImage(
                            imageUrl: entity.photo,
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
                              entity.title,
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
                              entity.authorName,
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
                              entity.publisherName,
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
          },
          itemCount: datas.length,
        );
      }
    );
  }

}

class EbookSearchEvent {
  final String query;

  EbookSearchEvent(this.query);

}

class EbookSearchState {
  final bool isLoading;
  final List<EbookEntity> entities;
  final bool isError;

  EbookSearchState({this.isLoading, this.entities, this.isError});

  factory EbookSearchState.initial(){
    return EbookSearchState(
      entities: [],
      isLoading: false,
      isError: false
    );
  }

  factory EbookSearchState.loading(){
    return EbookSearchState(
        entities: [],
        isLoading: true,
        isError: false
    );
  }

  factory EbookSearchState.success(List<EbookEntity> ebookEntity){
    return EbookSearchState(
        entities: ebookEntity,
        isLoading: false,
        isError: false
    );
  }

  factory EbookSearchState.error(){
    return EbookSearchState(
        entities: [],
        isLoading: false,
        isError: true
    );
  }

}

class SearchBloc extends Bloc<EbookSearchEvent, EbookSearchState>{

  SearchBloc() : super(EbookSearchState.initial());

  @override
  Stream<EbookSearchState> mapEventToState(EbookSearchEvent event) async*{
    yield EbookSearchState.loading();
    try{
      List<EbookEntity> ebook = await getData(event.query);
      yield EbookSearchState.success(ebook);
    }catch(_){
      print('any problem with connection');
    }
  }

  Future<List<EbookEntity>> getData(String query) async{
    final response = await http.get(ApiConstant.BASE_URL+ApiConstant.API+ApiConstant.SEARCH+query);
        try{
          final body = jsonDecode(response.body);
          return EbookResultModel.fromJson(body).pdf;
        } catch (_){
          throw Exception('Error');
        }
  }
}