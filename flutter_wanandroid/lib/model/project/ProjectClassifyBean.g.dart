// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectClassifyBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectClassifyBean _$ProjectClassifyBeanFromJson(Map<String, dynamic> json) {
  return ProjectClassifyBean(
    (json['children'] as List)?.map((e) => e as String)?.toList(),
    json['courseId'] as int,
    json['id'] as int,
    json['name'] as String,
    json['order'] as int,
    json['parentChapterId'] as int,
    json['visible'] as int,
    json['url'] as String,
  );
}

Map<String, dynamic> _$ProjectClassifyBeanToJson(
        ProjectClassifyBean instance) =>
    <String, dynamic>{
      'children': instance.children,
      'courseId': instance.courseId,
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'parentChapterId': instance.parentChapterId,
      'visible': instance.visible,
      'url': instance.url,
    };
