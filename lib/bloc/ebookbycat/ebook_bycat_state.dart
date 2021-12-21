import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:equatable/equatable.dart';

abstract class EbookByCatState extends Equatable {
  const EbookByCatState();
  @override
  List<Object> get props => [];
}

class EbookExploresStateInitial extends EbookByCatState{

}

class EbookExploresStateLoading extends EbookByCatState{


}

class EbookExploresStateSuccess extends EbookByCatState {

  final List<EbookEntity> ebookModel;

  const EbookExploresStateSuccess({this.ebookModel});

  List<Object> get props => [ebookModel];

}

class EbookExploresStateError extends EbookByCatState{

  final String message;

  const EbookExploresStateError(this.message);

  @override
  List<Object> get props => [message];

}