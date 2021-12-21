import 'dart:async';
import 'package:edu_ebook/interface/bottombar/ebook_bottom_bar.dart';
import 'package:edu_ebook/routers/ebook_routers.dart';
import 'package:edu_ebook/widgets/hex_colors.dart';
import 'package:edu_ebook/widgets/progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EbookSplash extends StatefulWidget {
  @override
  _EbookSplashState createState() => _EbookSplashState();
}

class _EbookSplashState extends State<EbookSplash> {

  startTimeout() {
    return new Timer(Duration(seconds: 2), handleTimeout);
  }

  void handleTimeout() {
    changeScreen();
  }

  changeScreen() async {
    pushPageReplacement(context, EbookBottomBar());
  }

  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      getColorFromHex("038fd5"),
                      getColorFromHex("1c1665"),
                      //Colors.brown[50], ,
                      //Colors.brown[300] 
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    height: 250,
                    width: 250,
                  ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(child: HSWidget.circularProgressIndicator()),
                )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
