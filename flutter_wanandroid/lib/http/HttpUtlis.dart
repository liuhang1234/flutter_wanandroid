import 'package:dio/dio.dart';

class HttpUtils {
  static Dio _dio;

  static get(String url, {options, Function success, Function failure}) async {
    Dio dio = buildDio();
    try {
      Response response = await dio.get(url, options: options);
      success(response.data);
    } catch (exception) {
      failure(exception);
    }
  }

  static getWithCancel(String url, CancelToken cancelToken,
      {options, Function success, Function failure}) async {
    Dio dio = buildDio();
    try {
      Response response =
          await dio.get(url, options: options, cancelToken: cancelToken);
      success(response.data);
    } catch (exception) {
      failure(exception);
    }
  }

  static Future<String> onlyGet(String url) async {
    Dio dio = buildDio();
    Response response = await dio.get(url);
    String s = response.toString();
    return s;
  }

  static Dio buildDio() {
    if (_dio == null) {
      _dio = new Dio(_options);
    }
    return _dio;
  }

  static BaseOptions _options = BaseOptions(
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
}
