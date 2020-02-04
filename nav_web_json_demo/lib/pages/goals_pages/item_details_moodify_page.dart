import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:nav_web_json_demo/utils/http_dio.dart';

class ItemDetailsModifyPage extends StatefulWidget {
  ItemDetailsModifyPage(
      {Key key,
      @required this.id,
      @required this.itemName,
      @required this.startTime,
      @required this.endTime,
      @required this.status})
      : super(key: key);
  final int id;
  final String itemName;
  final String startTime;
  final String endTime;
  final String status;

  @override
  _ItemDetailsModifyPageState createState() => _ItemDetailsModifyPageState();
}

class _ItemDetailsModifyPageState extends State<ItemDetailsModifyPage> {
  String itemName;
  String startTime;
  String endTime;
  String status;

  DateTime _startTime;
  DateTime _endTime;

  String getStatus(String status) {
    switch (status) {
      case "0":
        return "即将开始";
        break;
      case "1":
        return "进行中";
        break;
      case "2":
        return "已过期";
        break;
      case "3":
        return "已完成";
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _startTime = DateTime.parse(widget.startTime);
      _endTime = DateTime.parse(widget.endTime);
      itemName = widget.itemName;
      startTime = widget.startTime;
      endTime = widget.endTime;
      status = widget.status;
    });
  }

  String startText = "开始时间";
  String endText = "结束时间";

  bool _showTitle = true;

  String _format = 'yy年M月d日 EEE,H时:m分';
  DateTimePickerLocale _locale = DateTimePickerLocale.zh_cn;
  List<DateTimePickerLocale> _locales = DateTimePickerLocale.values;

  @override
  Widget build(BuildContext context) {
    _startTime = DateTime.parse(widget.startTime);
    _endTime = DateTime.parse(widget.endTime);
    itemName = widget.itemName;
    startTime = widget.startTime;
    endTime = widget.endTime;
    status = widget.status;

    return Scaffold(
      appBar: AppBar(
        title: Text("修改"),
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
                      onChanged: (value){
                        this.itemName = value;
                      },
                      controller: TextEditingController.fromValue(
                          TextEditingValue(
                              text:
                                  '${this.itemName == null ? "" : this.itemName}',
                              selection: TextSelection.fromPosition(
                                  TextPosition(
                                      affinity: TextAffinity.downstream,
                                      offset: '${this.itemName}'.length)))),
                      decoration: InputDecoration(
                          labelText: "日程名称",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0))),
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
                          text: startTime == null ? startText : startTime,
                          onTap: () {
                            _showDateTimePicker(_startTime, true);
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
                          text: endTime == null ? endText : endTime,
                          onTap: () {
                            _showDateTimePicker(_endTime, false);
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
                            groupValue: status,
                            onChanged: (value) {
                              setState(() {
                                status = value;
                              });
                            },
                          ),
                        ),
                        Flexible(
                          child: RadioListTile<String>(
                            value: '2',
                            title: Text('中'),
                            groupValue: status,
                            onChanged: (value) {
                              setState(() {
                                status = value;
                              });
                            },
                          ),
                        ),
                        Flexible(
                          child: RadioListTile<String>(
                            value: '3',
                            title: Text('高'),
                            groupValue: status,
                            onChanged: (value) {
                              setState(() {
                                status = value;
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
      "itemName": itemName,
      "startTime": startTime.toString(),
      "endTime": endTime.toString(),
      "priority": status,
    });
  }

  /// Display time picker.
  void _showDateTimePicker(DateTime _dateTime, bool isStartTime) {
    DatePicker.showDatePicker(
      context,
      initialDateTime: DateTime.now(),
      dateFormat: _format,
      locale: _locale,
      pickerTheme: DateTimePickerTheme(
        showTitle: _showTitle,
      ),
      pickerMode: DateTimePickerMode.datetime,
      // show TimePicker
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
          if (isStartTime) {
            startTime = _dateTime.toString();
          } else {
            endTime = _dateTime.toString();
          }
        });
      },
    );
  }
}
