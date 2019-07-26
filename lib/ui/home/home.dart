import 'package:flutter/material.dart';
import 'package:flutter_shows/ui/home/job.dart';
import 'package:flutter_shows/ui/home/map.dart';
import 'package:flutter_shows/ui/home/message.dart';
import 'package:flutter_shows/ui/home/user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final _pageList = [MapPage(), JobPage(), MessagePage(), UserPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Image.asset('assets/images/tab_map_unselect.png'),
                activeIcon: Image.asset('assets/images/tab_map_select.png'),
                title: Padding(
                  padding: EdgeInsets.only(
                      left: 0.0, top: 5.0, right: 0.0, bottom: 0.0),
                  child: Text('找工作'),
                )),
            BottomNavigationBarItem(
                icon: Image.asset('assets/images/tab_work_unselect.png'),
                activeIcon: Image.asset('assets/images/tab_work_select.png'),
                title: Padding(
                  padding: EdgeInsets.only(
                      left: 0.0, top: 5.0, right: 0.0, bottom: 0.0),
                  child: Text('岗位'),
                )),
            BottomNavigationBarItem(
                icon: Image.asset('assets/images/tab_news_unselect.png'),
                activeIcon: Image.asset('assets/images/tab_news_select.png'),
                title: Padding(
                  padding: EdgeInsets.only(
                      left: 0.0, top: 5.0, right: 0.0, bottom: 0.0),
                  child: Text('消息'),
                )),
            BottomNavigationBarItem(
                icon: Image.asset('assets/images/tab_me_unselect.png'),
                activeIcon: Image.asset('assets/images/tab_me_select.png'),
                title: Padding(
                  padding: EdgeInsets.only(
                      left: 0.0, top: 5.0, right: 0.0, bottom: 0.0),
                  child: Text('我的'),
                ))
          ],
          onTap: _onItemTapped,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFFEA4C56),
          unselectedItemColor: Color(0xFF5D5D5D)
      ),
    );
  }
}
