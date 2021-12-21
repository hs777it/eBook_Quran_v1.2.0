import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:equatable/equatable.dart';

abstract class EbookTabState extends Equatable{
  final int currentIndexTabs;
  const EbookTabState({this.currentIndexTabs});

  List<Object> get props => [currentIndexTabs];

}

class EbookTabInitial extends EbookTabState{

}

class EbookTabChanged extends EbookTabState{
  final List<EbookEntity> ebook;
  const EbookTabChanged({int currentIndexTabs, this.ebook});
  List<Object> get props => [currentIndexTabs, ebook];
}

class EbookTabErrorLoaded extends EbookTabState{
  EbookTabErrorLoaded({int currentIndexTabs});
}