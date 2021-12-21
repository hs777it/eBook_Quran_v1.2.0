import 'package:edu_ebook/interface/localization/demo_localizations.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:edu_ebook/widgets/size_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class EbookComment extends StatefulWidget {

  final double ratings;
  final int idEbook;

  EbookComment({this.ratings, this.idEbook});

  @override
  _EbookCommentState createState() => _EbookCommentState();
}

class _EbookCommentState extends State<EbookComment> {

  TextEditingController reviewsCtrl = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).translate('rating_and_review'), style: TextStyle(color: ebookTheme.themeMode().textColor),),
        backgroundColor: ebookTheme.themeMode().toggleButtonColor,
        leading: BackButton(
          color: ebookTheme.themeMode().textColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                RatingBarIndicator(
                  rating: widget.ratings,
                  unratedColor: ebookTheme.themeMode().ratingBar,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20,
                  direction: Axis.horizontal,
                ),
                SizeSpace(number: 20,),
                TextFormField(
                  controller: reviewsCtrl,
                  cursorColor: ebookTheme.themeMode().textColor,
                  maxLines: null,
                  decoration: new InputDecoration(
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fillColor: ebookTheme.themeMode().boxWrap,
                      filled: true,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                      hintText: DemoLocalizations.of(context).translate('write_your_review')),
                ),
                SizeSpace(number: 10,),
                GestureDetector(
                  onTap: ()=>{

                  },
                  child: Container(
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        border: Border.all(color: ebookTheme.themeMode().textColor),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 3, bottom: 3, left: 18, right: 18),
                      child: Text(
                          DemoLocalizations.of(context).translate('submit'),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 16,
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
