import 'package:json_annotation/json_annotation.dart';

part 'receipt_item_model.g.dart';

@JsonSerializable()
class ReceiptModel {
  @JsonKey(name: '_id')
  final String id;
  final String? title;
  final String slug;
  @JsonKey(name: 'created_date')
  final String date;
  final ThumbnailModel thumbnails;
  final ReceiptDetailModel receipt;
  final List? tags;
  final Map? additional;

  ReceiptModel(this.id, this.title, this.slug, this.date, this.thumbnails, this.receipt, this.tags, this.additional);

  factory ReceiptModel.fromJson(Map<String, dynamic> json) => _$ReceiptModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptModelToJson(this);
}

@JsonSerializable()
class ThumbnailModel {
  final String? download_url;

  ThumbnailModel(this.download_url);

  factory ThumbnailModel.fromJson(Map<String, dynamic> json) => _$ThumbnailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailModelToJson(this);
}

@JsonSerializable()
class ReceiptDetailModel {
  final String? download_url;

  ReceiptDetailModel(this.download_url);

  factory ReceiptDetailModel.fromJson(Map<String, dynamic> json) => _$ReceiptDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptDetailModelToJson(this);
}
