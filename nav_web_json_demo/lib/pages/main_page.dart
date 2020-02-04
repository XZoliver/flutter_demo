import 'package:flutter/material.dart';
import 'tabs/advice_page.dart';
import 'tabs/daily_items_page.dart';
import 'tabs/settings_page.dart';
import 'tabs/long_term_page.dart';

class Tabs extends StatefulWidget {

  String token;
  Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {

  List _pageList=[
    DailyPage(),
    LongTermGoalsPage(),
    AdvicePage(),
    SettingPage(),
  ];


  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this._pageList[this._currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (int index){
          setState(() {
            this._currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("今日日程")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.golf_course),
              title: Text("长期目标")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text("任务建议")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text("设置")
          ),
        ],
      ),
    );
  }
}
