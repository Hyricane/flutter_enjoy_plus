import 'package:enjoy_plus_flutter_7/pages/tabbar_page.dart';
import 'package:flutter/material.dart';

import 'pages/notice/notice_detail.dart';

void main() {
  runApp(MaterialApp(
    // 命名路由 跳转页面
    routes: {
      '/': (context) => TabbarPage(),
      '/notice_detail': (context) => NoticeDetail(),
    },
    // initialRoute: '/',
    // home: Center(
    //   child: Text('Hello World'),
    // ),
  ));
}
