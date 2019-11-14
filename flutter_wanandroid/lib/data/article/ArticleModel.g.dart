// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ArticleModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) {
  return ArticleModel(
    json['data'] == null
        ? null
        : ArticleListBean.fromJson(json['data'] as Map<String, dynamic>),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
