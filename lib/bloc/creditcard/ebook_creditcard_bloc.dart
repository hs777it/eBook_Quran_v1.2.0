import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:edu_ebook/bloc/creditcard/ebook_creditcard_event.dart';
import 'package:edu_ebook/bloc/creditcard/ebook_creditcard_state.dart';
import 'package:edu_ebook/source/core/api_constant.dart';
import 'package:edu_ebook/source/entities/ebook_cc.dart';
import 'package:edu_ebook/source/models/ebook_cc_model_result.dart';
import 'package:http/http.dart' as http;

class EbookCreditCardBloc extends Bloc<EbookCreditCardEvent, EbookCreditCardState>{

  final String id;

  EbookCreditCardBloc({this.id}) : super(EbookCreditCardStateInitial());

  @override
  Stream<EbookCreditCardState> mapEventToState(EbookCreditCardEvent event) async*{
    yield EbookCreditCardStateLoading();
    if (event is EbookCreditCardEventList) {
      try{
        List<EbookCC> creditCard = await _getEbookData(id);
        yield EbookCreditCardStateSuccess(ccList: creditCard);
      }catch(error){
        print("any error get cc $error");
      }
    }
  }

  Future<List<EbookCC>> _getEbookData(String id) async{
    final response = await http.get(ApiConstant.BASE_URL+ApiConstant.API+ApiConstant.SHOW_CC+id.toString());
    try{
      final body = jsonDecode(response.body);
      return EbookCCModelResult.fromJson(body).pdf;
    }catch(error){
      throw Exception('Error server + $error');
    }
  }
}