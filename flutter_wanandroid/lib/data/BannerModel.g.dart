// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BannerModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) {
  return BannerModel(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : BannerBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
