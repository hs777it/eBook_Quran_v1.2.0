import 'ebook_model.dart';

class EbookResultModel {
  List<EbookModel> pdf;

  EbookResultModel({this.pdf});

  EbookResultModel.fromJson(Map<String, dynamic> json) {
    if (json['pdf'] != null) {
      pdf = new List<EbookModel>();
      json['pdf'].forEach((v) {
        pdf.add(new EbookModel.fromJson(v));
        var ss = EbookModel.fromJson(v);
        print('title: ${ss.title} and photo: ${ss.photo}');
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pdf != null) {
      data['pdf'] = this.pdf.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
