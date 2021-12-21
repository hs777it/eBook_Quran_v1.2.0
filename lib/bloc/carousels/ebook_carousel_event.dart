import 'package:equatable/equatable.dart';

abstract class EbookCarouselEvent extends Equatable{
  const EbookCarouselEvent();
}

class CarouselLoadEvent extends EbookCarouselEvent{
  final int defaultIndex;

  const CarouselLoadEvent({this.defaultIndex = 0});

  List<Object> get props => null;
}