import 'dart:convert';

import 'package:edu_ebook/source/entities/ebook_title_entity.dart';
import 'package:edu_ebook/source/models/ebook_title_result.dart';
import 'package:http/http.dart' as http;

import 'api_constant.dart';

class ApiTitle{
  // ignore: missing_return
  Future<List<EbookTitleEntity>> ebookEntity() async{
    final response = await http.get(ApiConstant.BASE_URL+ApiConstant.API+ApiConstant.TITLE);
    try{
      final body = jsonDecode(response.body);
      return EbookTitleResult.fromJson(body).pdf;
    }catch(_){
      print("error get title");
    }
  }
}