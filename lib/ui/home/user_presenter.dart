
import 'package:flutter_shows/base/base_presenter.dart';
import 'package:flutter_shows/common/common.dart';
import 'package:flutter_shows/model/temp_login.dart';

class UserPresenter extends BasePresenter {

  requestUserInfo<T>() {
    invoke<T>(Url.userInfo);
  }

}