import 'package:json_annotation/json_annotation.dart';

part 'ArticleTagBean.g.dart';

@JsonSerializable()
class ArticleTagBean {
  String name;
  String url;

  ArticleTagBean(this.name, this.url);

  factory ArticleTagBean.fromJson(Map<String, dynamic> json) =>
      _$ArticleTagBeanFromJson(json);
}
