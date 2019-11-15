import 'package:json_annotation/json_annotation.dart';

import 'ProjectTagBean.dart';

part 'ProjectClassifyDetailBean.g.dart';

@JsonSerializable()
class ProjectClassifyDetailBean {
  String apkLink;
  String author;
  int chapterId;
  String chapterName;
  bool collect;
  int courseId;
  String desc;
  String envelopePic;
  bool fresh;
  int id;
  String link;
  String niceDate;
  String origin;
  String projectLink;
  String prefix;
  int publishTime;
  int selfVisible;
  String shareData;
  String shareUser;
  int superChapterId;
  String superChapterName;
  List<ProjectTagBean> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

  ProjectClassifyDetailBean(
      this.apkLink,
      this.author,
      this.chapterId,
      this.chapterName,
      this.collect,
      this.courseId,
      this.desc,
      this.envelopePic,
      this.fresh,
      this.id,
      this.link,
      this.niceDate,
      this.origin,
      this.projectLink,
      this.prefix,
      this.publishTime,
      this.selfVisible,
      this.shareData,
      this.shareUser,
      this.superChapterId,
      this.superChapterName,
      this.tags,
      this.title,
      this.type,
      this.userId,
      this.visible,
      this.zan);

  factory ProjectClassifyDetailBean.fromJson(Map<String, dynamic> json) =>
      _$ProjectClassifyDetailBeanFromJson(json);
}
