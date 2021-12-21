import 'package:edu_ebook/source/core/app_constant.dart';
import 'package:flutter/material.dart';

import 'contactus_lib.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // bottomNavigationBar: ContactUsBottomAppBar(
        //   companyName: 'Abhishek Doshi',
        //   textColor: Colors.white,
        //   backgroundColor: Colors.teal.shade300,
        //   email: 'adoshi26.ad@gmail.com',
        // ),
        backgroundColor: Colors.blue,
        body: ContactUs(
          cardColor: Colors.blue[50],
          textColor: Colors.blue.shade900,
          logo: AssetImage(AppConstant.APP_LOGO),
          logoBg: Colors.white10,
          logoRadius: 90,
          
          companyName: AppConstant.APP_DESCRIPTION,
          companyFontSize: 20,
          companyColor: Colors.blue.shade100,
          
          logoDivider: logoDividerWidget(2,30,30),

          phoneNumber: '+96560907666',
          

          //tagLine: 'Flutter Developer',
          taglineColor: Colors.white,
          email: 'adoshi26.ad@gmail.com',
          emailText: 'adoshi26.ad@gmail.com',
          phoneNumberText: '60907666',
          website: 'https://smartmedia-kw.com',
          websiteText: "smartmedia-kw.com",
        ),
      ),
    );
  }
}
