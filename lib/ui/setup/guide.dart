import 'package:flutter/material.dart';
import 'package:flutter_shows/common/global.dart';


class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  static var imgs = [
    Utils.wapperResourcePath('guide1.gif'),
    Utils.wapperResourcePath('guide2.gif'),
    Utils.wapperResourcePath('guide3.gif')
  ];

  _skipClick() {
    Navigator.pushReplacementNamed(context, LOGIN_ROUTE);
  }

  @override
  void initState() {
    super.initState();

    _initToken();
  }

  _initToken() async {
    await SpUtil.getInstance();

    print('token---->${SpUtil.getString(Constant.token)}');
    if (SpUtil.getString(Constant.token).isNotEmpty) {
      Navigator.pushReplacementNamed(context, HOME_ROUTE);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        //相当于ViewPager
        itemBuilder: ((context, index) {
          if (index == imgs.length - 1) {
            return Stack(
              children: <Widget>[
                Image.asset(
                  imgs[index],
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                ),
                Container(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: _skipClick,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 0, top: 0, right: 0, bottom: 50),
                        child: Container(
                            width: 100, height: 50, color: Colors.transparent),
                      ),
                    ))
              ],
            );
          } else {
            return Image.asset(
              imgs[index],
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            );
          }
        }),
        itemCount: imgs.length,
        scrollDirection: Axis.horizontal,
        reverse: false,
      ),
    );
  }
}
