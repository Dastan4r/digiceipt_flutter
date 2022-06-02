// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_receipt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadReceiptModel _$UploadReceiptModelFromJson(Map<String, dynamic> json) =>
    UploadReceiptModel(
      receipt: Map<String, String>.from(json['receipt'] as Map),
      tags: json['tags'] as List<dynamic>?,
    );

Map<String, dynamic> _$UploadReceiptModelToJson(UploadReceiptModel instance) =>
    <String, dynamic>{
      'receipt': instance.receipt,
      'tags': instance.tags,
    };
