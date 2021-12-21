import 'package:edu_ebook/source/entities/ebook_ratings.dart';

class EbookRatingsModelResult extends EbookRatings{
  String name;
  String photo;
  String dates;
  String comment;
  String rating;
  String idUser;

  EbookRatingsModelResult({this.name, this.photo, this.dates, this.comment, this.rating, this.idUser});

  EbookRatingsModelResult.fromJson(Map<String, dynamic> json) {
    name = (json['name'] as String).toString();
    photo = json['photo'];
    dates = json['dates'];
    comment = json['comment'];
    rating = json['rating'];
    idUser = json['id_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['dates'] = this.dates;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    data['id_user'] = this.idUser;
    return data;
  }
}