import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_ebook/interface/localization/demo_localizations.dart';
import 'package:edu_ebook/interface/pages/categories/ebook_categories.dart';
import 'package:edu_ebook/interface/pages/ebookbycat/ebook_by_category.dart';
import 'package:edu_ebook/routers/ebook_routers.dart';
import 'package:edu_ebook/source/core/global_category.dart';
import 'package:edu_ebook/source/entities/ebook_category_entities.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:edu_ebook/widgets/progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EbookCategory extends StatefulWidget {
  @override
  _EbookCategoryState createState() => _EbookCategoryState();
}

class _EbookCategoryState extends State<EbookCategory> {


  @override
  Widget build(BuildContext context) {
    final ebookTheme = Provider.of<EbookTheme>(context);
    return FutureBuilder<List<EbookCategoryEntities>>(
      future: categoryEntities(),
      builder: (context, snapshot){
        if (snapshot.hasData) {
          List<EbookCategoryEntities> category = snapshot.data;
          return SafeArea(
                      child: Container(
              decoration: BoxDecoration(
                color: ebookTheme.themeData().backgroundColor,
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(10),
                //     topRight: Radius.circular(10),
                //     bottomLeft: Radius.circular(10),
                //     bottomRight: Radius.circular(10)
                // ),  
                boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 3,
        blurRadius: 3,
        offset: Offset(0, 1), // changes position of shadow
      ),
    ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DemoLocalizations.of(context).translate('category'),
                            style: TextStyle(color: ebookTheme.themeMode().ratingBar,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: ()=>pushPage(context, EbookCategories()),
                            child: Text(
                              DemoLocalizations.of(context).translate('see_all'),
                              style: TextStyle(color: ebookTheme.themeMode().ratingBar,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    listView(category)
                  ],
                ),
              ),
            ),
          );
        }  else if (snapshot.hasError) {
          return Text("${snapshot.error}", style: TextStyle(color: ebookTheme.themeMode().textColor),);
        }
        return HSWidget.circularProgressIndicator();
      }
    );
  }

  Widget listView(List<EbookCategoryEntities> data){
    final ebookTheme = Provider.of<EbookTheme>(context);
    return SizedBox(
      height: 170,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: ()=>pushPage(context, EbookByCategory(id: data[index].catId,catName:data[index].name ,)),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: data[index].photoCat,
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                    ),
                    SizedBox(height: 5,),
                    Center(
                      child: Text(
                        data[index].name,
                        style: TextStyle(color: ebookTheme.themeMode().ratingBar,
                            fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
