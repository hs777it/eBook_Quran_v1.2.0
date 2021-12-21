import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DownloadPopUpCustom extends StatelessWidget {

  final Widget widget;
  DownloadPopUpCustom({Key key, @required this.widget}) : super(key: key);

  double deviceHeight;
  double deviceWidth;
  double dialogHeight;

  @override
  Widget build(BuildContext context) {
    
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;

    deviceWidth = orientation == Orientation.portrait ? size.width : size.height;
    deviceHeight = orientation == Orientation.portrait ? size.height : size.width;

    dialogHeight = deviceHeight * (0.50);
    
    return MediaQuery(
      data: MediaQueryData(),
      child: GestureDetector(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 0.5,
            sigmaY: 0.5
          ),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: deviceWidth * 0.9,
                          child: GestureDetector(
                            onTap: (){},
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0)
                                )
                              ),
                              child: widget,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
