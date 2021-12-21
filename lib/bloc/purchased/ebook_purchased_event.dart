import 'package:equatable/equatable.dart';

abstract class EbookPurchasedEvent extends Equatable{

  const EbookPurchasedEvent();

  List<Object> get props => [];

}

class EbookPurchasedEventList extends EbookPurchasedEvent{}