import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_ebook/source/models/ebook_model.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:edu_ebook/widgets/text_exteonsion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EbookSuggestCardWidget extends StatelessWidget {
  final EbookModel ebookModel;
  final int id;
  final String title, photo, description;

  const EbookSuggestCardWidget({
    @required this.ebookModel,
    @required this.id,
    @required this.title,
    @required this.photo,
    @required this.description});

  @override
  Widget build(BuildContext context) {
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Column(
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: CachedNetworkImage(
              imageUrl: '$photo',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width / 1.7,
              height: MediaQuery.of(context).size.height / 2.3 ,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text(
              title.titleCustom(),
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ebookTheme.themeMode().textColor,
                  fontSize: 16
              )
          ),
        ),
      ],
    );
  }
}
