import 'package:flutter/foundation.dart';

import '../../ebook_favorite.dart';

class EbookFavoriteNotifier extends ChangeNotifier{

  List list = List();
  bool loading = true;
  var dbFavorite = EbookFavorite();

  getEbooksFavorites() async{
    setLoading(true);
    list.clear();
    List listAll = await dbFavorite.listAll();
    list.addAll(listAll);
    setLoading(false);
  }

  setLoading(value){
    loading = value;
    notifyListeners();
  }

  setList(value){
    list = value;
    notifyListeners();
  }

  List getList(){
    return list;
  }
}