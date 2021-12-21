import 'package:edu_ebook/source/entities/ebook_entity.dart';

class EbookModel extends EbookEntity{
  final int id;
  final String title;
  final String photo;
  final String description;
  final int catId;
  final int statusNews;
  final String pdf;
  final String date;
  final String authorName;
  final String publisherName;
  final int pages;
  final String language;
  final int price;
  final double rating;

  EbookModel(
      {this.id,
        this.title,
        this.photo,
        this.description,
        this.catId,
        this.statusNews,
        this.pdf,
        this.date,
        this.authorName,
        this.publisherName,
        this.pages,
        this.language,
        this.price,
        this.rating}) : super(
    id: id, photo: photo, title: title, date: date
  );

  factory EbookModel.fromJson(Map<String, dynamic> json) {
    return EbookModel(
        id : json['id'],
        title : json['title'],
        photo : json['photo'],
        description : json['description'],
        catId : json['cat_id'],
        statusNews : json['status_news'],
        pdf : json['pdf'],
        date : json['date'],
        authorName : json['author_name'],
        publisherName : json['publisher_name'],
        pages : json['pages'],
        language : json['language'],
        price : json['price'],
        rating : (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['photo'] = this.photo;
    data['description'] = this.description;
    data['cat_id'] = this.catId;
    data['status_news'] = this.statusNews;
    data['pdf'] = this.pdf;
    data['date'] = this.date;
    data['author_name'] = this.authorName;
    data['publisher_name'] = this.publisherName;
    data['pages'] = this.pages;
    data['language'] = this.language;
    data['price'] = this.price;
    data['rating'] = this.rating;
    return data;
  }
}