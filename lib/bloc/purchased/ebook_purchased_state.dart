import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:equatable/equatable.dart';

abstract class EbookPurchasedState extends Equatable {
  const EbookPurchasedState();
  @override
  List<Object> get props => [];
}

class EbookPurchasedStateInitial extends EbookPurchasedState{

}

class EbookPurchasedStateLoading extends EbookPurchasedState{


}

class EbookPurchasedStateSuccess extends EbookPurchasedState {

  final List<EbookEntity> ebookPurchased;

  const EbookPurchasedStateSuccess({this.ebookPurchased});

  List<Object> get props => [ebookPurchased];

}

class EbookPurchasedStateError extends EbookPurchasedState{

  final String message;

  const EbookPurchasedStateError(this.message);

  @override
  List<Object> get props => [message];

}