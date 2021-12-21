import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_ebook/source/models/ebook_model.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:edu_ebook/widgets/text_exteonsion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsCardWidget extends StatelessWidget {

  final EbookModel ebookModel;
  final int id;
  final String title, photo, description;

  const TabsCardWidget({@required this.ebookModel, this.id, this.title, this.photo, this.description});

  @override
  Widget build(BuildContext context) {
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: '$photo',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width / 2.2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            title.titleCustom(),
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ebookTheme.themeMode().textColor,
              fontSize: 16
            )
          ),
        )
      ],
    );
  }
}
