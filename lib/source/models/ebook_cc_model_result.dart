import 'package:edu_ebook/source/models/ebook_cc_model.dart';

class EbookCCModelResult {
  List<EbookCCModel> pdf;

  EbookCCModelResult({this.pdf});

  EbookCCModelResult.fromJson(Map<String, dynamic> json) {
    if (json['pdf'] != null) {
      pdf = new List<EbookCCModel>();
      json['pdf'].forEach((v) {
        pdf.add(new EbookCCModel.fromJson(v));
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