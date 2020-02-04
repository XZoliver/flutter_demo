import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_web_json_demo/utils/http_dio.dart';
import 'register_page.dart';
import '../main_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _login() {
    print(
        {'phone': _phoneController.text, 'password': _passwordController.text});
    if (_phoneController.text.length != 11) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('手机号码格式错误，请重新输入'),
                actions: <Widget>[
                  FlatButton(
                    child: Text("确定"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
    } else if (_passwordController.text.length == 0) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('请输入密码'),
                actions: <Widget>[
                  FlatButton(
                    child: Text("确定"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
    } else {
      _doLogin();
      _phoneController.clear();
      _passwordController.clear();


    }
  }

  Future _doLogin() async {
    var response = await HttpUtil.getInstance().post("/login", data: {
      'phone': _phoneController.text,
      'password': _passwordController.text
    });
    HttpUtil.instance.setHeaders({"token":response['token']});
    debugPrint(response['data']);
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => Tabs()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          padding: const EdgeInsets.all(55),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Date Management',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '登录',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 25,
                        height: 1.5,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
              SizedBox(height: 120),
              SizedBox(
                child: new Container(
                  padding: EdgeInsets.fromLTRB(20, 2, 8, 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black12,
                  ),
                  alignment: Alignment.center,
                  child: TextField(
                    maxLines: 1,
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '手机号',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                child: new Container(
                  padding: EdgeInsets.fromLTRB(20, 2, 8, 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black12,
                  ),
                  alignment: Alignment.center,
                  child: TextField(
                    maxLines: 1,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: '密码',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                child: new Container(
                    padding: EdgeInsets.fromLTRB(2, 15, 2, 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue,
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                          child: InkWell(
                            child: FlatButton(
                              child: Text(
                                "登录",
                              ),
                              textColor: Colors.white,
                              splashColor: Colors.white,
                            ),
                            onTap: _login,
                          )
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                child: new Container(
                    padding: EdgeInsets.fromLTRB(2, 15, 2, 15),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        FlatButton(
                          child: Text("注册账号"),
                          textColor: Colors.blue,
                          onPressed: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new RegisterPage()));
                          },
                        )
                      ],
                    )),
              ),
            ],
          ),
        ));
  }
}
