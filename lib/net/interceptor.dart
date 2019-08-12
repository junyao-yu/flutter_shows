
import 'package:dio/dio.dart';
import 'package:flutter_shows/common/global.dart';

class AddHeaderInterceptor extends Interceptor {

  @override
  onRequest(RequestOptions options) {

    options.headers =  {
      'Authorization': SpUtil.getString(Constant.token),
      'Content-type': 'application/json; charset=utf-8',
      'device-id': 'xxxxxpppppp',
      'app-platform': 'flutter',
      'app-version': '0.0.1'
    };
    return super.onRequest(options);
  }

}