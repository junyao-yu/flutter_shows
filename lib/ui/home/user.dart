import 'package:flutter/material.dart';
import 'package:flutter_shows/base/base_bean.dart';
import 'package:flutter_shows/common/global.dart';
import 'package:flutter_shows/model/temp_login.dart';
import 'package:flutter_shows/base/base_state.dart';
import 'package:flutter_shows/ui/home/user_presenter.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends BasePageSate<UserPage, UserPresenter> {
  double screenWidth;
  double statusHeight;
  String headUrl = "";
  String name = "姓名未填写";
  int wordAge = 0;
  int nextLevelConfition = 0;
  int percentage = 0;
  int levelStatus = 0;
  String nextLevelName = '';

  @override
  void initState() {
    super.initState();
    _requestUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    statusHeight = MediaQuery.of(context).padding.top; //状态栏的高度
    screenWidth = ScreenUtil.getScreenW(context);
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: statusHeight - 3),
                  child: Image.asset(
                    Utils.wapperResourcePath('bg_me.png'), //这个图边距有点问题
                    height: 135,
                    width: double.infinity,
                  )),
              Card(
                margin: EdgeInsets.only(
                    left: 22, top: 25 + statusHeight, right: 22),
                child: Container(
                    width: double.infinity,
                    height: 156,
                    child: Stack(
                      fit: StackFit.loose,
                      children: <Widget>[
                        Positioned(
                            child: FadeInImage.assetNetwork(
                              placeholder:
                                  Utils.wapperResourcePath('default_tx.png'),
                              image: headUrl,
                              width: 47,
                              height: 47,
                            ),
                            left: 15,
                            top: 15),
                        Positioned(
                          child: GestureDetector(
                            onTap: _cellClick(11),
                            child: Image.asset(
                                Utils.wapperResourcePath('but_bianji.png')),
                          ),
                          right: 17,
                          top: 33,
                        ),
                        Positioned(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _wrapperName(),
                                style: TextStyle(
                                    color: Color(0xFF05122C),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              Image.asset(
                                Utils.wapperResourcePath('icon_dz.png'),
                                width: 64,
                                height: 21,
                              )
                            ],
                          ),
                          left: 74,
                          top: 20,
                        ),
                        Positioned(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('我的工龄：$wordAge天',
                                    style: TextStyle(
                                        color: Color(0xFF05122C),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 11, left: 0, right: 0),
                                  child: SizedBox(
                                    height: 6,
                                    width: screenWidth - 74,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6.0)),
                                      child: LinearProgressIndicator(
                                        value: 0.5,
                                        backgroundColor: Color(0xFFF3F3F3),
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Color(0xFFEA4E56)),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            left: 15,
                            top: 81),
                        Positioned(
                          child: Text(_wapperLevelExplain(),
                              style: TextStyle(
                                  color: Color(0xFF898989), fontSize: 9)),
                          top: 130,
                          right: 17,
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(top: 42),
          child: Row(
            children: <Widget>[
              Expanded(
                child: _cellWidget(
                    '我的简历', Utils.wapperResourcePath('but_me_jianli.png'), 0),
                flex: 1,
              ),
              Expanded(
                child: _cellWidget('我的面试官',
                    Utils.wapperResourcePath('but_me_mianshiguan.png'), 1),
                flex: 1,
              ),
              Expanded(
                child: _cellWidget(
                    '我的钱包', Utils.wapperResourcePath('but_me_qianbao.png'), 2),
                flex: 1,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(top: 29),
          child: Row(
            children: <Widget>[
              Expanded(
                child: _cellWidget(
                    '面试记录', Utils.wapperResourcePath('but_me_jilv.png'), 3),
                flex: 1,
              ),
              Expanded(
                child: _cellWidget(
                    '面试报告', Utils.wapperResourcePath('but_me_tuijian.png'), 4),
                flex: 1,
              ),
              Expanded(
                child: _cellWidget(
                    '我的邀请', Utils.wapperResourcePath('but_me_tuijian.png'), 5),
                flex: 1,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(top: 29),
          child: Row(
            children: <Widget>[
              Expanded(
                child: _cellWidget('渠道邀请码',
                    Utils.wapperResourcePath('but_me_yaoqingma.png'), 6),
                flex: 1,
              ),
              Expanded(
                child: _cellWidget('生活助理',
                    Utils.wapperResourcePath('but_me_shenghuozhuli.png'), 7),
                flex: 1,
              ),
              Expanded(
                child: _cellWidget(
                    '我要合作', Utils.wapperResourcePath('but_me_hezuo.png'), 8),
                flex: 1,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(top: 29),
          child: Row(
            children: <Widget>[
              Expanded(
                child: _cellWidget(
                    '联系客服', Utils.wapperResourcePath('but_me_kefu.png'), 9),
                flex: 1,
              ),
              Expanded(
                child: _cellWidget(
                    '设置', Utils.wapperResourcePath('but_me_shezhi.png'), 10),
                flex: 1,
              ),
              Expanded(
                child: SizedBox(),
                flex: 1,
              )
            ],
          ),
        )
      ],
    ));
  }

  _cellClick(int type) {
    switch (type) {
      case 0:
        {
//          Navigator.push(context, PageRouteBuilder(
//            opaque: false,
//            barrierColor: Color(0x584B4B4B),
//            pageBuilder: (BuildContext context, _, __) {
//              return Padding(padding: EdgeInsets.only(top: 240), child: Container(
//                height: 100,
//                width: double.infinity,
//                color: Colors.red,
//              ),);
//            },
//            transitionsBuilder: (context, animation, secondaryAnimation, child) {
//              return SlideTransition(
//                position: new Tween<Offset>(
//                  begin: const Offset(0.0, -1.0),
//                  end: const Offset(0.0, 0.0),
//                ).animate(animation),
//                child: child,
//              );
//            },
//          ));
        }
        break;
      case 1:
        {}
        break;
      case 2:
        {}
        break;
      case 3:
        {}
        break;
      case 4:
        {}
        break;
      case 5:
        {
          Navigator.pushNamed(context, INVITE_ROUTE);
        }
        break;
      case 6:
        {}
        break;
      case 7:
        {}
        break;
      case 8:
        {}
        break;
      case 9:
        {}
        break;
      case 10:
        {
          Navigator.pushNamed(context, SETTING_ROUTE);
        }
        break;
      case 11:
        {
//          Navigator.push(
//            context,
//            Popup(
//              child: PopupPage(
//                  child: _buildExit(),
//                  left: 64,
//                  top: 22,
//                  onClick: () {
//                    print("exit");
//                  }),
//            ),
//          );
        }
        break;
    }
  }

//  Widget _buildExit() {
//    return Container(
//      width: 91,
//      height: 36,
//      child: Stack(
//        children: <Widget>[
//          Image.asset(
//            "assets/images/but_me_shezhi.png",
//            fit: BoxFit.fill,
//          ),
//          Center(
//            child: Text(
//              '退出',
//              style: TextStyle(fontSize: 14, color: Colors.black),
//            ),
//          ),
//        ],
//      ),
//    );
//  }

  void _requestUserInfo() {
//    NetWrapper.init().request<UserInfo>(Url.userInfo).then((userInfo) {
//         setState(() {
//           headUrl = userInfo.header_url;
//           name = userInfo.name;
//           wordAge = userInfo.work_age;
//           nextLevelConfition = userInfo.next_level_condition;
//           percentage = userInfo.percentage;
//           levelStatus = userInfo.level_status;
//           nextLevelName = userInfo.next_level_name;
//         });
//    });

//    NetWrapper.init().requestTemp<TempLogin>(Url.userInfo).then((userInfo) {
//        if (userInfo is TempLogin) {
//                   setState(() {
//           headUrl = userInfo.data.header_url;
//           name = userInfo.data.name;
//           wordAge = userInfo.data.work_age;
//           nextLevelConfition = userInfo.data.next_level_condition;
//           percentage = userInfo.data.percentage;
//           levelStatus = userInfo.data.level_status;
//           nextLevelName = userInfo.data.next_level_name;
//         });
//        }
//    });

    mPresenter?.requestUserInfo<TempLogin>();

    // CommonRequest.requestUserInfo().then((result) {
    //   UserInfo userInfo = UserInfo.fromJson(result);
    //   setState(() {
    //     headUrl = userInfo.data.header_url;
    //     name = userInfo.data.name;
    //     wordAge = userInfo.data.work_age;
    //     nextLevelConfition = userInfo.data.next_level_condition;
    //     percentage = userInfo.data.percentage;
    //     levelStatus = userInfo.data.level_status;
    //     nextLevelName = userInfo.data.next_level_name;
    //   });
    // });
  }

  @override
  showSuccess(BaseBean response) {
    if (response is TempLogin) {
      setState(() {
        headUrl = response.data.header_url;
        name = response.data.name;
        wordAge = response.data.work_age;
        nextLevelConfition = response.data.next_level_condition;
        percentage = response.data.percentage;
        levelStatus = response.data.level_status;
        nextLevelName = response.data.next_level_name;
      });
    }
  }

  String _wrapperName() {
    if (name != null && name.isNotEmpty) {
      return name;
    } else {
      return '姓名未填写';
    }
  }

  String _wapperLevelExplain() {
    switch (levelStatus) {
      case 0:
        {
          return '继续在职${nextLevelConfition - wordAge}天就能升级为$nextLevelName';
        }
        break;
      case 1:
        {
          return '入职即可成为青铜会员，享受更多权益';
        }
        break;
      case 2:
        {
          return '恭喜您成为皇冠会员';
        }
        break;
    }
    return '入职即可成为青铜会员，享受更多权益';
  }

  Widget _cellWidget(String title, String path, int type) {
    return GestureDetector(
      onTap: () {
        _cellClick(type);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            path,
            width: 30,
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              title,
              style: TextStyle(color: Color(0xFF202327), fontSize: 14),
            ),
          )
        ],
      ),
    );
  }

  @override
  UserPresenter createPresenter() {
    return UserPresenter();
  }
}

//class PopupPage extends StatelessWidget {
//  final Widget child;
//  final Function onClick; //点击child事件
//  final double left; //距离左边位置
//  final double top; //距离上面位置
//
//  PopupPage({
//    @required this.child,
//    this.onClick,
//    this.left,
//    this.top,
//  });
//
//  @override
//  Widget build(BuildContext context) {
//    return Material(
//      color: Colors.transparent,
//      child: GestureDetector(
//        child: Stack(
//          children: <Widget>[
//            Container(
//              width: MediaQuery.of(context).size.width,
//              height: MediaQuery.of(context).size.height,
//              color: Colors.transparent,
//            ),
//            Positioned(
//              child: GestureDetector(
//                  child: child,
//                  onTap: () {
//                    //点击子child
//                    if (onClick != null) {
//                      Navigator.of(context).pop();
//                      onClick();
//                    }
//                  }),
//              left: left,
//              top: top,
//            ),
//          ],
//        ),
//        onTap: () {
//          //点击空白处
//          Navigator.of(context).pop();
//        },
//      ),
//    );
//  }
//}
