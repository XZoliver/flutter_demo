import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:nav_web_json_demo/utils/http_dio.dart';

class AddNewGoalPage extends StatefulWidget {
  @override
  _AddNewGoalPageState createState() => _AddNewGoalPageState();
}

class _AddNewGoalPageState extends State<AddNewGoalPage> {
  int id;
  String itemName;
  DateTime startTime;
  DateTime endTime;
  String priority;
  String _newValue;//优先级

  String startText = "开始时间";
  String endText = "结束时间";

  bool _showTitle = true;

  String _format = 'yy年M月d日 EEE,H时:m分';
  DateTimePickerLocale _locale = DateTimePickerLocale.zh_cn;
  List<DateTimePickerLocale> _locales = DateTimePickerLocale.values;

  @override
  Widget build(BuildContext context) {

    final controller = TextEditingController();
    controller.addListener((){
      itemName = controller.text;
    });


    return Scaffold(
      appBar: AppBar(
        title: Text("添加新目标"),
      ),
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
                          text: startText,
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
                          text: endText,
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
                            groupValue: _newValue,
                            onChanged: (value) {
                              setState(() {
                                _newValue = value;
                              });
                            },
                          ),
                        ),
                        Flexible(
                          child: RadioListTile<String>(
                            value: '2',
                            title: Text('中'),
                            groupValue: _newValue,
                            onChanged: (value) {
                              setState(() {
                                _newValue = value;
                              });
                            },
                          ),
                        ),
                        Flexible(
                          child: RadioListTile<String>(
                            value: '3',
                            title: Text('高'),
                            groupValue: _newValue,
                            onChanged: (value) {
                              setState(() {
                                _newValue = value;
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
                          _doAdd();
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

  Future _doAdd() async {
    var response = await HttpUtil.getInstance().post("/items/add", data: {
    "itemName":itemName,
    "startTime":startTime.toString(),
    "endTime":endTime.toString(),
    "priority":_newValue,
    });
    debugPrint(response['success']);
  }

  /// Display time picker.
  void _showDateTimePicker(DateTime _dateTime,bool isStartTime) {
    DatePicker.showDatePicker(
      context,
      initialDateTime: DateTime.now(),
      dateFormat: _format,
      locale: _locale,
      pickerTheme: DateTimePickerTheme(
        showTitle: _showTitle,
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
            startText = _dateTime.toString();
          }else{
            endText = _dateTime.toString();
          }
        });
      },
    );
  }
}
