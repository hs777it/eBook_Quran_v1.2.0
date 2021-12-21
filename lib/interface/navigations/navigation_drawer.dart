import 'package:edu_ebook/interface/home.dart';
import 'package:edu_ebook/routers/ebook_routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'navigation_drawer_item_list.dart';

class NavigationDrawer extends StatelessWidget {

  const NavigationDrawer();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black45.withOpacity(0.7),
            blurRadius: 3
          )
        ]
      ),
      width: 250,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "assets/images/logo.png",
              ),
            ),
            NavigationDrawerItemList(
              title: 'Home',
              onTap: ()=>pushPage(context, Home()),
            ),
            NavigationDrawerItemList(
              title: 'Explores',
              onTap: ()=>pushPage(context, null),
            ),
            // NavigationDrawerItemList(
            //   title: 'Favorites',
            //   onTap: ()=>pushPage(context, EbookFavoritePage()),
            // ),
            // NavigationDrawerItemList(
            //   title: 'Downloads',
            //   onTap: ()=>pushPage(context, EbookDownloadPage()),
            // ),
            // NavigationDrawerItemList(
            //   title: 'About',
            //   onTap: ()=>pushPage(context, EbookAbout()),
            // ),
            // NavigationDrawerItemList(
            //   title: 'More Apps',
            //   onTap: (){
            //     _openPlayStore();
            //   },
            // )
          ],
        ),
      ),
    );
  }

}
