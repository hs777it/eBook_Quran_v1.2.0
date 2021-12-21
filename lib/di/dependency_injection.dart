import 'package:edu_ebook/bloc/background/ebook_background_bloc.dart';
import 'package:edu_ebook/bloc/carousels/ebook_carousel_bloc.dart';
import 'package:edu_ebook/bloc/related/ebook_related_bloc.dart';
import 'package:edu_ebook/bloc/shops/ebook_explores_bloc.dart';
import 'package:edu_ebook/bloc/tabs/ebook_tab_bloc.dart';
import 'package:edu_ebook/source/core/api_client.dart';
import 'package:edu_ebook/source/data_source/ebook_remote_data_source.dart';
import 'package:edu_ebook/source/repositories/ebook_repository.dart';
import 'package:edu_ebook/source/repositories/ebook_repository_impl.dart';
import 'package:edu_ebook/source/usecase/get_coming_soon.dart';
import 'package:edu_ebook/source/usecase/get_explores.dart';
import 'package:edu_ebook/source/usecase/get_popular.dart';
import 'package:edu_ebook/source/usecase/get_random.dart';
import 'package:edu_ebook/source/usecase/get_related.dart';
import 'package:edu_ebook/source/usecase/get_trending.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance.registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));
  getItInstance.registerLazySingleton<EbookRemoteDataSource>(() => EbookRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));
  getItInstance.registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));
  getItInstance.registerLazySingleton<GetRandom>(() => GetRandom(getItInstance()));
  getItInstance.registerLazySingleton<GetComingSoon>(() => GetComingSoon(getItInstance()));
  getItInstance.registerLazySingleton<EbookRepository>(() => EbookRepositoryImpl(getItInstance()));
  getItInstance.registerFactory(() => EbookExploresBloc(
    getExplores: GetExplores(getItInstance()),
  ));
  getItInstance.registerFactory(() => EbookRelatedBloc(
    getRelated: GetRelated(getItInstance()),
  ));
  getItInstance.registerFactory(() => EbookBackgroundBloc());
  getItInstance.registerFactory(() => EbookCarouselBloc(
    getTrending: getItInstance(),
    ebookBackgroundBloc: getItInstance(),
  ));
  getItInstance.registerFactory(() => EbookTabBloc(
    getPopular: GetPopular(getItInstance()),
    getPlayingLatest: GetRandom(getItInstance()),
    getComingSoon: GetComingSoon(getItInstance())
  ));
}
