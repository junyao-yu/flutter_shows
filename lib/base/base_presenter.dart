import 'package:dio/dio.dart';
import 'package:flutter_shows/base/base_impl.dart';
import 'package:flutter_shows/common/global.dart';

import 'base_impl.dart';

class BasePresenter<V extends BaseView> extends IPresenter {
  V view;

  CancelToken _cancelToken;

  BasePresenter() {
    _cancelToken = CancelToken();
  }

  invoke<T>(String url,
      {Map<String, dynamic> params = const {},
      String method = GET,
      bool isShowDialog = true}) async {
    NetWrapper.init().requestTemp<T>(url, _cancelToken, onErrorCode: (code, msg) {
      view?.showErrorCode(code, msg);
    }, onError: (msg) {
      view?.showNetError(msg);
    }, onSuccess: (baseBean) {
      view?.showSuccess(baseBean);
    });
  }

  @override
  void deactivate() {}

  @override
  void didChangeDependencies() {}

  @override
  void didUpdateWidgets<W>(W oldWidget) {}

  @override
  void dispose() {
    //页面销毁的时候取消网络请求
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }

  @override
  void initState() {}
}
