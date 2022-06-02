import 'package:json_annotation/json_annotation.dart';

part 'upload_receipt_model.g.dart';

@JsonSerializable()
class UploadReceiptModel {

  Map<String, String> receipt;
  List? tags = [];

  UploadReceiptModel({ required this.receipt, this.tags });

  factory UploadReceiptModel.fromJson(Map<String, dynamic> json) => _$UploadReceiptModelFromJson(json);

  Map<String, dynamic> toJson() => _$UploadReceiptModelToJson(this);
}

