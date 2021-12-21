import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'download_popup_custom.dart';

class DownloadPopUp extends StatefulWidget {

  final String url;
  final String path;

  DownloadPopUp({Key key, @required this.url, @required this.path}) :super(key: key);

  @override
  _DownloadPopUpState createState() => _DownloadPopUpState();
}

class _DownloadPopUpState extends State<DownloadPopUp> {

  Dio dio = Dio();
  int received = 0;
  int totalProgress = 0;
  String progress = '0';

  download() async{
    await dio.download(widget.url, widget.path, deleteOnError: true,
    onReceiveProgress: (receiverBytes, totalBytes) {
      setState(() {
        received = receiverBytes;
        totalProgress = totalBytes;
        progress = (received / totalProgress * 100).toStringAsFixed(0);
      });
      if (receiverBytes == totalBytes) {
        Navigator.pop(context, formatBytes(totalProgress, 1));
      }  
    });
  }

  @override
  void initState() {
    super.initState();
    download();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: DownloadPopUpCustom(
        widget: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'جاري التنزيل ...',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 20.0),
              Container(
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: LinearProgressIndicator(
                  value: double.parse(progress) / 100.0,
                  valueColor:
                  AlwaysStoppedAnimation(Theme.of(context).accentColor),
                  backgroundColor:
                  Theme.of(context).accentColor.withOpacity(0.3),
                ),
              ),
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '$progress %',
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${formatBytes(received, 1)} '
                        'of ${formatBytes(totalProgress, 1)}',
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  formatBytes(bytes, decimals) {
    if (bytes == 0) return 0.0;
    var k = 1024,
        dm = decimals <= 0 ? 0 : decimals,
        sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = (log(bytes) / log(k)).floor();
    return (((bytes / pow(k, i)).toStringAsFixed(dm)) + ' ' + sizes[i]);
  }
}
