import 'package:edu_ebook/source/entities/ebook_ratings.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class EbookRatingsState extends Equatable{

  const EbookRatingsState();
  List<Object> get props => [];

}

class EbookRatingsStateInitial extends EbookRatingsState{}

class EbookRatingsStateLoading extends EbookRatingsState{}

class EbookRatingStateSuccess extends EbookRatingsState{

  final List<EbookRatings> ratings;

  const EbookRatingStateSuccess({this.ratings});

  List<Object> get props => [ratings];

}

class EbookRatingsStateErrors extends EbookRatingsState{
  final String message;

  const EbookRatingsStateErrors({@required this.message});

  List<Object> get props => [message];
}