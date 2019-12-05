import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/api/Api.dart';
import 'package:flutter_wanandroid/biz/project/ProjectContract.dart';
import 'package:flutter_wanandroid/data/Project/ProjectClassifyModel.dart';
import 'package:flutter_wanandroid/http/DioManager.dart';

class ProjectPresenter extends Presenter {
  View _view;
  CancelToken _mToken;

  ProjectPresenter(this._view) {
    _view.setPresenter(this);
  }

  @override
  void getTab() {
    DioManager.getInstance()
        .get(Api.PROJECT_TREE, (value) {
      ProjectClassifyModel classifyModel = ProjectClassifyModel.fromJson(jsonDecode(value));
      if(classifyModel.errorCode == 0) {
        _view.showTab(classifyModel.data);
      }
    }, (error) {}, _mToken);
  }

  @override
  void subscribe() {
    _mToken = CancelToken();
  }

  @override
  void unsubscribe() {
    _mToken.cancel();
  }
}
