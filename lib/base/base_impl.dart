
import 'package:flutter_shows/base/base_bean.dart';

abstract class BaseView {

  void showDialog();

  void hideDialog();

  void showSuccess(BaseBean response);

  void showErrorCode(int code, String msg);

  void showNetError(msg);

}

abstract class IPresenter {
  void initState();

  void didChangeDependencies();

  void didUpdateWidgets<W>(W oldWidget);

  void deactivate();

  void dispose();
}