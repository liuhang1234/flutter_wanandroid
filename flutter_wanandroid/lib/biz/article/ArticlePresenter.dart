import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/api/Api.dart';

import 'ArticleContract.dart';

class ArticlePresenter extends Presenter {
  View _view;
  CancelToken _mToken;
  ArticlePresenter(this._view) {
    _view.setPresenter(this);
  }

  @override
  void getArticleList() async {
    _view.showArticle('99');
//    print("liuhang111");
//    HttpUtils.getWithCancel(Api.HOME_BANNER, _mToken, success: (value) {
//      print("success == " + value);
//      _view.showArticle('3333333333');
//      _view.showArticle(value);
//    }, failure: (value) {
//      print('error == ' + value);
//      _view.showArticle(value);
//    });
    var url = Api.HOME_BANNER;
    Dio _dio = Dio(_options);
    String result;
    try {
      var response = await _dio.get(url, cancelToken: _mToken); //2
      _view.showArticle(response.toString());
    } catch (exception) {
      result = exception.toString();
    }
    print("liuhang22");
  }

  static BaseOptions _options = BaseOptions(
      connectTimeout: 5000, receiveTimeout: 3000, baseUrl: Api.BASE_URL);

  @override
  void subscribe() {
//    _view.setPresenter(this);
    _mToken = CancelToken();
  }

  @override
  void unsubscribe() {
    _mToken.cancel();
  }
}
