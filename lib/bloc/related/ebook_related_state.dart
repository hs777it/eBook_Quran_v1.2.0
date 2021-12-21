import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:equatable/equatable.dart';

abstract class EbookRelatedState extends Equatable{

  const EbookRelatedState();
  List<Object> get props => [];

}

class EbookRelatedStateLoading extends EbookRelatedState{

}

class EbookRelatedStateSuccess extends EbookRelatedState{

  final List<EbookEntity> ebook;
  const EbookRelatedStateSuccess({this.ebook});

  List<Object> get props => [ebook];

}

class EbookRelatedStateError extends EbookRelatedState{

  final String message;
  EbookRelatedStateError(this.message);

  List<Object> get props => [message];
}