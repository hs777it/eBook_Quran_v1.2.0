import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_ebook/interface/pages_detials/ebook_detail.dart';
import 'package:edu_ebook/routers/ebook_routers.dart';
import 'package:edu_ebook/source/models/ebook_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EbookCardWidget extends StatelessWidget {

  final EbookModel ebookModel;
  final int id, pages, status, price;
  final String photo, description, title, pdf, authorName, publisherName, language;

  EbookCardWidget({@required this.ebookModel,
    @required this.id,
    @required this.status,
    @required this.price,
    @required this.photo,
    @required this.description,
    @required this.title,
    @required this.pdf,
    @required this.authorName,
    @required this.publisherName,
    @required this.pages,
    @required this.language});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 14,
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {pushPage(context,
            EbookDetail(ebookModel: ebookModel,
              id: id,
              status: status,
              title: title,
              photo: photo,
              description: description,
              pdf: pdf,
              authorName: authorName,
              publisherName: publisherName,
              pages: pages,
              language: language,
              price: price,));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: '$photo',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
