
import 'package:equatable/equatable.dart';
import 'package:flutter_wanandroid/model/entity/ProjectEntity.dart';

abstract class WXArticleEvent extends Equatable{
  WXArticleEvent([List props = const []]) : super(props);
}

class LoadWXArticle extends WXArticleEvent{
  int id;
  String searchKey;

  LoadWXArticle(this.id, {this.searchKey}) : super([id, searchKey]);

  @override
  String toString() {
    return 'LoadWXArticle{id: $id, searchKey: $searchKey}';
  }
}

class LoadMoreWXArticleDatas extends WXArticleEvent{
  List<ProjectEntity> originDatas;
  int id;
  int page;
  String searchKey;

  LoadMoreWXArticleDatas({this.originDatas, this.id, this.page, this.searchKey})
      : super([originDatas, id, page, searchKey]);
  @override
  String toString() {
    return 'LoadMoreWXArticleDatas{originDatas: $originDatas, id: $id, page: $page, searchKey: $searchKey}';
  }
}

///收藏、取消收藏
class CollectWXArticle extends WXArticleEvent {
  int id;
  bool collect;

  CollectWXArticle(this.id, this.collect) : super([id, collect]);

  @override
  String toString() {
    return 'CollectWXArticle{id: $id, collect: $collect}';
  }
}