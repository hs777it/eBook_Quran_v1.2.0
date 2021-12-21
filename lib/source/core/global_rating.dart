import 'dart:convert';

import 'package:edu_ebook/source/entities/ebook_global_rating_entity.dart';
import 'package:edu_ebook/source/models/ebook_gr_result.dart';
import 'package:http/http.dart' as http;

import 'api_constant.dart';

class GlobalRating{
  // ignore: missing_return
  Future<List<EbookGlobalRatingEntity>> ebookEntity(int id) async{
    final response = await http.get(ApiConstant.BASE_URL+ApiConstant.GLOBAL_RATING+id.toString());
    try{
      final body = jsonDecode(response.body);
      return EbookGlobalRatingResult.fromJson(body).pdf;
    }catch(error){
      print("error get global rating + $error");
    }
  }
}