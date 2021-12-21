import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:edu_ebook/source/core/api_constant.dart';
import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:edu_ebook/source/models/ebook_result_model.dart';
import 'package:http/http.dart' as http;

import 'ebook_bycat_event.dart';
import 'ebook_bycat_state.dart';

class EbookByCatsBloc extends Bloc<EbookByCatEvent, EbookByCatState>{

  final int id;

  EbookByCatsBloc({this.id}) : super(EbookExploresStateInitial());

  @override
  Stream<EbookByCatState> mapEventToState(EbookByCatEvent event) async*{
    if (event is EbookByCatEventList) {
      yield EbookExploresStateLoading();
      try{
        List<EbookEntity> ebook = await _getEbookData(id);
        yield EbookExploresStateSuccess(ebookModel: ebook);
      }catch(error){
        print(error);
      }
    }  
  }

  Future<List<EbookEntity>> _getEbookData(int id) async{
    final response = await http.get(ApiConstant.BASE_URL+ApiConstant.API+ApiConstant.EBOOKBYCAT+id.toString());
    try{
      final body = jsonDecode(response.body);
      return EbookResultModel.fromJson(body).pdf;
    }catch(error){
      throw Exception('Error server + $error');
    }
  }

}