import 'package:edu_ebook/bloc/suggest/ebook_suggest_bloc.dart';
import 'package:edu_ebook/bloc/suggest/ebook_suggest_event.dart';
import 'package:edu_ebook/bloc/suggest/ebook_suggest_state.dart';
import 'package:edu_ebook/interface/pages/explores/ebook_explores.dart';
import 'package:edu_ebook/interface/pages_detials/ebook_detail.dart';
import 'package:edu_ebook/routers/ebook_routers.dart';
import 'package:edu_ebook/source/core/api_constant.dart';
import 'package:edu_ebook/source/core/api_title.dart';
import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:edu_ebook/source/entities/ebook_title_entity.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'ebook_suggest_card_widget.dart';

class EbookSecondSuggestion extends StatefulWidget {
  @override
  _EbookSuggestionState createState() => _EbookSuggestionState();
}

class _EbookSuggestionState extends State<EbookSecondSuggestion> {

  EbookSuggestBloc suggestBloc;
  String suggest1 =  ApiConstant.SUGGEST2;
  Future<List<EbookTitleEntity>> ebook;

  @override
  void initState() {
    super.initState();
    suggestBloc = EbookSuggestBloc(suggest: suggest1);
    suggestBloc.add(EbookSuggestEventList());
    ebook = ApiTitle().ebookEntity();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>EbookSuggestBloc(suggest: suggest1),
      child: _ebookSuggest(),
    );
  }

  Widget _ebookSuggest(){
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Container(
      child: Column(
        children: [
          FutureBuilder(
            future: ebook,
            builder: (BuildContext context, AsyncSnapshot<List<EbookTitleEntity>> snapshot){
              return Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${snapshot.data[0].titleKeyword2}',
                      style: TextStyle(
                          color: ebookTheme.themeMode().textColor,
                          fontSize: 17
                      ),
                    ),
                    IconButton(
                      onPressed: ()=>pushPage(context, EbookExplores()),
                      icon: Icon(Icons.arrow_forward, color: Colors.blue,),
                    )
                  ],
                ),
              );
            }
          ),
          BlocProvider(
            create: (_)=>suggestBloc,
            child: BlocListener<EbookSuggestBloc, EbookSuggestState>(
              listener: (context, state){
                if (state is EbookSuggestStateError) {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(state.message))
                  );
                }
              },
              child: BlocBuilder<EbookSuggestBloc, EbookSuggestState>(
                  bloc: suggestBloc,
                  builder: (context, state){
                    if (state is EbookSuggestStateInitial) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }  else if (state is EbookSuggestStateLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }  else if (state is EbookSuggestStateSuccess) {
                      return Center(child: _ebookSuccess(context, state.ebookModel));
                    }  else {
                      return Center(
                          child: Text('الرجاء الانتظار', style: TextStyle(fontSize: 16, color: ebookTheme.themeMode().textColor),)
                      );
                    }
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ebookSuccess(BuildContext context, List<EbookEntity> listName){
    return ListView.separated(
      itemCount: listName.length,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index){
        return SizedBox(
          width: 14,
        );
      },
      itemBuilder: (context, index){
        final EbookEntity ebookEntity = listName[index];
        return InkWell(
          onTap: (){pushPage(context,
              EbookDetail(ebookModel: ebookEntity,
                id: ebookEntity.id,
                status: ebookEntity.statusNews,
                title: ebookEntity.title,
                photo: ebookEntity.photo,
                description: ebookEntity.description,
                pdf: ebookEntity.pdf,
                authorName: ebookEntity.authorName,
                publisherName: ebookEntity.publisherName,
                pages: ebookEntity.pages,
                language: ebookEntity.language,
                price: ebookEntity.price,));
          },
          child: EbookSuggestCardWidget(
            ebookModel: ebookEntity,
            id: ebookEntity.id,
            title: ebookEntity.title,
            photo: ebookEntity.photo,
            description: ebookEntity.description,
          ),
        );
      }
    );
  }
}
