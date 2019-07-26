import 'package:flutter/material.dart';
import 'package:flutter_shows/model/LoginResponse.dart';
import 'package:flutter_shows/views/CustomPasswordField.dart';
import 'package:flutter_shows/common/global.dart';

class VcodePage extends StatefulWidget {

  final arguments;
  VcodePage({this.arguments});

  @override
  _VcodePageState createState() => _VcodePageState(arguments);
}

class _VcodePageState extends State<VcodePage> {
  final arguments;
  _VcodePageState(this.arguments);

  String mobile = "";
  int _counter = 60;
  String vcode = "";
  bool hasFocus = true;

  TimerUtil _timerUtil;

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    mobile = arguments;
    SpUtil.getInstance();
    _timerUtil = TimerUtil(mTotalTime: 60 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      setState(() {
        _counter = tick ~/ 1000;
      });
    });
    _timerUtil.startCountDown();
  }

  String countDownText() {
    if (_counter == 0) {
      return '重新获取';
    } else {
      return '${_counter}s';
    }
  }

  _requestLogin() {

    Map<String, dynamic> param = {
      'mobile': mobile,
      'login_type': 1,
      'client_type': 2,
      'captcha': vcode
    };

    CommonRequest.requestLogin(params: param, method: POST)
    .then((result){
      LoginResponse loginResponse = LoginResponse.fromJson(result);
      if (loginResponse.code == 0) {
        if (loginResponse.data != null) {
          print('response--->${loginResponse.data.token}');
          SpUtil.putString(Constant.token, loginResponse.data.token);

          Navigator.pushNamed(context, HOME_ROUTE);
        } else {
          _key.currentState.showSnackBar(new SnackBar(
            content: new Text('没有传token'),
          ));
        }
      } else {
        _key.currentState.showSnackBar(new SnackBar(
          content: new Text(loginResponse.msg),
        ));
      }
    });

  }

  @override
  void dispose() {
    if (_timerUtil != null) {
      _timerUtil.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Padding(
        padding:
            EdgeInsets.only(left: 20.0, top: 80.0, right: 20.0, bottom: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '请输入您的验证码',
              style: TextStyle(
                  color: Color.fromRGBO(74, 74, 74, 1),
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500),
            ),
            Padding(
                padding: EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: Text(
                  '验证码已发送到您的手机',
                  style: TextStyle(
                      color: Color.fromRGBO(167, 167, 167, 1), fontSize: 14.0),
                )),
            Padding(
                padding: EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: Text(
                  mobile,
                  style: TextStyle(
                      color: Color.fromRGBO(167, 167, 167, 1), fontSize: 14.0),
                )),
            Padding(
              padding: EdgeInsets.only(
                  left: 0.0, top: 48.0, right: 0.0, bottom: 0.0),
              child: Row(
                children: <Widget>[
                  Text(
                    '4位数字验证码',
                    style: TextStyle(
                        color: Color.fromRGBO(74, 74, 74, 1), fontSize: 12.0),
                  ),
                  Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            onTap: () {
                              if (_counter == 0) {
                                _timerUtil.setTotalTime(60 * 1000);
                                _timerUtil.startCountDown();
                              }
                            },
                            child: Text(
                              countDownText(),
                              style: TextStyle(
                                  color: Color.fromRGBO(234, 76, 86, 1),
                                  fontSize: 12.0),
                            )),
                      ),
                      flex: 1)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 0.0, top: 16.0, right: 0.0, bottom: 0.0),
              child: CustomPasswordField(vcode),
            ),
            Container(
              width: double.infinity,
              height: 140,
              child: TextField(
                keyboardType: TextInputType.number,
                autofocus: hasFocus,
                enableInteractiveSelection: false,
                style: TextStyle(color: Colors.transparent),
                showCursor: false,
                decoration:
                    InputDecoration(hintText: '', border: InputBorder.none),
                onChanged: (value) {
                  if (value.length < 5) {
                    setState(() {
                      vcode = value;
                    });
                    if (value.length == 4) {
                      _requestLogin();
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
