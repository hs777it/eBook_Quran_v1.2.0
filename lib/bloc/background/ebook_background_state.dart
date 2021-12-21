import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:equatable/equatable.dart';

abstract class EbookBackgroundState extends Equatable {
  const EbookBackgroundState();

  List<Object> get props => [];

}

class EbookBackgroundInitial extends EbookBackgroundState{

}

class EbookBackgroundChanged extends EbookBackgroundState{
  final EbookEntity ebook;
  const EbookBackgroundChanged(this.ebook);
  List<Object> get props => [ebook];
}