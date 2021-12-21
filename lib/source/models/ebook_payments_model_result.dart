import 'ebook_payments_model.dart';

class EbookPaymentsModelResult {
  List<EbookPaymentsModel> pdf;

  EbookPaymentsModelResult({this.pdf});

  EbookPaymentsModelResult.fromJson(Map<String, dynamic> json) {
    if (json['pdf'] != null) {
      pdf = new List<EbookPaymentsModel>();
      json['pdf'].forEach((v) {
        pdf.add(new EbookPaymentsModel.fromJson(v));
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