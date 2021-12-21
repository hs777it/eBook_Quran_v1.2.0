import 'package:edu_ebook/source/entities/ebook_cc.dart';

class EbookCCModel extends EbookCC {

  String cardNumber;
  List<String> expiryDate;
  String cardName;
  String cvvCode;
  String idGoogleCc;

  EbookCCModel({this.cardNumber, this.expiryDate, this.cardName, this.cvvCode, this.idGoogleCc});

  EbookCCModel.fromJson(Map<String, dynamic> json) {
    cardNumber = json['card_number'];
    expiryDate = json['expiry_date'].cast<String>();
    cardName = json['card_name'];
    cvvCode = json['cvv_code'];
    idGoogleCc = json['id_google_cc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_number'] = this.cardNumber;
    data['expiry_date'] = this.expiryDate;
    data['card_name'] = this.cardName;
    data['cvv_code'] = this.cvvCode;
    data['id_google_cc'] = this.idGoogleCc;
    return data;
  }
}