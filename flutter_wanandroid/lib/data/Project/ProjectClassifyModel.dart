import 'package:flutter_wanandroid/http/httpmodel/Response.dart';
import 'package:flutter_wanandroid/model/project/ProjectClassifyBean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ProjectClassifyModel.g.dart';

@JsonSerializable()
class ProjectClassifyModel extends Response<List<ProjectClassifyBean>> {
  ProjectClassifyModel(
      List<ProjectClassifyBean> data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory ProjectClassifyModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectClassifyModelFromJson(json);

  toJson() => _$ProjectClassifyModelToJson(this);
}
