import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:nav_web_json_demo/utils/http_dio.dart';

class LongItemDelPage extends StatefulWidget{
  @override
  _LongItemDelPage createState() {
  }
}

class _LongItemDelPage extends State<LongItemDelPage> {
  int id;

  @override
  void initState() {
    super.initState();
    postDelId();
  }
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.addListener(() {
      id = int.parse(controller.text);
    });

      return Scaffold(
        appBar: AppBar(title: Text('删除指定长期计划'),),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 150,
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                            labelText: "日程ID",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      height: 60,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(2, 15, 2, 15),
                        child: RaisedButton(
                          child: Text("确认删除"),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          onPressed: () {
                            postDelId();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

  Widget getIconText({Icon icon, String text, VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.grey.withOpacity(0.2)),
        child: Row(
          children: <Widget>[
            icon,
            SizedBox(
              width: 70,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }

  Future postDelId() async {
    FormData delData = new FormData.from({
      "id": id,
    });
    var response = await HttpUtil.getInstance().post(
        '/example/long/del', data: delData);
  }
}
