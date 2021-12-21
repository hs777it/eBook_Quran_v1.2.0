import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:equatable/equatable.dart';

abstract class EbookRandomState extends Equatable {
  const EbookRandomState();
  @override
  List<Object> get props => [];
}

class EbookRandomStateInitial extends EbookRandomState{

}

class EbookRandomStateLoading extends EbookRandomState{


}

class EbookRandomStateSuccess extends EbookRandomState {

  final List<EbookEntity> ebookPurchased;

  const EbookRandomStateSuccess({this.ebookPurchased});

  List<Object> get props => [ebookPurchased];

}

class EbookRandomStateError extends EbookRandomState{

  final String message;

  const EbookRandomStateError(this.message);

  @override
  List<Object> get props => [message];

}