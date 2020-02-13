import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:nav_web_json_demo/utils/http_dio.dart';

class LongItemAddPage extends StatefulWidget {
  @override
  _LongItemAddPage createState() {
  }
}

class _LongItemAddPage extends State<LongItemAddPage>{
  int id;
  String itemName;
  DateTime startTime;
  DateTime endTime;
  String priority;

  @override
  void initState() {
    super.initState();
    postNewLong();
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.addListener((){
      itemName = controller.text;
    });

    return Scaffold(
      appBar: AppBar(title: Text("添加长期目标"),),
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
                          labelText: "日程名称",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          )),
                    ),
                  ),
                  Container(
                    height: 75,
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        getIconText(
                          icon: Icon(
                            Icons.timer,
                            color: Colors.blue,
                          ),
                          text: startTime.toString(),
                          onTap:(){
                            _showDateTimePicker(startTime,true);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 75,
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        getIconText(
                          icon: Icon(
                            Icons.timelapse,
                            color: Colors.blue,
                          ),
                          text: endTime.toString(),
                          onTap:() {
                            _showDateTimePicker(endTime,false);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 75,
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: RadioListTile<String>(
                            value: '1',
                            title: Text('低'),
                            groupValue: priority,
                            onChanged: (value) {
                              setState(() {
                                priority = value;
                              });
                            },
                          ),
                        ),
                        Flexible(
                          child: RadioListTile<String>(
                            value: '2',
                            title: Text('中'),
                            groupValue: priority,
                            onChanged: (value) {
                              setState(() {
                                priority = value;
                              });
                            },
                          ),
                        ),
                        Flexible(
                          child: RadioListTile<String>(
                            value: '3',
                            title: Text('高'),
                            groupValue: priority,
                            onChanged: (value) {
                              setState(() {
                                priority = value;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    height: 60,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(2, 15, 2, 15),
                      child: RaisedButton(
                        child: Text("添加"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        onPressed: () {
                          postNewLong();
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
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

  Future postNewLong() async{
    FormData longData = new FormData.from({
      "itemName" : itemName ,
      "startTime" : startTime.toString() ,
      "endTime" : endTime.toString(),
      "priority" : priority
    });
    var response = await HttpUtil.getInstance().post('/example/long/add' , data: longData);
  }

  void _showDateTimePicker(DateTime _dateTime,bool isStartTime) {
    DatePicker.showDatePicker(
      context,
      initialDateTime: DateTime.now(),
      dateFormat: 'yy年M月d日 EEE,H时:m分',
      locale: DateTimePickerLocale.zh_cn,
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
      ),
      pickerMode: DateTimePickerMode.datetime, // show TimePicker
      onCancel: () {
        debugPrint('onCancel');
      },
      onChange: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
          debugPrint('onConfirm');
          if(isStartTime){
            startTime = _dateTime;
          }else{
            endTime = _dateTime;
          }
        });
      },
    );
  }
}