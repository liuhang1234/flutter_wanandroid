import 'package:flutter_wanandroid/http/httpmodel/Response.dart';
import 'package:flutter_wanandroid/model/article/ArticleListBean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ArticleModel.g.dart';

@JsonSerializable()
class ArticleModel extends Response<ArticleListBean> {
  ArticleModel(ArticleListBean data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
  toJson() => _$ArticleModelToJson(this);
}
