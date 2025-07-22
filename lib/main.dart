import 'package:enjoy_plus_flutter_7/pages/login/index.dart';
import 'package:enjoy_plus_flutter_7/pages/profile/profile_page.dart';
import 'package:enjoy_plus_flutter_7/pages/tabbar_page.dart';
import 'package:enjoy_plus_flutter_7/utils/TokenManager.dart';
import 'package:flutter/material.dart';

import 'pages/notice/notice_detail.dart';

void main() {
  runApp(MaterialApp(
    // 命名路由 跳转页面
    // 配置路由表
    routes: {
      '/': (context) => TabbarPage(),
      '/notice_detail': (context) => NoticeDetail(),
      // 添加一个登录页面的路由
      '/login': (context) => const LoginPage(),
      // '/profile': (context) => const ProfilePage(),
    },
    // 路由拦截不允许使用async标记(不允许有异步逻辑  耗时方法)
    // getToken必须处理成同步的!!!!
    // 路由生成钩子 一旦发现这次要去的页面路由匹配不到  就会根据这个钩子生成对应的路由页面
    onGenerateRoute: (RouteSettings settings) {
      // 又是一个新来的保安  啥也不干

      // 分析: 判断有无token 有token就进去  没token就跳转到登录页面
      // tokenManager.getToken().then((value) => null)
      var token = tokenManager.getToken();
      if (token != '') {
        // 有token
        return MaterialPageRoute(
          builder: (context) => ProfilePage(),
        );
      } else {
        // 没有token
        return MaterialPageRoute(
          builder: (context) => LoginPage(),
        );
      }
    },
    // initialRoute: '/',
    // home: Center(
    //   child: Text('Hello World'),
    // ),
  ));
}
