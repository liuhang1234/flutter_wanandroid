import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/api/Api.dart';
import 'package:flutter_wanandroid/data/article/ArticleModel.dart';
import 'package:flutter_wanandroid/http/DioManager.dart';
import 'package:flutter_wanandroid/model/article/ArticleDetailBean.dart';

import 'ArticleListContract.dart';

class ArticleListPresenter extends Presenter {
  View _view;
  CancelToken _mToken;
  List<ArticleDetailBean> _mDatas = List<ArticleDetailBean>();

  ArticleListPresenter(this._view) {
    _view.setPresenter(this);
  }

  @override
  void subscribe() {
    _mToken = CancelToken();
  }

  @override
  void unsubscribe() {
    _mToken.cancel();
  }

  @override
  void getArticleList(int index) {
    DioManager.getInstance().get("${Api.HOME_LIST}$index/json", (value) {
      ArticleModel articleModel = ArticleModel.fromJson(json.decode(value));
      if (index == 0) {
        _mDatas.clear();
      }
      _mDatas.addAll(articleModel.data.datas);
      _view.showArticle(_mDatas);
    }, (error) {}, _mToken);
  }
}
