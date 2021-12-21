import 'package:equatable/equatable.dart';

abstract class EbookSuggestEvent extends Equatable{

  const EbookSuggestEvent();
  List<Object> get props => [];

}

class EbookSuggestEventList extends EbookSuggestEvent{}