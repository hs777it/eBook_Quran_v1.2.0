import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:edu_ebook/bloc/ratings/ebook_ratings_event.dart';
import 'package:edu_ebook/bloc/ratings/ebook_ratings_state.dart';
import 'package:edu_ebook/source/core/api_constant.dart';
import 'package:edu_ebook/source/entities/ebook_ratings.dart';
import 'package:edu_ebook/source/models/ebook_ratings_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class EbookRatingsBloc extends Bloc<EbookRatingsEvent, EbookRatingsState>{

  final int id;

  EbookRatingsBloc({@required this.id}) : super(EbookRatingsStateInitial());

  @override
  Stream<EbookRatingsState> mapEventToState(EbookRatingsEvent event) async*{
    yield EbookRatingsStateLoading();
    try{
      List<EbookRatings> ebook = await _getEbookData(id);
      yield EbookRatingStateSuccess(ratings: ebook);
    }catch(error){
      throw Exception('Error catching + $error');
    }
  }

  Future<List<EbookRatings>> _getEbookData(int id) async{
    final response = await http.get(ApiConstant.BASE_URL+ApiConstant.API+ApiConstant.SHOW_RATINGS+id.toString());
    try{
      final body = jsonDecode(response.body);
      return EbookRatingsModel.fromJson(body).pdf;
    }catch(error){
      throw Exception('Error server + $error');
    }
  }

}