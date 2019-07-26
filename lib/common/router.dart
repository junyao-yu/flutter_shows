import 'package:flutter/material.dart';
import 'package:flutter_shows/ui/login/vcode.dart';
import 'package:flutter_shows/ui/setting/invite.dart';
import 'package:flutter_shows/ui/setting/setting.dart';
import 'package:flutter_shows/ui/setup/guide.dart';
import 'package:flutter_shows/ui/home/home.dart';
import 'package:flutter_shows/ui/login/login.dart';
import 'package:flutter_shows/ui/web/web_view.dart';

const ROOT_ROUTE = '/';
const GUIDE_ROUTE = '/routeGuide';
const LOGIN_ROUTE = '/routeLogin';
const VCODE_ROUTE = '/routeVcode';
const HOME_ROUTE = '/routeHome';
const WEBVIEW_ROUTE = '/routeWebview';
const SETTING_ROUTE = '/routeSetting';
const INVITE_ROUTE = '/routeInvite';

final routes = {
  ROOT_ROUTE: (context, {arguments}) => GuidePage(),
  GUIDE_ROUTE: (context, {arguments}) => GuidePage(),
  LOGIN_ROUTE: (context, {arguments}) => LoginPage(),
  VCODE_ROUTE: (context, {arguments}) => VcodePage(arguments: arguments),
  HOME_ROUTE: (context, {arguments}) => HomePage(),
  WEBVIEW_ROUTE: (context, {arguments}) => WebViewpage(arguments: arguments,),
  SETTING_ROUTE: (context, {arguments}) => SettingPage(),
  INVITE_ROUTE: (context, {arguments}) => InvitePage()
};

RouteFactory onGenerateRoute = (settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  } else {
    return MaterialPageRoute(builder: routes[HOME_ROUTE]);
  }
};
