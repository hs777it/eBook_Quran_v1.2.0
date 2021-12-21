import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:edu_ebook/source/core/api_constant.dart';
import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:edu_ebook/source/models/ebook_result_model.dart';
import 'package:http/http.dart' as http;

import 'ebook_random_event.dart';
import 'ebook_random_state.dart';

class EbookRandomBloc extends Bloc<EbookRandomEvent, EbookRandomState>{

  EbookRandomBloc() : super(EbookRandomStateInitial());

  @override
  Stream<EbookRandomState> mapEventToState(EbookRandomEvent event) async*{
    yield EbookRandomStateLoading();
    if (event is EbookRandomEventList) {
      try{
        List<EbookEntity> ebookPurchased = await _getPurchasedData();
        yield EbookRandomStateSuccess(ebookPurchased: ebookPurchased);
      }catch(error){
        print("any error get purchased $error");
      }
    }
  }

  Future<List<EbookEntity>> _getPurchasedData() async{
    final response = await http.get(ApiConstant.BASE_URL+ApiConstant.API+ApiConstant.LATEST);

    try{
      final body = jsonDecode(response.body);
      return EbookResultModel.fromJson(body).pdf;
    }catch(error){
      throw Exception('Error server + $error');
    }
  }
}