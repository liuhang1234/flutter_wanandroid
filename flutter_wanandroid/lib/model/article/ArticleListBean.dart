import 'package:json_annotation/json_annotation.dart';

import 'ArticleDetailBean.dart';

part 'ArticleListBean.g.dart';

@JsonSerializable()
class ArticleListBean {
  int curpage;
  List<ArticleDetailBean> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  ArticleListBean(this.curpage, this.datas, this.offset, this.over,
      this.pageCount, this.size, this.total);

  factory ArticleListBean.fromJson(Map<String, dynamic> json) =>
      _$ArticleListBeanFromJson(json);
}
