import 'package:flutter_wanandroid/base/BasePresenter.dart';
import 'package:flutter_wanandroid/base/BaseView.dart';

abstract class View extends BaseView<Presenter> {
  void showArticle(String text);
}

abstract class Presenter extends BasePresenter {
  void getArticleList();
}
