import 'dart:io';

import 'package:objectdb/objectdb.dart';
import 'package:path_provider/path_provider.dart';

class EbookLocator {

  getPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = directory.path + '/ebook_locator.db';
    return path;
  }

  addItem(Map map) async{
    final database = ObjectDB(await getPath());
    database.open();
    database.insert(map);
    await database.close();
  }

  updateItem(Map map) async {
    final database = ObjectDB(await getPath());
    database.open();
    int update = await database.update({'bookId': map['bookId']}, map);
    if (update == 0) {
      database.insert(map);
    }
    await database.close();
  }

  Future<int> remove(Map map) async {
    final database = ObjectDB(await getPath());
    database.open();
    int val = await database.remove(map);
    await database.close();
    return val;
  }

  Future<List> listAll() async{
    final database = ObjectDB(await getPath());
    database.open();
    List val = await database.find({});
    await database.close();
    return val;
  }

  Future<List> getLocator(String id) async{
    final database = ObjectDB(await getPath());
    database.open();
    List val = await database.find({"bookId": id});
    await database.close();
    return val;
  }
}