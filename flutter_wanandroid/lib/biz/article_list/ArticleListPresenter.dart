import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/api/Api.dart';
import 'package:flutter_wanandroid/data/article/ArticleModel.dart';
import 'package:flutter_wanandroid/http/DioManager.dart';

import 'ArticleListContract.dart';

class ArticleListPresenter extends Presenter {
  View _view;
  CancelToken _mToken;

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
      print("liuhang${articleModel.data.datas.length}");

      _view.showArticle(articleModel.data.datas);
    }, (error) {}, _mToken);
  }
}
