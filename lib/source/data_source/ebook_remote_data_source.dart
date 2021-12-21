

import 'package:edu_ebook/source/core/api_client.dart';
import 'package:edu_ebook/source/core/api_constant.dart';
import 'package:edu_ebook/source/models/ebook_model.dart';
import 'package:edu_ebook/source/models/ebook_ratings_model.dart';
import 'package:edu_ebook/source/models/ebook_ratings_model_result.dart';
import 'package:edu_ebook/source/models/ebook_result_model.dart';

abstract class EbookRemoteDataSource{
  Future<List<EbookModel>> getTrending();
  Future<List<EbookModel>> getPopular();
  Future<List<EbookModel>> getRandom();
  Future<List<EbookModel>> getComingSoon();
  Future<List<EbookModel>> getEbookExplores();
  Future<List<EbookModel>> getRelated();
  Future<List<EbookRatingsModelResult>> getRatings();
}

class EbookRemoteDataSourceImpl extends EbookRemoteDataSource{

  final ApiClient _client;

  EbookRemoteDataSourceImpl(this._client);

  @override
  Future<List<EbookModel>> getTrending() async {

    final response = await _client.get(ApiConstant.PDF);
    final pdf = EbookResultModel.fromJson(response).pdf;
    return pdf;

  }

  @override
  Future<List<EbookModel>> getPopular() async {
    final response = await _client.get(ApiConstant.POPULAR);
    final pdf = EbookResultModel.fromJson(response).pdf;
    return pdf;
  }

  @override
  Future<List<EbookModel>> getComingSoon() async{
    final response = await _client.get(ApiConstant.COMING_SOON);
    final pdf = EbookResultModel.fromJson(response).pdf;
    return pdf;
  }

  @override
  Future<List<EbookModel>> getRandom() async{
    final response = await _client.get(ApiConstant.LATEST);
    final pdf = EbookResultModel.fromJson(response).pdf;
    return pdf;
  }

  @override
  Future<List<EbookModel>> getEbookExplores() async{
    final response = await _client.get(ApiConstant.EXPLORES);
    final pdf = EbookResultModel.fromJson(response).pdf;
    return pdf;
  }

  @override
  Future<List<EbookModel>> getRelated() async{
    final response = await _client.get(ApiConstant.LATEST);
    final pdf = EbookResultModel.fromJson(response).pdf;
    return pdf;
  }

  @override
  Future<List<EbookRatingsModelResult>> getRatings() async{
    final response = await _client.get(ApiConstant.SHOW_RATINGS);
    final pdf = EbookRatingsModel.fromJson(response).pdf;
    return pdf;
  }

}