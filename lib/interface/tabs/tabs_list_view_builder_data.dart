import 'package:edu_ebook/interface/pages_detials/ebook_detail.dart';
import 'package:edu_ebook/interface/tabs/tabs_card_widget.dart';
import 'package:edu_ebook/routers/ebook_routers.dart';
import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:edu_ebook/source/models/ebook_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabsListViewBuilderData extends StatelessWidget {

  final List<EbookModel> ebook;


  const TabsListViewBuilderData({@required this.ebook});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: ebook.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index){
          return SizedBox(
            width: 10,
          );
        },
        itemBuilder: (context, index){
          final EbookEntity ebookEntity = ebook[index];
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
            child: TabsCardWidget(
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
