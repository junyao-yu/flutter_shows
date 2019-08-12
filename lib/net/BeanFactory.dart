
import 'package:flutter_shows/base/base_bean.dart';
import 'package:flutter_shows/model/temp_login.dart';

class BeanFactory {
  static wrapperBean<T>(json) {
    switch (T.toString()) {
      case 'TempLogin':
        return TempLogin.fromJson(json);
    }
  }
}