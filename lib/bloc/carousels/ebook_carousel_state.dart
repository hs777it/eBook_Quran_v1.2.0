import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:equatable/equatable.dart';

abstract class EbookCarouselState extends Equatable{
  const EbookCarouselState();

  List<Object> get props => [];

}

class EbookCarouselInitial extends EbookCarouselState{

}

class EbookCarouselError extends EbookCarouselState{

}

class EbookCarouselLoaded extends EbookCarouselState{
  final List<EbookEntity> ebook;
  final int defaultIndex;

  const EbookCarouselLoaded({this.ebook, this.defaultIndex = 0});

  List<Object> get props => [ebook, defaultIndex];
}

