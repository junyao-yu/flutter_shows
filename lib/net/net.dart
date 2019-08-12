import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_shows/base/base_bean.dart';
import 'package:flutter_shows/common/global.dart';
import 'package:flutter_shows/model/UserInfo.dart';
import 'package:flutter_shows/model/temp_login.dart';
import 'package:flutter_shows/net/BeanFactory.dart';
import 'package:flutter_shows/net/interceptor.dart';

const HOST = 'http://onsite-api.ci.dev.lanxinka.com';
const H5_HOST = 'http://onsite-h5.ci.dev.lanxinka.com';
const ACTIVITY_HOST = 'http://activity-h5.ci.dev.lanxinka.com';

const SUCCESS_CODE = 0;
const CONNECT_TIMEOUT = 10000;
const REVEICE_TIMEOUT = 10000;
const POST = 'POST';
const GET = 'GET';

class NetWrapper {
  static Dio dio;

  NetWrapper.init() {
    if (dio == null) {
      dio = Dio()
        ..options.baseUrl = HOST
        ..options.connectTimeout = CONNECT_TIMEOUT
        ..options.receiveTimeout = REVEICE_TIMEOUT;

      //TODO  添加拦截事件
      dio.interceptors.add(AddHeaderInterceptor());
    }
  }

  request(String url,
      {Map<String, dynamic> params = const {}, String method = GET}) async {
    dynamic result;
    try {
      Response response = await dio.request(url,
          data: params, options: Options(method: method));

      if (response?.statusCode == 200) {
        print('response--->${response.toString()}');
        result = response.data;
      }
    } catch (e) {}
    return result;
  }

  requestTemp<T>(String url, CancelToken cancelToken,
      {Map<String, dynamic> params = const {},
      String method = GET,
      Function(BaseBean baseBean) onSuccess,
      Function(int code, String msg) onErrorCode,
      Function(String msg) onError}) async {


    try {
      Response response =
      await dio.request(url, data: params, options: Options(method: method), cancelToken: cancelToken);
      if (response?.statusCode == 200) {
        print('response--->${response.toString()}');


        var temp = BeanFactory.wrapperBean<T>(response.data);
        if (temp == null) {
          onSuccess(BaseBean());
        } else {
          if (temp.code == 0) {
            onSuccess(temp);
          } else {
            onErrorCode(temp.code, temp.msg);
          }
        }

      } else {
        onError('网络请求出错');
      }
    } catch (e) {
      onError('解析失败');
    }
  }

//  Map<String, dynamic> _getHeader() {
//    return {
//      'Authorization': SpUtil.getString(Constant.token),
//      'Content-type': 'application/json; charset=utf-8',
//      'device-id': 'xxxxxpppppp',
//      'app-platform': 'flutter',
//      'app-version': '0.0.1'
//    };
//  }
}
