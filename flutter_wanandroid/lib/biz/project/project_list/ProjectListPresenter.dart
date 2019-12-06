

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/api/Api.dart';
import 'package:flutter_wanandroid/biz/project/project_list/ProjectListContract.dart';
import 'package:flutter_wanandroid/data/Project/ProjectModel.dart';
import 'package:flutter_wanandroid/http/DioManager.dart';
import 'package:flutter_wanandroid/model/project/ProjectClassifyDetailBean.dart';

class ProjectListPresenter extends Presenter{
  View _view;
  CancelToken _mToken;
  List<ProjectClassifyDetailBean> _mDatas = List<ProjectClassifyDetailBean>();

  ProjectListPresenter(this._view){
    _view.setPresenter(this);
  }

  @override
  void getProjectList(int index,int id) {
    DioManager.getInstance().get("${Api.PROJECT_LIST}$index/json?cid=$id", (value){
      ProjectModel projectModel = ProjectModel.fromJson(jsonDecode(value));
      if (index == 1) {
        _mDatas.clear();
      }
      _mDatas.addAll(projectModel.data.datas);
      _view.showProject(_mDatas);

    }, (error){}, _mToken);
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