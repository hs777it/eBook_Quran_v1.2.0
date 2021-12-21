import 'dart:convert';

import 'package:edu_ebook/source/core/api_constant.dart';
import 'package:edu_ebook/source/entities/ebook_category_entities.dart';
import 'package:edu_ebook/source/models/ebook_category_model.dart';
import 'package:http/http.dart' as http;

// ignore: missing_return
Future<List<EbookCategoryEntities>> categoryEntities() async{
  final data = await http.get(ApiConstant.BASE_URL+ApiConstant.API+ApiConstant.CATEGORY);
  try{
    final body = jsonDecode(data.body);
    return EbookCategoryModel.fromJson(body).category;
  }catch(error){
    print(error);
  }
}