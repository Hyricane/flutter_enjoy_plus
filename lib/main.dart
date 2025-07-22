import 'package:enjoy_plus_flutter_7/pages/login/index.dart';
import 'package:enjoy_plus_flutter_7/pages/profile/profile_page.dart';
import 'package:enjoy_plus_flutter_7/pages/tabbar_page.dart';
import 'package:flutter/material.dart';

import 'pages/notice/notice_detail.dart';

void main() {
  runApp(MaterialApp(
    // 命名路由 跳转页面
    routes: {
      '/': (context) => TabbarPage(),
      '/notice_detail': (context) => NoticeDetail(),
      // 添加一个登录页面的路由
      '/login': (context) => const LoginPage(),
      '/profile': (context) => const ProfilePage(),
    },
    // initialRoute: '/',
    // home: Center(
    //   child: Text('Hello World'),
    // ),
  ));
}
