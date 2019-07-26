import 'package:flutter_shows/net/net.dart';

import 'common.dart';

class CommonRequest {
  static requestUserInfo(
          {Map<String, dynamic> params = const {}, String method = GET}) =>
      NetWrapper.init().request(Url.userInfo, params: params, method: method);

  static requestCaptcha(
          {Map<String, dynamic> params = const {}, String method = GET}) =>
      NetWrapper.init().request(Url.captcha, params: params, method: method);

  static requestLogin(
      {Map<String, dynamic> params = const {}, String method = GET}) =>
      NetWrapper.init().request(Url.login, params: params, method: method);

  static requestBanner(
      {Map<String, dynamic> params = const {}, String method = GET}) =>
      NetWrapper.init().request(Url.banner, params: params, method: method);

  static requestJobList(
      {Map<String, dynamic> params = const {}, String method = GET}) =>
      NetWrapper.init().request(Url.jobList, params: params, method: method);

  static requestRecommendInfo(
      {Map<String, dynamic> params = const {}, String method = GET}) =>
      NetWrapper.init().request(Url.recommendRecord, params: params, method: method);

  static requestMyInviter(
      {Map<String, dynamic> params = const {}, String method = GET}) =>
      NetWrapper.init().request(Url.myInviter, params: params, method: method);
}
