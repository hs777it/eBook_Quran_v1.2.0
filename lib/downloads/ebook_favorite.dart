import 'dart:io';

import 'package:objectdb/objectdb.dart';
import 'package:path_provider/path_provider.dart';

class EbookFavorite {

  getPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = directory.path + '/ebook_favorites.db';
    return path;
  }

  addFavorites(Map map) async {
    final database = ObjectDB(await getPath());
    database.open();
    database.insert(map);
    await database.close();
  }

  Future<int> remove(Map map) async {
    final database = ObjectDB(await getPath());
    database.open();
    int val = await database.remove(map);
    await database.close();
    return val;
  }

  Future<List> listAll() async {
    final database = ObjectDB(await getPath());
    database.open();
    List list = await database.find({});
    database.tidy();
    await database.close();
    return list;
  }

  Future<List> check(Map map) async {
    final database = ObjectDB(await getPath());
    database.open();
    List check = await database.find(map);
    await database.close();
    return check;
  }
}