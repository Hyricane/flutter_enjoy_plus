import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../pages/404.dart';
import '../pages/house/building_list.dart';
import '../pages/house/house_detail.dart';
import '../pages/house/house_form.dart';
import '../pages/house/house_list.dart';
import '../pages/house/location_list.dart';
import '../pages/house/room_list.dart';
import '../pages/login/index.dart';
import '../pages/notice/notice_detail.dart';
import '../pages/profile/profile_page.dart';
import '../pages/tabbar_page.dart';
import '../utils/TokenManager.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => TabbarPage(),
  '/notice_detail': (context) => NoticeDetail(),
  // 添加一个登录页面的路由
  '/login': (context) => const LoginPage(),
  // '/profile': (context) => const ProfilePage(),
};

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  // 又是一个新来的保安  啥也不干
  print(settings.name); // 跳转去的路由名
  print(settings.arguments); // 跳转去的路由携带的参数

  // 分析: 判断有无token 有token就进去  没token就跳转到登录页面
  // tokenManager.getToken().then((value) => null)
  var token = tokenManager.getToken();
  if (token != '') {
    // 有token
    // 判断一下用户要去的页面 然后跳转
    if (settings.name == '/profile') {
      return MaterialPageRoute(
        builder: (context) => ProfilePage(
            userInfo: settings.arguments as Map<String, dynamic>), // 父传子
      );
    } else if (settings.name == '/house') {
      return MaterialPageRoute(
        builder: (context) => HouseList(),
        settings: settings,
      );
    } else if (settings.name == '/add_house') {
      return MaterialPageRoute(
        // builder: (context) => Text('add'),
        builder: (context) => LocationList(),
      );
    } else if (settings.name == '/building_list') {
      return MaterialPageRoute(
        // builder: (context) => Text('add'),
        builder: (context) => BuildingList(
            point: (settings.arguments as Map<String, dynamic>)['point']),
      );
    } else if (settings.name == '/room_list') {
      return MaterialPageRoute(
        // builder: (context) => Text('add'),
        builder: (context) => RoomList(
          point: (settings.arguments as Map<String, dynamic>)['point'],
          building: (settings.arguments as Map<String, dynamic>)['building'],
        ),
      );
    } else if (settings.name == '/house_form') {
      return MaterialPageRoute(
        // builder: (context) => Text('add'),
        builder: (context) =>
            HouseForm(params: settings.arguments as Map<String, dynamic>),
      );
    } else if (settings.name == '/house_detail') {
      return MaterialPageRoute(
          // builder: (context) => Text('add'),
          builder: (context) => HouseDetail(
                id: (settings.arguments as Map)["id"] as String,
              ));
    } else {
      // 点了没反应
      return MaterialPageRoute(
        // builder: (context) => Text('404'),
        builder: (context) => NotFound(),
      );
    }
  } else {
    // 没有token
    return MaterialPageRoute(
      builder: (context) => LoginPage(),
    );
  }
}
