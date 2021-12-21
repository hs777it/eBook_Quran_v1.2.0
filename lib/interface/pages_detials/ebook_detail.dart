import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:edu_ebook/bloc/ratings/ebook_ratings_bloc.dart';
import 'package:edu_ebook/bloc/ratings/ebook_ratings_event.dart';
import 'package:edu_ebook/bloc/related/ebook_related_bloc.dart';
import 'package:edu_ebook/bloc/related/ebook_related_event.dart';
import 'package:edu_ebook/bloc/related/ebook_related_state.dart';
import 'package:edu_ebook/di/dependency_injection.dart';
import 'package:edu_ebook/downloads/ebook_locator.dart';
import 'package:edu_ebook/downloads/utils/download_details.dart';
import 'package:edu_ebook/interface/localization/demo_localizations.dart';
import 'package:edu_ebook/interface/pages/suggestion/ebook_suggest_card_widget.dart';
import 'package:edu_ebook/interface/pages_detials/ebook_pdf.dart';
import 'package:edu_ebook/routers/ebook_routers.dart';
import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:edu_ebook/source/entities/ebook_payments.dart';
import 'package:edu_ebook/source/models/ebook_model.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:edu_ebook/widgets/size_space.dart';
import 'package:edu_ebook/widgets/text_exteonsion.dart';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'ebook_detail_description.dart';

class EbookDetail extends StatefulWidget {

  final EbookModel ebookModel;
  final int id, status;
  final String title;
  final String photo;
  final String description;
  final String pdf;
  final String authorName;
  final String publisherName;
  final int pages;
  final String language;
  final int price;

  EbookDetail({@required this.ebookModel,
    @required this.id,
    @required this.status,
    @required this.title,
    @required this.photo,
    @required this.description,
    @required this.pdf,
    @required this.authorName,
    @required this.publisherName,
    @required this.pages,
    @required this.language,
    @required this.price});

  @override
  _EbookDetailState createState() => _EbookDetailState();
}

class _EbookDetailState extends State<EbookDetail> {

  EbookRelatedBloc ebookRelatedBloc;
  EbookRatingsBloc ebookRatingsBloc;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  Future<List<EbookPayments>> ebookEntity;
  DownloadDetails dd;
  String assetPath = "";

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
            (_) {
          Provider.of<DownloadDetails>(context, listen: false).setEbook(widget.id);
          Provider.of<DownloadDetails>(context, listen: false).checkDownload(widget.id);
          Provider.of<DownloadDetails>(context, listen: false).checkFav(widget.id);
        }
    );
    ebookRelatedBloc = getItInstance<EbookRelatedBloc>();
    ebookRelatedBloc.add(EbookRelatedEventList());
    ebookRatingsBloc = EbookRatingsBloc(id: widget.id);
    ebookRatingsBloc.add(EbookRatingsEventList());
  }

  @override
  Widget build(BuildContext context) {
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Consumer<DownloadDetails>(
        builder: (context, details, _){
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text(DemoLocalizations.of(context).translate('detail_book'), style: TextStyle(color: ebookTheme.themeMode().textColor),),
              leading: BackButton(
                color: ebookTheme.themeMode().iconColor,
              ),
              backgroundColor: ebookTheme.themeMode().backgroundColor,
              actions: [
                IconButton(
                  onPressed: () async{
                    if (details.favorite) {
                      details.removeFavorite(widget.id);
                    }  else {
                      details.addFavorite(widget.id, widget.ebookModel);
                    }
                  },
                  icon: Icon(
                    details.favorite ? Icons.favorite : Icons.favorite,
                    color: details.favorite ? Colors.red : ebookTheme.themeMode().iconColor,
                  ),
                ),
                IconButton(
                  onPressed: () => _share(),
                  icon: Icon(
                      Icons.share,
                      color: ebookTheme.themeMode().iconColor,),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.photo,
                      width: 120,
                      height: 190,
                    ),
                    SizeSpace(number: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 340),
                              child: Container(
                                child: Text(
                                  widget.title,
                                  style: TextStyle(
                                    color: ebookTheme.themeMode().textColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            SizeSpace(number: 10,),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 200),
                              child: Text(
                                removeAllHtmlTags("", widget.authorName),
                                style: TextStyle(
                                    color: ebookTheme.themeMode().subTitle,
                                    fontSize: 18
                                ),
                              ),
                            ),
                            SizeSpace(number: 10,),
                            // ConstrainedBox(
                            //   constraints: BoxConstraints(maxWidth: 200),
                            //   child: Text(
                            //     removeAllHtmlTags("", widget.publisherName),
                            //     style: TextStyle(
                            //         color: ebookTheme.themeMode().subTitle,
                            //         fontSize: 18
                            //     ),
                            //   ),
                            // ),
                          ],
                        )
                      ],
                    ),

                    SizeSpace(number: 20,),

                    Padding(
                      padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 7 ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child:
                        widget.pdf.substring(widget.pdf.lastIndexOf(".")+1)
                            == 'pdf' ? _downloadEbookPdf(details, context) :
                        _downloadEbook(details, context),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 0.9),
                        borderRadius: BorderRadius.circular(7),
                        gradient: LinearGradient(
                            colors: [
                              Colors.blue[900],
                              Colors.blue[300],
                              Colors.blue[900]
                            ],
                            begin: FractionalOffset.topLeft,
                            end: FractionalOffset.bottomRight
                        )
                    ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.file_present,
                                  color: Colors.white70,),
                              ),
                              Text(
                                '${widget.price} Mb',
                                style: TextStyle(
                                    color: ebookTheme.themeMode().textButton
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '${widget.pages}',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 19
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  DemoLocalizations.of(context).translate('pages'),
                                  style: TextStyle(
                                      color: ebookTheme.themeMode().textButton
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Column(
                          //   children: [
                          //     IconButton(
                          //       onPressed: (){},
                          //       icon: Icon(Icons.library_books, color: ebookTheme.themeMode().iconColor,),
                          //     ),
                          //     Text(
                          //       DemoLocalizations.of(context).translate('ebook'),
                          //       style: TextStyle(
                          //           color: ebookTheme.themeMode().textColor
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    SizeSpace(number: 20,),
                    //About this Ebook
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => pushPage(context, EbookDetailDescription(description: widget.description,)),
                                 child: Text(
                                DemoLocalizations.of(context).translate('about'),
                                style: TextStyle(
                                    color: ebookTheme.themeMode().textColor,
                                    fontSize: 18
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => pushPage(context, EbookDetailDescription(description: widget.description,)),
                              icon: Icon(Icons.description, color: ebookTheme.themeMode().iconColor,),
                            ),
                          ],
                        ),
                        SizeSpace(number: 26,),
                        Text(
                          removeAllHtmlTags("",widget.description.bookDescription()),
                          style: TextStyle(
                              color: ebookTheme.themeMode().subTitle,
                              fontSize: 16
                          ),
                        ),
                      ],
                    ),
                    SizeSpace(number: 26,),
                    Text(DemoLocalizations.of(context).translate('more_ebook'), style: TextStyle(color: ebookTheme.themeMode().textColor, fontSize: 17),),
                    _ebookRelated(),
                  ],
                )
              ),
            ),
          );
        }
    );
  }

  Widget _ebookRelated(){
    return Padding(
      padding: EdgeInsets.only(top: 7),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: BlocProvider(
          create: (_)=> ebookRelatedBloc,
          child: BlocBuilder<EbookRelatedBloc, EbookRelatedState>(
              bloc: ebookRelatedBloc,
              builder: (context, state){
                if (state is EbookRelatedStateLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }  else if (state is EbookRelatedStateSuccess) {
                  return Center(
                      child: _ebookSuccess(context, state.ebook)
                  );
                }  else {
                  return Center(
                    child: Text('ERROR INTERNAL SERVER', style: TextStyle(color: Colors.grey),),
                  );
                }
              }
          ),
        ),
      ),
    );
  }

  Widget _ebookSuccess(BuildContext context, List<EbookEntity> listName){
    return ListView.separated(
        shrinkWrap: true,
        itemCount: listName.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index){
          return SizedBox(
            width: 10,
          );
        },
        itemBuilder: (context, index){
          final EbookEntity ebookEntityData = listName[index];
          return InkWell(
            onTap: (){pushPage(context,
                EbookDetail(
                  ebookModel: ebookEntityData,
                  id: ebookEntityData.id,
                  status: ebookEntityData.statusNews,
                  title: ebookEntityData.title,
                  photo: ebookEntityData.photo,
                  description: ebookEntityData.description,
                  pdf: ebookEntityData.pdf,
                  authorName: ebookEntityData.authorName,
                  publisherName: ebookEntityData.publisherName,
                  pages: ebookEntityData.pages,
                  language: ebookEntityData.language,
                  price: ebookEntityData.price,));
            },
            child: EbookSuggestCardWidget(
              ebookModel: ebookEntityData,
              id: ebookEntityData.id,
              title: ebookEntityData.title,
              photo: ebookEntityData.photo,
              description: ebookEntityData.description,
            ),
          );
        }
    );
  }

  Future<File> fromAsset(String asset, String filename) async {
    try {
      Uri uri = Uri.parse('$asset$filename');
      File file = File.fromUri(uri);
      return file;
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
  }

  _openEbookPdf(DownloadDetails details, int id) async{
    List ebookList = await details.getDownload(id.toString());
    if (ebookList.isNotEmpty) {
      Map maps = ebookList[0];
      //String urlGet = widget.pdf.substring(widget.pdf.lastIndexOf('/')+1); // bookName
      String path = maps['path'];
      String lastName = path.substring(path.lastIndexOf("/")+1);
      fromAsset('/storage/emulated/0/Live by Quran/', lastName).then((value) {
        setState(() {
          assetPath = value.path;
          Navigator.push(context,MaterialPageRoute(
            builder: (context) => PdfPage(path: assetPath, title: widget.title), // bookTitle
            //builder: (context) => PdfPage(path: assetPath, title: urlGet,),
          ));
        });
      });
    }
  }

  _downloadEbookPdf(DownloadDetails details, BuildContext context){
    final ebookTheme = Provider.of<EbookTheme>(context);
    if (widget.status != 0) {
      if (details.downloaded) {
        return DelayedDisplay(
          delay: Duration(seconds: 1),
          child: FutureBuilder(
              future: ebookEntity,
              builder: (BuildContext context, AsyncSnapshot<List<EbookPayments>> snapshot){
                return GestureDetector(
                  onTap: () => _openEbookPdf(details, widget.id),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 0.9),
                        borderRadius: BorderRadius.circular(7),
                        gradient: LinearGradient(
                            colors: [
                              Colors.blueAccent,
                              Colors.blueAccent
                            ],
                            begin: FractionalOffset.topLeft,
                            end: FractionalOffset.bottomRight
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(DemoLocalizations.of(context).translate('read_book'),
                          style: TextStyle(
                              color: ebookTheme.themeMode().textButton,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),)
                      ],
                    ),
                  ),
                );
              }
          ),
        );
      }  else {
        return GestureDetector(
          onTap: () => details.downloadFilePdf(context,
              widget.pdf,
              widget.title.replaceAll(' ', '_').replaceAll(r"\'", "'"),
              widget.photo,
              widget.id),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 45,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent, width: 0.9),
                borderRadius: BorderRadius.circular(7),
                gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white
                    ],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(DemoLocalizations.of(context).translate('download_book'),
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),)
              ],
            ),
          ),
        );
      }
    }  else {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 0.9),
            borderRadius: BorderRadius.circular(7),
            gradient: LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.blueAccent
                ],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DemoLocalizations.of(context).translate('coming_soon'),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500
              ),)
          ],
        ),
      );
    }
  }

  // EpubViewer
  _openEbook(DownloadDetails details, int id) async{
    List ebookList = await details.getDownload(id.toString());
    if (ebookList.isNotEmpty) {
      Map maps = ebookList[0];
      String path = maps['path'];
      List locator = await EbookLocator().getLocator(widget.id.toString());
      EpubViewer.setConfig(
          identifier: 'androidBook',
          nightMode: false,
          themeColor: Theme.of(context).accentColor,
          scrollDirection: EpubScrollDirection.HORIZONTAL,
          enableTts: false,
          allowSharing: true
      );

      EpubViewer.open(path,
          lastLocation: locator.isNotEmpty ? EpubLocator.fromJson(locator[0]) : null);
      EpubViewer.locatorStream.listen((event) async{
        Map json = jsonDecode(event);
        json['bookId'] = widget.id.toString();
        await EbookLocator().updateItem(json);
      });
    }
  }

  _downloadEbook(DownloadDetails details, BuildContext context){
    final ebookTheme = Provider.of<EbookTheme>(context);
    if (widget.status != 0) {
      if (details.downloaded) {
        return DelayedDisplay(
          delay: Duration(seconds: 1),
          child: FutureBuilder(
              future: ebookEntity,
              builder: (BuildContext context, AsyncSnapshot<List<EbookPayments>> snapshot){
                return GestureDetector(
                  onTap: () => _openEbook(details, widget.id),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 0.9),
                        borderRadius: BorderRadius.circular(7),
                        gradient: LinearGradient(
                            colors: [
                              Colors.blueAccent,
                              Colors.blueAccent
                            ],
                            begin: FractionalOffset.topLeft,
                            end: FractionalOffset.bottomRight
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(DemoLocalizations.of(context).translate('read_book'),
                          style: TextStyle(
                              color: ebookTheme.themeMode().textButton,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),)
                      ],
                    ),
                  ),
                );
              }
          ),
        );
      }  else {
        return GestureDetector(
          onTap: () => details.downloadFile(context,
              widget.pdf,
              widget.title.replaceAll(' ', '_').replaceAll(r"\'", "'"),
              widget.photo,
              widget.id),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 45,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent, width: 0.9),
                borderRadius: BorderRadius.circular(7),
                gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white
                    ],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(DemoLocalizations.of(context).translate('download_book'),
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),)
              ],
            ),
          ),
        );
      }
    }  else {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 0.9),
            borderRadius: BorderRadius.circular(7),
            gradient: LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.blueAccent
                ],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DemoLocalizations.of(context).translate('coming_soon'),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500
              ),)
          ],
        ),
      );
    }
  }

  String removeAllHtmlTags(String name, String htmlText) {
    RegExp exp = RegExp(
        r"<[^>]*>",
        multiLine: true,
        caseSensitive: true
    );
    return name + htmlText.replaceAll(exp, '');
  }

  _share() async{
    PackageInfo pi = await PackageInfo.fromPlatform();
    Share.text(pi.appName, "Title: ${widget.title}" '\n'
        "Author: ${widget.authorName}" '\n'
        "Publisher: ${widget.publisherName}" '\n'
        "Download full app in this link https://play.google.com/store/apps/details?id=${pi.packageName}" '\n'
        "version: ${pi.version}" '\n'
        "build number: ${pi.buildNumber} ",
        'text/plain');
  }

}
