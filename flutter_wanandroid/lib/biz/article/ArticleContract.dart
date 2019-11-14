import 'package:flutter_wanandroid/base/BasePresenter.dart';
import 'package:flutter_wanandroid/base/BaseView.dart';
import 'package:flutter_wanandroid/model/Banner/BannerBean.dart';

abstract class View extends BaseView<Presenter> {
  void showArticle(List<BannerBean> data);
}

abstract class Presenter extends BasePresenter {
  void getArticleList();
}
