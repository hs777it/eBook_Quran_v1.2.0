import 'package:edu_ebook/source/entities/ebook_global_rating_entity.dart';

class EbookGlobalRating extends EbookGlobalRatingEntity{
  final int total;
  final double average;

  EbookGlobalRating({this.total, this.average}) : super(total: total, average: average);

  factory EbookGlobalRating.fromJson(Map<String, dynamic> json) {
    return EbookGlobalRating(
        total : json['total'],
        average : (json['average'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['average'] = this.average;
    return data;
  }
}
