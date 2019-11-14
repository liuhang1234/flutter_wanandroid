import 'package:flutter_wanandroid/base/BasePresenter.dart';
import 'package:flutter_wanandroid/base/BaseView.dart';

abstract class View extends BaseView<Presenter> {
  void showArticle(List<String> data);
}

abstract class Presenter extends BasePresenter {
  void getArticleList();
}
