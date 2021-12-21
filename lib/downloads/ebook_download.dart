import 'dart:io';

import 'package:objectdb/objectdb.dart';
import 'package:path_provider/path_provider.dart';

class EbookDownload {

  getPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = directory.path + '/ebook_downloads.db';
    return path;
  }

  addDownload(Map map) async{
    final database = ObjectDB(await getPath());
    database.open();
    database.insert(map);
    database.tidy();
    await database.close();
  }

  Future<int> remove(Map map) async {
    final database = ObjectDB(await getPath());
    database.open();
    int val = await database.remove(map);
    database.tidy();
    await database.close();
    return val;
  }

  Future removeById(Map map) async{
    final database = ObjectDB(await getPath());
    database.open();
    List val = await database.find({});
    val.forEach((element) {
      database.remove(element);
    });
    database.tidy();
    await database.close();
  }

  Future<List> listAll() async {
    final database = ObjectDB(await getPath());
    database.open();
    List list = await database.find({});
    database.tidy();
    await database.close();
    return list;
  }

  Future<List> check(Map map) async{
    final database = ObjectDB(await getPath());
    database.open();
    List list = await database.find(map);
    database.tidy();
    await database.close();
    return list;
  }

  clear() async {
    final database = ObjectDB(await getPath());
    database.open();
    database.remove({});
  }
}