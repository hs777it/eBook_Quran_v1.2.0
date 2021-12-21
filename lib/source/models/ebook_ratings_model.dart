import 'ebook_ratings_model_result.dart';

class EbookRatingsModel{

  List<EbookRatingsModelResult> pdf;

  EbookRatingsModel({this.pdf});

  EbookRatingsModel.fromJson(Map<String, dynamic> json) {
    if (json['pdf'] != null) {
      pdf = new List<EbookRatingsModelResult>();
      json['pdf'].forEach((v) {
        pdf.add(new EbookRatingsModelResult.fromJson(v));
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