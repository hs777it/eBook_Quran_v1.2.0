import 'package:dartz/dartz.dart';
import 'package:edu_ebook/source/entities/errors.dart';

abstract class UseCase<Type, Params>{
  Future<Either<Errors, Type>> call(Params params);
}