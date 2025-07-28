import 'package:enjoy_plus_flutter_7/pages/house/house_form.dart';
import 'package:enjoy_plus_flutter_7/pages/house/house_list.dart';
import 'package:enjoy_plus_flutter_7/pages/login/index.dart';
import 'package:enjoy_plus_flutter_7/pages/profile/profile_page.dart';
import 'package:enjoy_plus_flutter_7/pages/tabbar_page.dart';
import 'package:enjoy_plus_flutter_7/router/index.dart';
import 'package:enjoy_plus_flutter_7/utils/TokenManager.dart';
import 'package:flutter/material.dart';

import 'pages/404.dart';
import 'pages/house/building_list.dart';
import 'pages/house/location_list.dart';
import 'pages/house/room_list.dart';
import 'pages/notice/notice_detail.dart';

void main() {
  runApp(MaterialApp(
    // 命名路由 跳转页面
    // 配置路由表
    routes: routes,
    // 路由拦截不允许使用async标记(不允许有异步逻辑  耗时方法)
    // getToken必须处理成同步的!!!!
    // 路由生成钩子 一旦发现这次要去的页面路由匹配不到  就会根据这个钩子生成对应的路由页面
    onGenerateRoute: onGenerateRoute,
    // initialRoute: '/',
    // home: Center(
    //   child: Text('Hello World'),
    // ),
  ));
}
