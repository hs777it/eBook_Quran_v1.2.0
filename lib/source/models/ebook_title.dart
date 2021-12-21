import 'package:edu_ebook/source/entities/ebook_title_entity.dart';

class EbookTitle extends EbookTitleEntity{
  final int slider;
  final String titleKeyword1;
  final String fieldKeyword1;
  final String titleKeyword2;
  final String fieldKeyword2;

  EbookTitle(
      {this.slider,
        this.titleKeyword1,
        this.fieldKeyword1,
        this.titleKeyword2,
        this.fieldKeyword2}): super(slider: slider,
      titleKeyword1: titleKeyword1,
      fieldKeyword1: fieldKeyword1);

  factory EbookTitle.fromJson(Map<String, dynamic> json) {
    return EbookTitle(
        slider : json['slider'],
        titleKeyword1 : json['title_keyword1'],
        fieldKeyword1 : json['field_keyword1'],
        titleKeyword2 : json['title_keyword2'],
        fieldKeyword2 : json['field_keyword2'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slider'] = this.slider;
    data['title_keyword1'] = this.titleKeyword1;
    data['field_keyword1'] = this.fieldKeyword1;
    data['title_keyword2'] = this.titleKeyword2;
    data['field_keyword2'] = this.fieldKeyword2;
    return data;
  }
}
