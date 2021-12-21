import 'dart:convert';

import 'package:edu_ebook/source/entities/ebook_payments.dart';
import 'package:edu_ebook/source/models/ebook_payments_model_result.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api_constant.dart';

class GlobalPayments{
  // ignore: missing_return
  Future<List<EbookPayments>> ebookEntity(String idProduct) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("idUser");

    final response = await http.get(ApiConstant.BASE_URL+ApiConstant.API+"payments="+idProduct.toString()+"&id_user="+id);
    try{
      final body = jsonDecode(response.body);
      return EbookPaymentsModelResult.fromJson(body).pdf;
    }catch(error){
      print("error get global payments + $error");
    }
  }
}