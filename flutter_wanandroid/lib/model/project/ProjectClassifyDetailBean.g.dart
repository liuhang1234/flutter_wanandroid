// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectClassifyDetailBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectClassifyDetailBean _$ProjectClassifyDetailBeanFromJson(
    Map<String, dynamic> json) {
  return ProjectClassifyDetailBean(
    json['apkLink'] as String,
    json['author'] as String,
    json['chapterId'] as int,
    json['chapterName'] as String,
    json['collect'] as bool,
    json['courseId'] as int,
    json['desc'] as String,
    json['envelopePic'] as String,
    json['fresh'] as bool,
    json['id'] as int,
    json['link'] as String,
    json['niceDate'] as String,
    json['origin'] as String,
    json['projectLink'] as String,
    json['prefix'] as String,
    json['publishTime'] as int,
    json['selfVisible'] as int,
    json['shareData'] as String,
    json['shareUser'] as String,
    json['superChapterId'] as int,
    json['superChapterName'] as String,
    (json['tags'] as List)
        ?.map((e) => e == null
            ? null
            : ProjectTagBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['title'] as String,
    json['type'] as int,
    json['userId'] as int,
    json['visible'] as int,
    json['zan'] as int,
  );
}

Map<String, dynamic> _$ProjectClassifyDetailBeanToJson(
        ProjectClassifyDetailBean instance) =>
    <String, dynamic>{
      'apkLink': instance.apkLink,
      'author': instance.author,
      'chapterId': instance.chapterId,
      'chapterName': instance.chapterName,
      'collect': instance.collect,
      'courseId': instance.courseId,
      'desc': instance.desc,
      'envelopePic': instance.envelopePic,
      'fresh': instance.fresh,
      'id': instance.id,
      'link': instance.link,
      'niceDate': instance.niceDate,
      'origin': instance.origin,
      'projectLink': instance.projectLink,
      'prefix': instance.prefix,
      'publishTime': instance.publishTime,
      'selfVisible': instance.selfVisible,
      'shareData': instance.shareData,
      'shareUser': instance.shareUser,
      'superChapterId': instance.superChapterId,
      'superChapterName': instance.superChapterName,
      'tags': instance.tags,
      'title': instance.title,
      'type': instance.type,
      'userId': instance.userId,
      'visible': instance.visible,
      'zan': instance.zan,
    };
