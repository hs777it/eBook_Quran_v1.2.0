import 'package:edu_ebook/source/entities/ebook_payments.dart';

class EbookPaymentsModel extends EbookPayments{
  String idProduct;
  String idUser;

  EbookPaymentsModel({this.idProduct, this.idUser});

  EbookPaymentsModel.fromJson(Map<String, dynamic> json) {
    idProduct = json['id_product'];
    idUser = json['id_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_product'] = this.idProduct;
    data['id_user'] = this.idUser;
    return data;
  }
}