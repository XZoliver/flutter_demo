import 'package:flutter/material.dart';
import 'package:nav_web_json_demo/pages/goals_pages/item_details_moodify_page.dart';
import 'package:nav_web_json_demo/utils/http_dio.dart';

class ItemDetailsPage extends StatefulWidget {
  ItemDetailsPage({Key key,
    @required this.id,
    @required this.itemName,
    @required this.startTime,
  @required this.endTime,
  @required this.status}):super(key:key);
  final int id;
  final String itemName;
  final String startTime;
  final String endTime;
  final String status;
  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {

  String getStatus(String status){
    switch(status){
      case "0": return "即将开始";break;
      case "1": return "进行中";break;
      case "2": return "已过期";break;
      case "3": return "已完成";break;
    }
  }

  // 返回每个隐藏的菜单项
  SelectView(IconData icon, String text, String id) {
    return new PopupMenuItem<String>(
        value: id,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Icon(icon, color: Colors.blue),
            new Text(text),
          ],
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("日程详情"),
        actions: <Widget>[
          new PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              this.SelectView(Icons.border_color, '编辑', 'A'),
              this.SelectView(Icons.delete, '删除', 'B'),
            ],
            onSelected: (String action) {
              // 点击选项的时候
              switch (action) {
                case 'A':
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) => new ItemDetailsModifyPage(id: widget.id, itemName: widget.itemName, startTime: widget.startTime, endTime: widget.endTime, status: widget.status)));
                  break;
                case 'B': _doDel();break;
              }
            },
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                child: Text(
                  "${widget.itemName}",
                  textScaleFactor: 2.0,
                  textAlign: TextAlign.center,
                )
              ),
              Container(
                height: 75,
                child: Text(
                  "${widget.startTime}",
                  textScaleFactor: 2.0,
                  textAlign: TextAlign.center,
                )
              ),
              Container(
                  height: 75,
                  child: Text(
                    "${widget.endTime}",
                    textScaleFactor: 2.0,
                    textAlign: TextAlign.center,
                  )
              ),
              Container(
                  height: 75,
                  child: Text(
                    getStatus(widget.status),
                    textScaleFactor: 2.0,
                    textAlign: TextAlign.center,
                  )
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: new Icon(Icons.check),
        onPressed: (){

        },
      ),
    );
  }

  Future _doDel() async {
    var response = await HttpUtil.getInstance().post("/items/del", data: {
      "id": widget.id
    });
    if(response['success'] == "true"){
      Navigator.pop(context);
    }else{
      final snackBar = new SnackBar(content: new Text('删除失败，请重试！'));
    }
  }
}

