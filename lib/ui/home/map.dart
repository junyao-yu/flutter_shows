import 'package:flutter/material.dart';
import 'package:flutter_shows/common/global.dart';
import 'package:flutter_shows/ui/custom/LoadingPage.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}
enum DialogDemoAction {
  cancel,
  discard,
  disagree,
  agree,
}
class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
//      body: Center(
//        child: Text('找工作', style: TextStyle(fontSize: 50),),
//      ),
//      body: LoadingPage(),

          body: Container(
            
            child: Padding(padding: EdgeInsets.all(100), child: GestureDetector(onTap: () {
              showDemoDialog<String>(
                context: context,
                child: SimpleDialog(
backgroundColor: Colors.transparent,
                    elevation: 0,
                  title: Image.asset(Utils.wapperResourcePath('but_jzgw.png')),
                ),
              );
            }, child: Text('啦啦啦'),),),
          ),
        );
  }
  void showDemoDialog<T>({ BuildContext context, Widget child }) {
    showDialog<T>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => child,
    )
        .then<void>((T value) { // The value passed to Navigator.pop() or null.
      if (value != null) {
//        _scaffoldKey.currentState.showSnackBar(SnackBar(
//          content: Text('You selected: $value'),
//        ));
      }
    });
  }
}
