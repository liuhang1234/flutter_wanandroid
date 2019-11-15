import 'package:json_annotation/json_annotation.dart';

part 'ProjectTagBean.g.dart';

@JsonSerializable()
class ProjectTagBean {
  String name;
  String url;

  ProjectTagBean(this.name, this.url);

  factory ProjectTagBean.fromJson(Map<String, dynamic> json) =>
      _$ProjectTagBeanFromJson(json);
}
