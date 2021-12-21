import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationDrawerItemList extends StatelessWidget {

  final String title;
  final Function onTap;
  final Icon icons;

  NavigationDrawerItemList({@required this.title, this.onTap, this.icons});

  @override
  Widget build(BuildContext context) {
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Container(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: ebookTheme.themeMode().backgroundColor,
                    blurRadius: 2
                )
              ]
          ),
          child: ListTile(
            leading: icons,
            title: Text(
                title,
                style: TextStyle(
                    color: ebookTheme.themeMode().textColor,
                    fontSize: 18
                )
            ),
          ),
        ),
      ),
    );
  }
}
