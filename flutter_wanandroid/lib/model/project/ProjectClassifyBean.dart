import 'package:json_annotation/json_annotation.dart';

part 'ProjectClassifyBean.g.dart';
// 项目分类
@JsonSerializable()
class ProjectClassifyBean {
  List<String> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  int visible;
  String url;

  ProjectClassifyBean(this.children, this.courseId, this.id, this.name,
      this.order, this.parentChapterId, this.visible, this.url);

  factory ProjectClassifyBean.fromJson(Map<String, dynamic> json) => _$ProjectClassifyBeanFromJson(json);
}
