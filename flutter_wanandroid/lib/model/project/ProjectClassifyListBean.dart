import 'package:json_annotation/json_annotation.dart';

import 'ProjectClassifyDetailBean.dart';

part 'ProjectClassifyListBean.g.dart';

@JsonSerializable()
class ProjectClassifyListBean {
  int curpage;
  List<ProjectClassifyDetailBean> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  ProjectClassifyListBean(this.curpage, this.datas, this.offset, this.over,
      this.pageCount, this.size, this.total);
  factory ProjectClassifyListBean.fromJson(Map<String, dynamic> json) =>
      _$ProjectClassifyListBeanFromJson(json);
}
