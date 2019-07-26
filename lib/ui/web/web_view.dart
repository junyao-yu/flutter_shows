import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_shows/common/global.dart';

class WebViewpage extends StatefulWidget {

  final arguments;

  WebViewpage({this.arguments});

  @override
  _WebViewPageState createState() => _WebViewPageState(arguments);

}

class _WebViewPageState extends State<WebViewpage> {

  final arguments;

  _WebViewPageState(this.arguments);


  String url = "";
  String title = "";

  @override
  void initState() {
    super.initState();
    if (arguments != null) {
      url = arguments['url'];
      title = arguments['title'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      url: _getUrl(),
    );
  }

  _getUrl() {
    if (url.contains('?')) {
      return url + '&${SpUtil.getString(Constant.token)}';
    } else {
      return url + '?${SpUtil.getString(Constant.token)}';
    }
  }

}