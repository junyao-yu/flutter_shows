import 'package:flutter/material.dart';
import 'package:flutter_shows/common/global.dart';
import 'package:flutter_shows/model/RecommendInfo.dart';
import 'package:flutter_shows/model/MyInviter.dart';

class InvitePage extends StatefulWidget {
  @override
  InvitePageState createState() => InvitePageState();
}

class InvitePageState extends State<InvitePage> {
  int _balance = 0;
  List<Info> list;

  void showNoInviterDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
            child: Container(
          height: 174,
          width: 280,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 18),
                child: Image.asset(Utils.wapperResourcePath('img_gth.png')),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text(
                  '您没有邀请人哦',
                  style: TextStyle(color: Color(0xFF4A4A4A), fontSize: 17),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 14, bottom: 25),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 24,
                    width: 87,
                    alignment: Alignment.center,
                    child: Text(
                      '我知道了',
                      style: TextStyle(fontSize: 12, color: Color(0xFFF05C58)),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFF05C58), width: 1),
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                ),
              )
            ],
          ),
        ));
      },
    );
  }

  void showYesInviterDialog(BuildContext context, String name, String mobile) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
            child: Container(
          height: 143,
          width: 280,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  '您的邀请人是\n$name $mobile',
                  style: TextStyle(
                      color: Color(0xFF4A4A4A),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20, top: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 24,
                    width: 87,
                    alignment: Alignment.center,
                    child: Text(
                      '我知道了',
                      style: TextStyle(fontSize: 12, color: Color(0xFFF05C58)),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFF05C58), width: 1),
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                ),
              )
            ],
          ),
        ));
      },
    );
  }

  _requestRecommend() async {
    CommonRequest.requestRecommendInfo().then((result) {
      RecommendInfo homeListResponse = RecommendInfo.fromJson(result);
      if (homeListResponse.code == 0) {
        setState(() {
          this.list = homeListResponse.data.list;
        });
      } else {}
    });
  }

  _requestMyInviter(BuildContext context) async {
    CommonRequest.requestMyInviter().then((result) {
      MyInviter myInviter = MyInviter.fromJson(result);
      if (myInviter.code == 0) {
        if (myInviter.data == null) {
          showNoInviterDialog(context);
        } else {
          if (myInviter.data.invited_id > 0) {
            showYesInviterDialog(context, myInviter.data.invited_name,
                myInviter.data.invited_mobile);
          } else {
            showNoInviterDialog(context);
          }
        }
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '我的邀请',
          style: TextStyle(
              color: Color(0xFF313131),
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          GestureDetector(
              onTap: () {
                _requestMyInviter(context);
              },
              child: Container(
                height: double.infinity,
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Text(
                    '我的邀请人',
                    style: TextStyle(color: Color(0xFF313131), fontSize: 14),
                  ),
                ),
              ))
        ],
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 11, right: 11, top: 3),
                  child: Image.asset(
                    Utils.wapperResourcePath('bg_yaoqing.png'),
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: 182,
                  ),
                ),
                Positioned(
                  child: Text(
                    '我获得的奖励',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  left: 33,
                  top: 25,
                ),
                Positioned(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        _balance.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          '工分',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      )
                    ],
                  ),
                  left: 33,
                  top: 48,
                ),
                Positioned(
                  child: Text(
                    '（100工分=1元）',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  left: 33,
                  top: 90,
                ),
                Positioned(
                  child: Container(
                    height: 121,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, WEBVIEW_ROUTE, arguments: {
                          'title': '提现',
                          'url': H5_HOST + H5Url.withdraw
                        });
                      },
                      child: Text(
                        '去提现 >',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  right: 20,
                  top: 3,
                ),
                Positioned(
                  child: Container(
                    width: double.infinity,
                    height: 32,
                    alignment: Alignment.center,
                    child: RaisedButton(
                        child: Text('邀好友赚现金'),
                        onPressed: () {
                          Navigator.pushNamed(context, WEBVIEW_ROUTE,
                              arguments: {
                                'title': '邀好友赚现金',
                                'url': ACTIVITY_HOST + H5Url.invite
                              });
                        },
                        textColor: Color(0xFFF05C58),
                        color: Colors.white,
                        disabledColor: Colors.white,
                        disabledTextColor: Color(0xFFF05C58),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        padding: EdgeInsets.only(left: 22, right: 22)),
                  ),
                  bottom: 14,
                  left: 11,
                  right: 11,
                )
              ],
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(top: 19, bottom: 17),
                child: Row(
                  children: <Widget>[
                    _expandedWidget('被邀请人', 14),
                    _expandedWidget('注册时间', 14),
                    _expandedWidget('面试时间', 14),
                    _expandedWidget('我的奖励', 14),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _selectWidget(),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }

  _expandedWidget(String content, double size) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Text(
          content,
          style: TextStyle(color: Color(0xFF4A4C5B), fontSize: size),
        ),
      ),
      flex: 1,
    );
  }

  _selectWidget() {
    if (list == null || list.length == 0) {
      return _emptyWidget();
    } else {
      return _listWidget();
    }
  }

  _emptyWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 79),
      child: Column(
        children: <Widget>[
          Image.asset(Utils.wapperResourcePath('bg_yhk_kong.png')),
          Text('暂无数据', style: TextStyle(color: Color(0xFF4A4C5B), fontSize: 15))
        ],
      ),
    );
  }

  _listWidget() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _listItem(context, index);
      },
      itemCount: list.length,
      scrollDirection: Axis.vertical,
    );
  }

  _listItem(BuildContext context, int index) {
    var info = list[index];
    return Container(
      width: double.infinity,
      height: 36,
      alignment: Alignment.center,
      color: index.isEven ? Color(0xFFF8F6F9) : Colors.white,
      child: Row(
        children: <Widget>[
          _expandedWidget(info.user_mobile, 11),
          _expandedWidget(info.registered_at, 11),
          _expandedWidget(info.interviewed_at, 11),
          _expandedWidget(info.is_rewarded, 11),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _requestRecommend();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(InvitePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
