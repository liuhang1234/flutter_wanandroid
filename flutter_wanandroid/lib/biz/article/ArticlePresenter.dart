import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/api/Api.dart';
import 'package:flutter_wanandroid/http/DioManager.dart';

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
      _view.showArticle(value);
    }, (error) {
      _view.showArticle('error');
    }, _mToken);
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
