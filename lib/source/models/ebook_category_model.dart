import 'package:edu_ebook/source/models/ebook_category_result.dart';

class EbookCategoryModel{
  List<EbookCategoryResult> category;

  EbookCategoryModel({this.category});

  EbookCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = new List<EbookCategoryResult>();
      json['category'].forEach((v) {
        category.add(new EbookCategoryResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    return data;
  }
}