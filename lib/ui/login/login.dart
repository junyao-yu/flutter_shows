import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shows/model/CaptchaResponse.dart';
import 'package:flutter_shows/common/global.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _checkBox = true;
  var _loginEnable = false;
  var _inputValue = "";

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()..onTap = _handlerClick;
  }

  _loginClick() {
    if (_loginEnable) {
      return () {
        _requestCaptcha();
      };
    } else {
      return null;
    }
  }

  void _requestCaptcha() {
    Map<String, dynamic> param = {
      'mobile': _inputValue,
      'type': 1,
      'is_voice': 0
    };
    CommonRequest.requestCaptcha(params: param, method: POST)
    .then((result){
      CaptchaResponse captchaResponse = CaptchaResponse.fromJson(result);
      if (captchaResponse.code == 0) {
        Navigator.pushNamed(context, VCODE_ROUTE, arguments: _inputValue);
      } else {
        _key.currentState.showSnackBar(new SnackBar(
          content: new Text(captchaResponse.msg),
        ));
      }
    });
  }

  void _handlerClick() {
    _key.currentState.showSnackBar(new SnackBar(
      content: new Text('协议点击'),
    ));
  }

  void _wechatLogin() {
    _key.currentState.showSnackBar(new SnackBar(
      content: new Text('微信登录'),
    ));
  }

  void _qqLogin() {
    _key.currentState.showSnackBar(new SnackBar(
      content: new Text('QQ登录'),
    ));
  }

  void refreshLoginBtnStatus() {
    setState(() {
      if (_inputValue.length == 11 && _checkBox) {
        _loginEnable = true;
      } else {
        _loginEnable = false;
      }
    });
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      resizeToAvoidBottomPadding: false, //软键盘弹出，布局不会往上顶
      body: Padding(
        padding:
            EdgeInsets.only(left: 20.0, top: 80.0, right: 20.0, bottom: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '请输入手机号码',
              style: TextStyle(
                  color: Color.fromRGBO(74, 74, 74, 1),
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500),
            ),
            Padding(
                padding: EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: Text(
                  '为了方便进行联系，请输入您的常用的手机号码',
                  style: TextStyle(
                      color: Color.fromRGBO(167, 167, 167, 1), fontSize: 14.0),
                )),
            Padding(
              padding: EdgeInsets.only(
                  left: 0.0, top: 63.0, right: 0.0, bottom: 0.0),
              child: TextField(
                keyboardType: TextInputType.number,
                cursorColor: Color.fromRGBO(234, 76, 86, 1),
                autofocus: true,
                decoration: InputDecoration(
                    hintText: '请输入您手机号码', border: InputBorder.none),
                onChanged: (value) {
                  _inputValue = value;
                  refreshLoginBtnStatus();
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromRGBO(234, 234, 234, 1), width: 1))),
            ),
            Padding(
              padding: EdgeInsets.only(left: 0, top: 5, right: 0, bottom: 0),
              child: Text('未注册的用户将自动注册',
                  style: TextStyle(
                      color: Color.fromRGBO(167, 167, 167, 1), fontSize: 14.0)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 0, top: 40, right: 0, bottom: 0),
              child: MaterialButton(
                onPressed: _loginClick(),
                textColor: Colors.white,
                minWidth: double.infinity,
                height: 40,
                color: Color.fromRGBO(234, 76, 86, 1),
                disabledColor: Color.fromRGBO(167, 167, 167, 1),
                splashColor: Colors.transparent,
                child: Text(
                  '下一步',
                  style: TextStyle(fontSize: 17.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                      value: _checkBox,
                      onChanged: (value) {
                        setState(() {
                          _checkBox = value;
                        });
                        refreshLoginBtnStatus();
                      },
                      activeColor: Color.fromRGBO(234, 76, 86, 1),
                      checkColor: Colors.white),
                  RichText(
                      text: TextSpan(
                          text: '我已阅读并同意遵守',
                          style: TextStyle(
                              color: Color.fromRGBO(74, 74, 74, 1),
                              fontSize: 11.0),
                          children: <TextSpan>[
                        TextSpan(
                            text: '《用户注册须知》',
                            style: TextStyle(
                                color: Color.fromRGBO(234, 76, 86, 1),
                                fontSize: 11.0),
                            recognizer: _tapGestureRecognizer)
                      ]))
                ],
              ),
            ),
            Expanded(
              child: Container(
                  padding:
                      EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 39),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            //类似于weight
                            child: Container(
                                height: 1,
                                color: Color.fromRGBO(234, 234, 234, 1)),
                            flex: 1,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 5, top: 0, right: 5, bottom: 0),
                            child: Text(
                              '第三方快捷登录',
                              style: TextStyle(
                                  color: Color.fromRGBO(167, 167, 167, 1),
                                  fontSize: 14.0),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: Color.fromRGBO(234, 234, 234, 1),
                            ),
                            flex: 1,
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: _wechatLogin,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 0, top: 31, right: 0, bottom: 6),
                                    child: Image.asset(Utils.wapperResourcePath(
                                        'but_weixin_login.png'))),
                              ),
                              Text('微信',
                                  style: TextStyle(
                                      color: Color.fromRGBO(74, 74, 74, 1),
                                      fontSize: 12))
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: <Widget>[
                              GestureDetector(
                                  onTap: _qqLogin,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 0,
                                          top: 31,
                                          right: 0,
                                          bottom: 6),
                                      child: Image.asset(
                                          Utils.wapperResourcePath(
                                              'but_qq_login.png')))),
                              Text('QQ',
                                  style: TextStyle(
                                      color: Color.fromRGBO(74, 74, 74, 1),
                                      fontSize: 12))
                            ],
                          ))
                        ],
                      )
                    ],
                  )),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}
