import 'package:edu_ebook/source/entities/ebook_cc.dart';
import 'package:equatable/equatable.dart';

abstract class EbookCreditCardState extends Equatable{

  const EbookCreditCardState();
  List<Object> get props => [];

}

class EbookCreditCardStateInitial extends EbookCreditCardState{}

class EbookCreditCardStateLoading extends EbookCreditCardState{}

class EbookCreditCardStateSuccess extends EbookCreditCardState{

  final List<EbookCC> ccList;

  const EbookCreditCardStateSuccess({this.ccList});

  List<Object> get props => [ccList];

}

class EbookCreditCardStateError extends EbookCreditCardState{

  final String message;

  const EbookCreditCardStateError({this.message});

  List<Object> get props => [message];

}