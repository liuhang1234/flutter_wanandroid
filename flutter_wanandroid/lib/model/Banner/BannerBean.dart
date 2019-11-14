import 'package:json_annotation/json_annotation.dart';

part 'Banner.g.dart';

@JsonSerializable()
class BannerBean {
  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  BannerBean(this.desc, this.id, this.imagePath, this.isVisible, this.order,
      this.title, this.type, this.url);

  factory BannerBean.fromJson(Map<String, dynamic> json) =>
      _$BannerFromJson(json);

  Map<String, dynamic> toJson() => _$BannerToJson(this);
}
