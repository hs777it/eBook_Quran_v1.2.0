import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_ebook/interface/localization/demo_localizations.dart';
import 'package:edu_ebook/interface/pages/ebookbycat/ebook_by_category.dart';
import 'package:edu_ebook/routers/ebook_routers.dart';
import 'package:edu_ebook/source/core/global_category.dart';
import 'package:edu_ebook/source/entities/ebook_category_entities.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EbookCategories extends StatefulWidget {
  @override
  _EbookCategoryState createState() => _EbookCategoryState();
}

class _EbookCategoryState extends State<EbookCategories> {


  @override
  Widget build(BuildContext context) {
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ebookTheme.themeMode().textColor,
        ),
        title: Text(DemoLocalizations.of(context).translate('category'), style: TextStyle(color: ebookTheme.themeMode().textColor),),
        centerTitle: true,
        backgroundColor: ebookTheme.themeMode().toggleButtonColor,
      ),
      body: FutureBuilder<List<EbookCategoryEntities>>(
          future: categoryEntities(),
          builder: (context, snapshot){
            if (snapshot.hasData) {
              List<EbookCategoryEntities> category = snapshot.data;
              return listView(category);
            }  else if (snapshot.hasError) {
              return Text("${snapshot.error}", style: TextStyle(color: ebookTheme.themeMode().textColor),);
            }
            return Center(child: CircularProgressIndicator());
          }
      ),
    );
  }

  Widget listView(List<EbookCategoryEntities> data){
    final ebookTheme = Provider.of<EbookTheme>(context);
    return GridView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index){
        return GestureDetector(
          onTap: ()=>pushPage(
            context, EbookByCategory(
              id: data[index].catId,
              catName: data[index].name)),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: data[index].photoCat,
                    fit: BoxFit.cover,
                    width: 140,
                    height: 147,
                  ),
                  Center(
                    child: Text(
                      data[index].name,
                      style: TextStyle(color: ebookTheme.themeMode().ratingBar,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
