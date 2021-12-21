import 'ebook_gr.dart';

class EbookGlobalRatingResult {
  List<EbookGlobalRating> pdf;

  EbookGlobalRatingResult({this.pdf});

  EbookGlobalRatingResult.fromJson(Map<String, dynamic> json) {
    if (json['pdf'] != null) {
      pdf = new List<EbookGlobalRating>();
      json['pdf'].forEach((v) {
        pdf.add(new EbookGlobalRating.fromJson(v));
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