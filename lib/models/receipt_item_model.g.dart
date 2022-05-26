// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptModel _$ReceiptModelFromJson(Map<String, dynamic> json) => ReceiptModel(
      json['_id'] as String,
      json['title'] as String?,
      json['slug'] as String,
      json['created_date'] as String,
      ThumbnailModel.fromJson(json['thumbnails'] as Map<String, dynamic>),
      ReceiptDetailModel.fromJson(json['receipt'] as Map<String, dynamic>),
      json['tags'] as List<dynamic>?,
      json['additional'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ReceiptModelToJson(ReceiptModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'created_date': instance.date,
      'thumbnails': instance.thumbnails,
      'receipt': instance.receipt,
      'tags': instance.tags,
      'additional': instance.additional,
    };

ThumbnailModel _$ThumbnailModelFromJson(Map<String, dynamic> json) =>
    ThumbnailModel(
      json['download_url'] as String?,
    );

Map<String, dynamic> _$ThumbnailModelToJson(ThumbnailModel instance) =>
    <String, dynamic>{
      'download_url': instance.download_url,
    };

ReceiptDetailModel _$ReceiptDetailModelFromJson(Map<String, dynamic> json) =>
    ReceiptDetailModel(
      json['download_url'] as String?,
    );

Map<String, dynamic> _$ReceiptDetailModelToJson(ReceiptDetailModel instance) =>
    <String, dynamic>{
      'download_url': instance.download_url,
    };
