import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class EbookAbout extends StatefulWidget {
  @override
  _EbookAboutState createState() => _EbookAboutState();
}

class _EbookAboutState extends State<EbookAbout> {
  @override
  Widget build(BuildContext context) {
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ebookTheme.themeMode().textColor,
        ),
        title: Text(
          'About App',
          style: TextStyle(
              color: ebookTheme.themeMode().textColor
          ),
        ),
        centerTitle: true,
        backgroundColor: ebookTheme.themeMode().backgroundColor,
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () =>_openYoutube(),
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: 'https://risetcdn.jatimtimes.com/images/2020/06/29/YouTube-Foto-RIAUREVIEW.COM625bb3531c9225e2.jpg',
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      'Youtube',
                      maxLines: 1,
                      style: TextStyle(
                        color: ebookTheme.themeMode().textColor,
                        fontSize: 20
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: ()=>_openInstagram(),
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: 'https://miro.medium.com/max/4086/1*V7GYJQ_4lykfDzOf9q17eA.jpeg',
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      'Instagram',
                      maxLines: 1,
                      style: TextStyle(
                          color: ebookTheme.themeMode().textColor,
                          fontSize: 20
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: ()=>_openFacebook(),
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: 'https://www.hipsthetic.com/wp-content/uploads/2019/05/simple-facebook-icon.jpg',
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      'Facebook',
                      maxLines: 1,
                      style: TextStyle(
                          color: ebookTheme.themeMode().textColor,
                          fontSize: 20
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  _openYoutube() async {
    var url = "https://www.youtube.com/channel/UCftt1hli3mckK62d3IinrwQ";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _openInstagram() async {
    var url = "https://www.instagram.com/kitasinau/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _openFacebook() async {
    var url = "https://web.facebook.com/powerrenderdeveloper";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
