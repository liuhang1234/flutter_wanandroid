import 'package:flutter_wanandroid/http/httpmodel/Response.dart';
import 'package:flutter_wanandroid/model/project/ProjectClassifyListBean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ProjectModel.g.dart';

@JsonSerializable()
class ProjectModel extends Response<ProjectClassifyListBean> {
  ProjectModel(ProjectClassifyListBean data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);
  toJson() => _$ProjectModelToJson(this);
}
