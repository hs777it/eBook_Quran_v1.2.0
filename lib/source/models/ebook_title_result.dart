import 'ebook_title.dart';

class EbookTitleResult {
  List<EbookTitle> pdf;

  EbookTitleResult({this.pdf});

  EbookTitleResult.fromJson(Map<String, dynamic> json) {
    if (json['pdf'] != null) {
      pdf = new List<EbookTitle>();
      json['pdf'].forEach((v) {
        pdf.add(new EbookTitle.fromJson(v));
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