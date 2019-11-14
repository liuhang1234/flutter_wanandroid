import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/api/Api.dart';
import 'package:flutter_wanandroid/data/banner/BannerModel.dart';
import 'package:flutter_wanandroid/http/DioManager.dart';
import 'package:flutter_wanandroid/model/Banner/BannerBean.dart';

import 'ArticleContract.dart';

class ArticlePresenter extends Presenter {
  View _view;
  CancelToken _mToken;
  ArticlePresenter(this._view) {
    _view.setPresenter(this);
  }

  @override
  void getArticleList() async {
    DioManager.getInstance().get(Api.HOME_BANNER, (value) {
      BannerModel bannerModel = BannerModel.fromJson(json.decode(value));
      if (bannerModel.errorCode == 0) {
        List<BannerBean> list = bannerModel.data;
        _view.showArticle(list);
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
