import 'package:flutter/material.dart';
import 'package:flutter_shows/base/base_bean.dart';
import 'package:flutter_shows/base/base_presenter.dart';
import 'package:flutter_shows/base/base_impl.dart';

abstract class BasePageSate<T extends StatefulWidget, P extends BasePresenter> extends State<T> implements BaseView {

  P mPresenter;

  P createPresenter();

  BasePageSate() {
    mPresenter = createPresenter();
    mPresenter.view = this;
  }



  @override
  void initState() {
    super.initState();
    mPresenter?.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
    mPresenter?.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    mPresenter?.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mPresenter?.didChangeDependencies();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    mPresenter?.didUpdateWidgets(oldWidget);
  }


  @override
  void showDialog() {
  }

  @override
  void hideDialog() {
  }

  @override
  showSuccess(BaseBean response) {

  }

  @override
  void showErrorCode(int code, String msg) {
  }

  @override
  void showNetError(msg) {
  }
}