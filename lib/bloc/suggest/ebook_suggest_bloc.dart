import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:edu_ebook/bloc/suggest/ebook_suggest_event.dart';
import 'package:edu_ebook/source/core/api_constant.dart';
import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:edu_ebook/source/models/ebook_result_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'ebook_suggest_state.dart';

class EbookSuggestBloc extends Bloc<EbookSuggestEvent, EbookSuggestState>{

  final String suggest;
  EbookSuggestBloc({@required this.suggest}) : super(EbookSuggestStateInitial());

  @override
  Stream<EbookSuggestState> mapEventToState(EbookSuggestEvent event) async*{
    yield EbookSuggestStateLoading();
    try{
      List<EbookEntity> ebook = await _getEbookData(suggest);
      yield EbookSuggestStateSuccess(ebookModel: ebook);
    }catch(_){
      throw Exception('Error catching');
    }
  }

  Future<List<EbookEntity>> _getEbookData(String query) async{
    final response = await http.get(ApiConstant.BASE_URL+ApiConstant.API+query);
    try{
      final body = jsonDecode(response.body);
      return EbookResultModel.fromJson(body).pdf;
    }catch(_){
      throw Exception('Error server');
    }
  }

}