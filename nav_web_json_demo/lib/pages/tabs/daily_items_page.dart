import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nav_web_json_demo/utils/http_dio.dart';
import 'package:nav_web_json_demo/pages/goals_pages/add_new_goal_page.dart';
import 'package:nav_web_json_demo/pages/goals_pages/item_details_page.dart';

class DailyPage extends StatefulWidget {
  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  var total = -1;
  var itemList = [];

  @override
  void initState() {
    super.initState();
    getItemList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("今日日程")),
      body: Container(
        child: total
        != 0 ? ListView.builder(
            itemCount: total,
            itemBuilder: (BuildContext ctx, int i) {
              var item = itemList[i];
              return GestureDetector(
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                      Border(top: BorderSide(color: Colors.black12))),
                  child: Container(
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ListTile(
                          title: Text(item['itemName']),
                        ),
                        Text("开始时间：${item['startTime']}"),
                        Text("结束时间：${item['endTime']}")
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext buildContext) {
                        return new ItemDetailsPage(
                            id: item['id'],
                            itemName: item['itemName'],
                            startTime: item['startTime'],
                            endTime:item['endTime'],
                            status: item['status'],);
                      }));
                },
              );
            })
            : getEmptyAndWait(total)
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "添加新的长期目标",
        child: new Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new AddNewGoalPage()));
        },
      ),
    );
  }

  getItemList() async {
    var response = await HttpUtil.getInstance().get("/items/get/today");
    setState(() {
      total = response['total'];
      itemList = response['data'];
    });
  }

  Widget getEmptyAndWait(int total) {
    if (total != 0) {
      return new Stack(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 35.0),
            child: new Center(
              child: SpinKitFadingCircle(
                color: Colors.blueAccent,
                size: 30.0,
              ),
            ),
          ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
            child: new Center(
              child: new Text('正在加载中，莫着急哦~'),
            ),
          ),
        ],
      );
    } else {
      return Center(
        child: Text("empty"),
      );
    }
  }
}
