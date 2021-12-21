import 'dart:io';

import 'package:edu_ebook/source/core/api_constant.dart';
import 'package:edu_ebook/source/models/ebook_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../ebook_download.dart';
import '../ebook_favorite.dart';
import 'download_popup.dart';

class DownloadDetails extends ChangeNotifier{

  bool favorite = false, downloaded = false, loading = true;
  var ebookFav = EbookFavorite();
  var ebookDown = EbookDownload();
  int downloads, favorites;

  getFeeds(String feed) async{
    setLoading(true);

    try{
      setLoading(false);
    } catch (e){
      throw e;
    }
  }

  checkFav(int id) async {
    List list = await ebookFav.check({'id': id.toString()});
    if (list.isNotEmpty) {
      setFav(true);
    }else{
      setFav(false);
    }
  }

  removeFavorite(int id) async {
    ebookFav.remove({'id': id.toString()});
    checkFav(id);
  }

  addFavorite(int id, EbookModel ebookModel) async {
    await ebookFav.addFavorites({'id': id.toString(), 'item': ebookModel.toJson()});
    checkFav(id);
  }

  removeDownload(int id) async{
    ebookDown.remove({'id': id.toString()}).then((value) {
      print(value);
      checkDownload(id);
    });
  }

  Future<List> getDownload(String id) async {
    List ebook = await ebookDown.check({'id': id.toString()});
    return ebook;
  }

  addDownload(Map map, int id) async{
    //await ebookDown.removeById({'id': id.toString()});
    await ebookDown.addDownload(map);
    checkDownload(id);
  }

  checkDownload(int idse) async{
    List download = await ebookDown.check({'id': idse.toString()});

    if (download.isNotEmpty) {
      String path = download[0]['path'];
      if (await File(path).exists()) {
        setDownload(true);
      }  else {
        setDownload(false);
      }
    }  else {
      setDownload(false);
    }
  }

  Future downloadFilePdf(BuildContext context, String url, String name, String photo, int id) async{
    PermissionStatus ps = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    if (ps != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      startDownloadPdf(context, url, name, photo, id);
    }else{
      startDownloadPdf(context, url, name, photo, id);
    }
  }

  startDownloadPdf(BuildContext context, String url, String name, String photo, int id) async{
    Directory pdfDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    if (Platform.isAndroid) {
      Directory(pdfDir.path.split('Android')[0] + '${ApiConstant.APP_NAME}').createSync();
    }

    String platform = Platform.isIOS
        ? pdfDir.path + '/$name.pdf'
        : pdfDir.path.split('Android')[0] +
        '${ApiConstant.APP_NAME}/$name.pdf';
    print(platform);
    File file = File(platform);

    if (!await file.exists()) {
      await file.create();
    }  else {
      await file.delete();
      await file.create();
    }
    String replace = url.replaceAll(" ", "");
    print(replace);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder:(context) => DownloadPopUp(
        url: replace,
        path: platform,
      ),
    ).then((value) {
      if (value != null) {
        addDownload({
          'id': id.toString(),
          'path': platform,
          'image':photo,
          'size': value,
          'name': name,
        }, id);
      }
    });
  }

  Future downloadFile(BuildContext context, String url, String name, String photo, int id) async{
    PermissionStatus ps = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    if (ps != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      startDownload(context, url, name, photo, id);
    }else{
      startDownload(context, url, name, photo, id);
    }
  }

  startDownload(BuildContext context, String url, String name, String photo, int id) async{
    Directory pdfDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    if (Platform.isAndroid) {
      Directory(pdfDir.path.split('Android')[0] + '${ApiConstant.APP_NAME}').createSync();
    }

    String platform = Platform.isIOS
        ? pdfDir.path + '/$name.epub'
        : pdfDir.path.split('Android')[0] +
        '${ApiConstant.APP_NAME}/$name.epub';
    print(platform);
    File file = File(platform);
    
    if (!await file.exists()) {
      await file.create();
    }  else {
      await file.delete();
      await file.create();
    }
    String replace = url.replaceAll(" ", "");
    print(replace);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder:(context) => DownloadPopUp(
        url: replace,
        path: platform,
      ),
    ).then((value) {
      if (value != null) {
        addDownload({
          'id': id.toString(),
          'path': platform,
          'image':photo,
          'size': value,
          'name': name,
        }, id);
      }  
    });
  }

  void setLoading(value){
    loading = value;
    notifyListeners();
  }

  void setRelated(value){

  }

  void getRelated(){

  }

  void setEbook(value){
    downloads = value;
    notifyListeners();
  }

  void setFav(value){
    favorite = value;
    notifyListeners();
  }

  void setDownload(isDownload){
    downloaded = isDownload;
    notifyListeners();
  }
}