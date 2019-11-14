import 'package:flutter_wanandroid/base/BasePresenter.dart';
import 'package:flutter_wanandroid/base/BaseView.dart';
import 'package:flutter_wanandroid/model/article/ArticleDetailBean.dart';

abstract class View extends BaseView<Presenter> {
  void showArticle(List<ArticleDetailBean> data);
}

abstract class Presenter extends BasePresenter {
  void getArticleList(int index);
}
