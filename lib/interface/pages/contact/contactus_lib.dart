import 'package:flutter/material.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

///Class for adding contact details/profile details as a complete new page in your flutter app.
class ContactUs extends StatelessWidget {
  ///Logo of the Company/individual
  final ImageProvider logo;
  final Color logoBg;
  final double logoRadius;

  // Divider widget
  final Divider logoDivider;

  ///Ability to add an image
  final Image image;

  ///Phone Number of the company/individual
  final String phoneNumber;

  ///Text for Phonenumber
  final String phoneNumberText;

  ///Website of company/individual
  final String website;

  ///Text for Website
  final String websiteText;

  ///Email ID of company/individual
  final String email;

  ///Text for Email
  final String emailText;

  ///Twitter Handle of Company/Individual
  final String twitterHandle;

  ///Facebook Handle of Company/Individual
  final String facebookHandle;

  ///Linkedin URL of company/individual
  final String linkedinURL;

  ///Github User Name of the company/individual
  final String githubUserName;

  ///Name of the Company/individual
  final String companyName;

  ///Font size of Company name
  final double companyFontSize;

  ///TagLine of the Company or Position of the individual
  final String tagLine;

  ///Instagram User Name of the company/individual
  final String instagram;

  ///TextColor of the text which will be displayed on the card.
  final Color textColor;

  ///Color of the Card.
  final Color cardColor;

  ///Color of the company/individual name displayed.
  final Color companyColor;

  ///Color of the tagLine of the Company/Individual to be displayed.
  final Color taglineColor;

  ///Constructor which sets all the values.
  ContactUs(
      {@required this.companyName,
      @required this.textColor,
      @required this.cardColor,
      @required this.companyColor,
      @required this.taglineColor,
      @required this.email,
      this.emailText,
      this.logo,
      this.logoBg,
      this.logoRadius,
      this.logoDivider,
      this.image,
      this.phoneNumber,
      this.phoneNumberText,
      this.website,
      this.websiteText,
      this.twitterHandle,
      this.facebookHandle,
      this.linkedinURL,
      this.githubUserName,
      this.tagLine,
      this.instagram,
      this.companyFontSize});

  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0.0,
          contentPadding: EdgeInsets.all(8.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => launch('tel:' + phoneNumber),
                  child: Container(
                    height: 20.0,
                    alignment: Alignment.center,
                    child: Text('Call'),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () => launch('sms:' + phoneNumber),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    child: Text('Message'),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () => launch('https://wa.me/' + phoneNumber),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    child: Text('WhatsApp'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child:
         SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                // Logo
                Visibility(
                  visible: logo != null,
                  child: CircleAvatar(
                    //radius: MediaQuery.of(context).size.aspectRatio*150,
                    backgroundImage: logo,
                    backgroundColor: logoBg != null ? logoBg : Colors.white,
                    radius: logoRadius != null
                        ? logoRadius
                        : 30, //MediaQuery.of(context).size.width*0.3,
                  ),
                ),

                Visibility(
                    visible: image != null, child: image ?? SizedBox.shrink()),

                // Company Name
                Text(
                  companyName,
                  style: TextStyle(
                    fontSize: companyFontSize ?? 30.0,
                    color: companyColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Tag Line
                Visibility(
                  visible: tagLine != null,
                  child: Text(
                    tagLine ?? "",
                    style: TextStyle(
                      color: taglineColor,
                      fontSize: 20.0,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 7.0),

                // Divider
                logoDivider,

                SizedBox(height: 5.0),

                // Website
                Visibility(
                  visible: website != null,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.symmetric(
                      vertical: 3.0,
                      horizontal: 10.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: cardColor,
                    child: ListTile(
                      leading: Icon(Typicons.link),
                      title: Text(
                        websiteText ?? 'Website',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      onTap: () => launch(website),
                    ),
                  ),
                ),

                // Phone Number
                Visibility(
                  visible: phoneNumber != null,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.symmetric(
                      vertical: 3.0,
                      horizontal: 10.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: cardColor,
                    child: ListTile(
                      leading: Icon(Typicons.phone),
                      title: Text(
                        phoneNumberText ?? 'Phone Number',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      onTap: () => showAlert(context),
                    ),
                  ),
                ),

                // Email
                Card(
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.symmetric(
                    vertical: 3.0,
                    horizontal: 10.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: cardColor,
                  child: ListTile(
                    leading: Icon(Typicons.mail),
                    title: Text(
                      emailText ?? 'Email ID',
                      style: TextStyle(
                        color: textColor,
                      ),
                    ),
                    onTap: () => launch('mailto:' + email),
                  ),
                ),

                // Twitter
                Visibility(
                  visible: twitterHandle != null,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.symmetric(
                      vertical: 3.0,
                      horizontal: 10.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: cardColor,
                    child: ListTile(
                      leading: Icon(Typicons.social_twitter),
                      title: Text(
                        'Twitter',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      onTap: () =>
                          launch('https://twitter.com/' + twitterHandle),
                    ),
                  ),
                ),

                // Facebook
                Visibility(
                  visible: facebookHandle != null,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.symmetric(
                      vertical: 3.0,
                      horizontal: 10.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: cardColor,
                    child: ListTile(
                      leading: Icon(Typicons.social_facebook),
                      title: Text(
                        'Facebook',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      onTap: () =>
                          launch('https://www.facebook.com/' + facebookHandle),
                    ),
                  ),
                ),

                // Instagram
                Visibility(
                  visible: instagram != null,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.symmetric(
                      vertical: 3.0,
                      horizontal: 10.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: cardColor,
                    child: ListTile(
                      leading: Icon(Typicons.social_instagram),
                      title: Text(
                        'Instagram',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      onTap: () => launch('https://instagram.com/' + instagram),
                    ),
                  ),
                ),

                // Github
                Visibility(
                  visible: githubUserName != null,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.symmetric(
                      vertical: 3.0,
                      horizontal: 10.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: cardColor,
                    child: ListTile(
                      leading: Icon(Typicons.social_github),
                      title: Text(
                        'Github',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      onTap: () =>
                          launch('https://github.com/' + githubUserName),
                    ),
                  ),
                ),

                // Linkedin
                Visibility(
                  visible: linkedinURL != null,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.symmetric(
                      vertical: 3.0,
                      horizontal: 10.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: cardColor,
                    child: ListTile(
                      leading: Icon(Typicons.social_linkedin),
                      title: Text(
                        'Linkedin',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      onTap: () => launch(linkedinURL),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

///Class for adding contact details of the developer in your bottomNavigationBar in your flutter app.
class ContactUsBottomAppBar extends StatelessWidget {
  ///Color of the text which will be displayed in the bottomNavigationBar
  final Color textColor;

  ///Color of the background of the bottomNavigationBar
  final Color backgroundColor;

  ///Email ID Of the company/developer on which, when clicked by the user, the respective mail app will be opened.
  final String email;

  ///Name of the company or the developer
  final String companyName;

  ///Size of the font in bottomNavigationBar
  final double fontSize;

  ContactUsBottomAppBar(
      {@required this.textColor,
      @required this.backgroundColor,
      @required this.email,
      @required this.companyName,
      this.fontSize = 15.0});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: backgroundColor,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Text(
        'Designed and Developed by $companyName 💙\nWant to contact?',
        textAlign: TextAlign.center,
        style: TextStyle(color: textColor, fontSize: fontSize),
      ),
      onPressed: () => launch('mailto:$email'),
    );
  }
}

Widget logoDividerWidget(
    double dividerThickness, double dividerIndent, double dividerEndIndent) {
  return Divider(
    thickness: dividerThickness != null ? dividerThickness : 10,
    indent: dividerIndent != null ? dividerIndent : 50.0,
    endIndent: dividerEndIndent != null ? dividerIndent : 50.0,
  );
}
