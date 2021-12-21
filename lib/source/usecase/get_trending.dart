import 'package:dartz/dartz.dart';
import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:edu_ebook/source/entities/errors.dart';
import 'package:edu_ebook/source/entities/no_params.dart';
import 'package:edu_ebook/source/repositories/ebook_repository.dart';
import 'package:edu_ebook/source/usecase/usecase.dart';

class GetTrending extends UseCase<List<EbookEntity>, NoParams>{
  final EbookRepository repository;

  GetTrending(this.repository);

  Future<Either<Errors, List<EbookEntity>>> call(NoParams noParams) async {
    return await repository.getTrending();
  }
}