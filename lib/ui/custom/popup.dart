
import 'package:flutter/material.dart';

class Popup extends PopupRoute {

  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  Popup({@required this.child});

  @override
  Color get barrierColor => Color(0x584B4B4B);

  @override
  bool get barrierDismissible => null;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;

}