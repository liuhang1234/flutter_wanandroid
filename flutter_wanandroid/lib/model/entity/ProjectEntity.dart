
import 'package:flutter_wanandroid/model/entity/Tag.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ProjectEntity.g.dart';

@JsonSerializable()
class ProjectEntity{
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
  int publishTime;
  int superChapterId;
  String superChapterName;
  List<Tag> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

  ProjectEntity(this.apkLink, this.author, this.chapterId, this.chapterName,
      this.collect, this.courseId, this.desc, this.envelopePic, this.fresh,
      this.id, this.link, this.niceDate, this.origin, this.projectLink,
      this.publishTime, this.superChapterId, this.superChapterName, this.tags,
      this.title, this.type, this.userId, this.visible, this.zan);

  factory ProjectEntity.fromJson(Map<String, dynamic> json) =>
      _$ProjectEntityFromJson(json);

}

