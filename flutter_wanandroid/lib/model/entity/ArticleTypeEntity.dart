
import 'package:json_annotation/json_annotation.dart';

part 'ArticleTypeEntity.g.dart';

@JsonSerializable()
class ArticleTypeEntity{
  List<String> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  int visible;
  String url;

  ArticleTypeEntity(this.children, this.courseId, this.id, this.name,
      this.order, this.parentChapterId, this.visible, this.url);


  factory ArticleTypeEntity.fromJson(Map<String, dynamic> json) =>
      _$ArticleTypeEntityFromJson(json);

}