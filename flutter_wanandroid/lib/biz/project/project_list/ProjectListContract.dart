

import 'package:flutter_wanandroid/base/BasePresenter.dart';
import 'package:flutter_wanandroid/base/BaseView.dart';
import 'package:flutter_wanandroid/model/project/ProjectClassifyDetailBean.dart';

abstract class View extends BaseView<Presenter> {
  void showProject(List<ProjectClassifyDetailBean> data);
}

abstract class Presenter extends BasePresenter {
  void getProjectList(int index,int id);
}