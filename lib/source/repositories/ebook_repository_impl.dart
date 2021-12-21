import 'package:dartz/dartz.dart';
import 'package:edu_ebook/source/data_source/ebook_remote_data_source.dart';
import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:edu_ebook/source/entities/ebook_ratings.dart';
import 'package:edu_ebook/source/entities/errors.dart';
import 'package:edu_ebook/source/repositories/ebook_repository.dart';

class EbookRepositoryImpl extends EbookRepository{

  final EbookRemoteDataSource dataSource;

  EbookRepositoryImpl(this.dataSource);

  @override
  Future<Either<Errors, List<EbookEntity>>> getTrending() async{
    try{
      final ebook = await dataSource.getTrending();
      return Right(ebook);
    } on Exception {
      return Left(Errors('There is problem Get Trending'));
    }
  }

  @override
  Future<Either<Errors, List<EbookEntity>>> getComingSoon() async{
    try{
      final ebook = await dataSource.getComingSoon();
      return Right(ebook);
    } on Exception {
      return Left(Errors('There is problem Get Coming Soon'));
    }
  }

  @override
  Future<Either<Errors, List<EbookEntity>>> getRandom() async{
    try{
      final ebook = await dataSource.getRandom();
      return Right(ebook);
    } on Exception {
      return Left(Errors('There is problem Get Playing Latest'));
    }
  }

  @override
  Future<Either<Errors, List<EbookEntity>>> getPopular() async{
    try{
      final ebook = await dataSource.getPopular();
      return Right(ebook);
    } on Exception {
      return Left(Errors('There is problem Get Popular'));
    }
  }

  @override
  Future<Either<Errors, List<EbookEntity>>> getExplores() async{
    try{
      final ebook = await dataSource.getEbookExplores();
      return Right(ebook);
    } on Exception {
      return Left(Errors('There is problem Get Explores'));
    }
  }

  @override
  Future<Either<Errors, List<EbookEntity>>> getRelated() async{
    try{
      final ebook = await dataSource.getRelated();
      return Right(ebook);
    } on Exception {
      return Left(Errors('There is problem Get Explores'));
    }
  }

  @override
  Future<Either<Errors, List<EbookRatings>>> getRatings() async{
    try{
      final ebook = await dataSource.getRatings();
      return Right(ebook);
    } on Exception {
      return Left(Errors('There is problem Get Explores'));
    }
  }
}