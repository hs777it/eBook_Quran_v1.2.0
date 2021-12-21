import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_ebook/downloads/ebook_download.dart';
import 'package:edu_ebook/downloads/ebook_locator.dart';
import 'package:edu_ebook/interface/localization/demo_localizations.dart';
import 'package:edu_ebook/interface/pages_detials/ebook_pdf.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:edu_ebook/widgets/size_space.dart';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class EbookDownloadPage extends StatefulWidget {
  @override
  _EbookDownloadState createState() => _EbookDownloadState();
}

class _EbookDownloadState extends State<EbookDownloadPage> {

  var dbDownload = EbookDownload();
  static final uuid = Uuid();
  bool finish = true;
  List list = List();
  String assetPath = "";
  
  getEbookDownload() async{
    List lists = await dbDownload.listAll();
    setState(() {
      list.addAll(lists);
    });
  }

  @override
  void initState() {
    super.initState();
    getEbookDownload();
  }

  @override
  Widget build(BuildContext context) {
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          color: ebookTheme.themeMode().textColor,
        ),
        backgroundColor: ebookTheme.themeMode().backgroundColor,
        title: Text(DemoLocalizations.of(context).translate('ebook_download'), style: TextStyle(color: ebookTheme.themeMode().textColor,),),
      ),
      body: list.isEmpty ? _emptyDownload() : _ebookDownload(),
    );
  }

  _emptyDownload(){
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Center(
      child: Column(
        children: [
          Image.asset(
            '',
            width: 250,
            height: 250,
          ),
          Text(
            DemoLocalizations.of(context).translate('there_are_no_download'),
            style: TextStyle(
              color: ebookTheme.themeMode().textColor,
              fontSize: 16
            ),
          )
        ],
      ),
    );
  }

  _ebookDownload(){
    final ebookTheme = Provider.of<EbookTheme>(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index){
        Map map = list[index];
        String title = map['name'];
        return Dismissible(
          key: ObjectKey(uuid.v4()),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.center,
            child: Icon(
              Icons.restore_from_trash,
              color: ebookTheme.themeMode().iconColor,
            ),
          ),
          onDismissed: (dismiss) => _deleteEbook(map, index),
          child: InkWell(
            onTap: () async{
              String path = map['path'];
              List list = await EbookLocator().getLocator(map['id']);
              String last = path.substring(path.lastIndexOf(".")+1);
              String lastName = path.substring(path.lastIndexOf("/")+1);
              if (last == 'pdf') {
                Future<File> fromAsset(String asset, String filename) async {
                  try {
                    Uri uri = Uri.parse('$asset$filename');
                    File file = File.fromUri(uri);
                    return file;
                  } catch (e) {
                    throw Exception('Error parsing asset file!');
                  }
                }
                fromAsset('/storage/emulated/0/Live by Quran/', lastName).then((value) {
                  setState(() {
                    assetPath = value.path;
                    Navigator.push(context,MaterialPageRoute(
                      builder: (context) => PdfPage(path: assetPath, title: lastName,),
                    ));
                  });
                });
                

              } else {
                EpubViewer.setConfig(
                  identifier: 'androidBook',
                  nightMode: false,
                  themeColor: Theme.of(context).accentColor,
                  scrollDirection: EpubScrollDirection.HORIZONTAL,
                  enableTts: false,
                  allowSharing: true,
                );
                EpubViewer.open(
                  path,
                  lastLocation: list.isNotEmpty ? EpubLocator.fromJson(list[0]) : null,
                );
                EpubViewer.locatorStream.listen((event) async{
                  Map map = jsonDecode(event);
                  map['bookId'] = map['id'];
                  await EbookLocator().updateItem(map);
                });
              }
            },
            child: Padding(
              padding: EdgeInsets.only(left: 7, right: 7, top: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CachedNetworkImage(
                    imageUrl: map['image'],
                    placeholder: (context, url) => Container(
                      width: MediaQuery.of(context).size.width / 5,
                      height: MediaQuery.of(context).size.height / 7,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      '',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width / 5,
                      height: MediaQuery.of(context).size.height / 7,
                    ),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 7,
                  ),
                  SizeSpace(number: 10,),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title.replaceAll("_", " "),
                            style: TextStyle(
                              fontSize: 16,
                              color: ebookTheme.themeMode().textColor
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '[Offline Books]',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ebookTheme.themeMode().textColor
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: Icon(
                                  Icons.check_circle,
                                  color: ebookTheme.themeMode().checkList,
                                )
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index){
        return Divider();
    }
    );
  }

  _deleteEbook(Map map, int index){
    dbDownload.remove({'id': map['id']}).then((value) async{
      File file = File(map['path']);
      if (await file.exists()) {
        file.delete();
      }
      setState(() {
        list.removeAt(index);
      });

    });
  }
}
