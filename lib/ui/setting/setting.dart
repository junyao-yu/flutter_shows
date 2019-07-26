import 'package:flutter/material.dart';
import 'package:flutter_shows/common/global.dart';
import 'package:package_info/package_info.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String version = '';

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform()
    .then((packageInfo){
      setState(() {
        version = packageInfo.version;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            _cellLayout('关于我们', version, true),
            Container(
              color: Color(0xFFE1E1E1),
              width: double.infinity,
              height: 0.5,
            ),
            _cellLayout('绑定微信', '未绑定', true),
            Container(
              color: Color(0xFFE1E1E1),
              width: double.infinity,
              height: 0.5,
            ),
            _cellLayout('绑定QQ', '未绑定', true),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 44,
              width: double.infinity,
              color: Colors.white,
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  SpUtil.remove(Constant.token);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: routes[LOGIN_ROUTE]),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text(
                  '退出登录',
                  style: TextStyle(color: Color(0xFFEA4C56), fontSize: 17),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _cellLayout(String left, String right, bool isArrow) {
    return Container(
      color: Colors.white,
      height: 65,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            child: Text(
              left,
              style: TextStyle(color: Color(0xFF232323), fontSize: 15),
            ),
            left: 28,
          ),
          Positioned(
            child: Text(
              right,
              style: TextStyle(color: Color(0xFF4F515F), fontSize: 14),
            ),
            right: 51,
          )
        ],
      ),
    );
  }
}
