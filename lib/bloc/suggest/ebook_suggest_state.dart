import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:equatable/equatable.dart';

abstract class EbookSuggestState extends Equatable{

  const EbookSuggestState();
  List<Object> get props => [];

}

class EbookSuggestStateInitial extends EbookSuggestState{

}

class EbookSuggestStateLoading extends EbookSuggestState{

}

class EbookSuggestStateSuccess extends EbookSuggestState{

  final List<EbookEntity> ebookModel;
  const EbookSuggestStateSuccess({this.ebookModel});

  List<Object> get props => [ebookModel];

}

class EbookSuggestStateError extends EbookSuggestState{
  final String message;
  EbookSuggestStateError({this.message});
  List<Object> get props => [message];
}