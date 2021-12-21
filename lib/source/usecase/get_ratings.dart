import 'package:dartz/dartz.dart';
import 'package:edu_ebook/source/entities/ebook_ratings.dart';
import 'package:edu_ebook/source/entities/errors.dart';
import 'package:edu_ebook/source/entities/no_params.dart';
import 'package:edu_ebook/source/repositories/ebook_repository.dart';
import 'package:edu_ebook/source/usecase/usecase.dart';

class GetRatings extends UseCase<List<EbookRatings>, NoParams>{

  final EbookRepository related;

  GetRatings(this.related);

  Future<Either<Errors, List<EbookRatings>>> call(NoParams noParams) async {
    return await related.getRatings();
  }
}