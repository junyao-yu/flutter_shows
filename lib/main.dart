import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'common/router.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppPage createState() => _MyAppPage();
}

class _MyAppPage extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '熟仁直聘',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: ROOT_ROUTE,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
