import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:edu_ebook/source/core/api_constant.dart';
import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:edu_ebook/source/models/ebook_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'ebook_purchased_event.dart';
import 'ebook_purchased_state.dart';

class EbookPurchasedBloc extends Bloc<EbookPurchasedEvent, EbookPurchasedState>{

  EbookPurchasedBloc() : super(EbookPurchasedStateInitial());

  @override
  Stream<EbookPurchasedState> mapEventToState(EbookPurchasedEvent event) async*{
    yield EbookPurchasedStateLoading();
    if (event is EbookPurchasedEventList) {
      try{
        List<EbookEntity> ebookPurchased = await _getPurchasedData();
        yield EbookPurchasedStateSuccess(ebookPurchased: ebookPurchased);
      }catch(error){
        print("any error get purchased $error");
      }
    }
  }

  Future<List<EbookEntity>> _getPurchasedData() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("idUser");

    final response = await http.get(ApiConstant.BASE_URL+ApiConstant.API+ApiConstant.PURCHASED+id.toString());

    try{
      final body = jsonDecode(response.body);
      return EbookResultModel.fromJson(body).pdf;
    }catch(error){
      throw Exception('Error server + $error');
    }
  }
}