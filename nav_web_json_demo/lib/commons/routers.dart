import 'package:flutter/material.dart';
import 'package:nav_web_json_demo/main.dart';

import '../pages/main_page.dart';
import '../pages/login_pages/login_page.dart';
import '../pages/login_pages/register_page.dart';//配置路由
final routes={
  '/':(context)=>LoginPage(),
  '/home':(context,{token})=>Tabs(),
  '/register':(context)=>RegisterPage()
};

//固定写法
var onGenerateRoute=(RouteSettings settings) {
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    }else{
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context));
      return route;
    }
  }
};