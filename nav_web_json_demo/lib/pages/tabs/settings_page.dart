import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: Container(
        decoration: BoxDecoration(border: Border(top:BorderSide(color: Colors.black12))),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 75,
              child: ListTile(
                leading: Icon(
                    Icons.account_box
                ),
                title: Text("用户信息设置"),
              ),
            ),
            Container(
              height: 75,
              child: ListTile(
                leading: Icon(
                    Icons.build
                ),
                title: Text("系统设置"),
              ),
            ),
            Container(
              height: 75,
              child: ListTile(
                leading: Icon(
                    Icons.format_color_text
                ),
                title: Text("关于"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
