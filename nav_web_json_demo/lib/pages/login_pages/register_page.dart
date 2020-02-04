import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_web_json_demo/utils/http_dio.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String showText = "null";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Page"),
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              FlatButton(
                child: Text("请求测试"),
                textColor: Colors.blue,
                onPressed: () {
                  _pressButton();
                },
              ),
              Text(
                showText,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
          ],
        )
      ),
    );
  }

  Future _pressButton() async {
    var response = await HttpUtil.getInstance().get("/register/getText");
    setState(() {
      showText = response['message'];
    });
  }
}
