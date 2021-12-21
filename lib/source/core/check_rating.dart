import 'dart:convert';

import 'package:edu_ebook/source/entities/ebook_ratings.dart';
import 'package:edu_ebook/source/models/ebook_ratings_model.dart';
import 'package:http/http.dart' as http;

import 'api_constant.dart';

class CheckRating{
  // ignore: missing_return
  Future<List<EbookRatings>> checkRating(String id) async{
    final response = await http.get(ApiConstant.BASE_URL+ApiConstant.API+ApiConstant.ALREADY_RATINGS+id.toString());
    try{
      final body = jsonDecode(response.body);
      return EbookRatingsModel.fromJson(body).pdf;
    }catch(error){
      print("error get global rating + $error");
    }
  }
}