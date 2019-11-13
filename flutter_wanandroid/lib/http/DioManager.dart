import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/api/Api.dart';
import 'package:flutter_wanandroid/common/GlobalConfig.dart';

class DioManager {
  static DioManager _instance;
  Dio dio = new Dio();

  static DioManager getInstance() {
    if (_instance == null) {
      _instance = DioManager();
    }
    return _instance;
  }

  DioManager() {
    dio.options = _options;
    dio.interceptors
        .add(LogInterceptor(responseBody: GlobalConfig.isDebug)); //是否开启请求日志
//    dio.interceptors.add(CookieManager(CookieJar()));
  }

  get(String url, Function successCallback, Function failCallBack,
      CancelToken token) {
    _requstHttp(url, successCallback, failCallBack, token);
  }

  static BaseOptions _options = BaseOptions(
      connectTimeout: 5000, receiveTimeout: 3000, baseUrl: Api.BASE_URL);

  void _requstHttp(String url, Function successCallback, Function failCallBack,
      CancelToken token) async {
    Response response;
    try {
      response = await dio.get(url, cancelToken: token);

      successCallback(response.toString());
    } catch (exception) {
      failCallBack(response);
    }
  }
}
