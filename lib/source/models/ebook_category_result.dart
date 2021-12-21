import 'package:edu_ebook/source/entities/ebook_category_entities.dart';

class EbookCategoryResult extends EbookCategoryEntities{
  int catId;
  String photoCat;
  String name;
  int status;

  EbookCategoryResult({this.catId, this.photoCat, this.name, this.status});

  EbookCategoryResult.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    photoCat = json['photo_cat'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.catId;
    data['photo_cat'] = this.photoCat;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}