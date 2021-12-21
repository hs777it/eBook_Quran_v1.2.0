import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:equatable/equatable.dart';

abstract class EbookBackgroundEvent extends Equatable{

  const EbookBackgroundEvent();

  List<Object> get props => [];

}

class EbookBackgroundChangeEvent extends EbookBackgroundEvent{
  final EbookEntity ebook;
  const EbookBackgroundChangeEvent(this.ebook);
  List<Object> get props => [ebook];
}