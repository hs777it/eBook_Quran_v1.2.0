import 'package:dartz/dartz.dart';
import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:edu_ebook/source/entities/ebook_ratings.dart';
import 'package:edu_ebook/source/entities/errors.dart';

abstract class EbookRepository{
  Future<Either<Errors, List<EbookEntity>>> getTrending();
  Future<Either<Errors, List<EbookEntity>>> getPopular();
  Future<Either<Errors, List<EbookEntity>>> getRandom();
  Future<Either<Errors, List<EbookEntity>>> getComingSoon();
  Future<Either<Errors, List<EbookEntity>>> getExplores();
  Future<Either<Errors, List<EbookEntity>>> getRelated();
  Future<Either<Errors, List<EbookRatings>>> getRatings();
}