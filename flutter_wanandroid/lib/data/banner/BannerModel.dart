import 'package:flutter_wanandroid/http/httpmodel/Response.dart';
import 'package:flutter_wanandroid/model/Banner/BannerBean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'BannerModel.g.dart';

@JsonSerializable()
class BannerModel extends Response<List<BannerBean>> {
  BannerModel(List<BannerBean> data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  toJson() => _$BannerModelToJson(this);
  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
}
