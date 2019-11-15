// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectClassifyListBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectClassifyListBean _$ProjectClassifyListBeanFromJson(
    Map<String, dynamic> json) {
  return ProjectClassifyListBean(
    json['curpage'] as int,
    (json['datas'] as List)
        ?.map((e) => e == null
            ? null
            : ProjectClassifyDetailBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['offset'] as int,
    json['over'] as bool,
    json['pageCount'] as int,
    json['size'] as int,
    json['total'] as int,
  );
}

Map<String, dynamic> _$ProjectClassifyListBeanToJson(
        ProjectClassifyListBean instance) =>
    <String, dynamic>{
      'curpage': instance.curpage,
      'datas': instance.datas,
      'offset': instance.offset,
      'over': instance.over,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'total': instance.total,
    };
