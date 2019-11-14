import 'package:json_annotation/json_annotation.dart';

import 'ArticleTagBean.dart';

part 'ArticleDetailBean.g.dart';

@JsonSerializable()
class ArticleDetailBean {
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
  List<ArticleTagBean> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

  ArticleDetailBean(
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
      this.publishTime,
      this.superChapterId,
      this.superChapterName,
      this.tags,
      this.title,
      this.type,
      this.userId,
      this.visible,
      this.zan);

  factory ArticleDetailBean.fromJson(Map<String, dynamic> json) =>
      _$ArticleDetailBeanFromJson(json);
}
