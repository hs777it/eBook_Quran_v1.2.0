import 'package:equatable/equatable.dart';

abstract class EbookTabEvent extends Equatable{

  const EbookTabEvent();

  List<Object> get props => [];

}

class EbookTabChangedEvent extends EbookTabEvent{
  final int currentIndexTabs;

  const EbookTabChangedEvent({this.currentIndexTabs = 0});

  List<Object> get props => [currentIndexTabs];
}