import 'package:flutter_wanandroid/base/BasePresenter.dart';
import 'package:flutter_wanandroid/base/BaseView.dart';
import 'package:flutter_wanandroid/model/project/ProjectClassifyBean.dart';

abstract class View extends BaseView<Presenter> {
  void showTab(List<ProjectClassifyBean> data);
}

abstract class Presenter extends BasePresenter{
  void getTab();
}