import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:equatable/equatable.dart';

abstract class EbookExploresState extends Equatable {
  const EbookExploresState();
  @override
  List<Object> get props => [];
}

class EbookExploresStateInitial extends EbookExploresState{

}

class EbookExploresStateLoading extends EbookExploresState{


}

class EbookExploresStateSuccess extends EbookExploresState {

  final List<EbookEntity> ebookModel;

  const EbookExploresStateSuccess({this.ebookModel});

  List<Object> get props => [ebookModel];

}

class EbookExploresStateError extends EbookExploresState{

  final String message;

  const EbookExploresStateError(this.message);

  @override
  List<Object> get props => [message];

}