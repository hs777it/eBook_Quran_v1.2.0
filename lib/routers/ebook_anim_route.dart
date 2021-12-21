import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EbookAnimRoute extends StatefulWidget {

  final List<String> text;
  final ValueChanged changed;

  EbookAnimRoute({@required this.text, @required this.changed});

  @override
  _EbookAnimRouteState createState() => _EbookAnimRouteState();
}

class _EbookAnimRouteState extends State<EbookAnimRoute> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Container(
      width: width * .6,
      height: width * .13,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              widget.changed(1);
            },
            child: Container(
              width: width * .6,
              height: width * .13,
              decoration: ShapeDecoration(
                color: ebookTheme.themeMode().toggleBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(width * .03),
                )
              ),
              child: Row(
                children: List.generate(
                  widget.text.length,
                    (index)=>Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * .1),
                      child: Text(
                        widget.text[index],
                        style: TextStyle(
                          color: Color(0xFF918f95),
                          fontSize: width * .04,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                )
              ),
            ),
          ),
          AnimatedAlign(
            alignment: ebookTheme.isLight
                ? Alignment.centerLeft
                : Alignment.centerRight,
            duration: Duration(milliseconds: 350),
            curve: Curves.ease,
            child: Container(
              alignment: Alignment.center,
              width: width * .30,
              height: width * .13,
              decoration: ShapeDecoration(
                  color: ebookTheme.themeMode().toggleButtonColor,
                  shadows: ebookTheme.themeMode().shadow,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width * .03))),
              child: Text(
                ebookTheme.isLight
                    ? widget.text[1]
                    : widget.text[0],
                style: TextStyle(
                    fontSize: width * .04, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
