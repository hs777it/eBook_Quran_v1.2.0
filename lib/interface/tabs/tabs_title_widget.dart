import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsTitleWidget extends StatelessWidget {

  final String title;
  final Function onTap;
  final bool isSelected;

  const TabsTitleWidget({Key key,
    @required this.title,
    @required this.onTap,
    this.isSelected = true}) :
        assert(title != null, 'title should not be null'),
        assert(onTap != null, 'ontap should not be null'),
        assert(isSelected != null, 'isSelected should not be null'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                    bottom: BorderSide(
                        color: isSelected ? Colors.redAccent : Colors.blue,
                        width: 1
                    )
                )
            ),
          child: Text(
            title,
            style: isSelected ? TextStyle(color: Colors.amber, fontSize: 18) : TextStyle(color: ebookTheme.themeMode().textColor, fontSize: 18),
          ),
        )
      ),
    );
  }
}
