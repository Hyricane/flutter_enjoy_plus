import 'package:flutter/material.dart';

// 无状态组件 只是显示数据  不负责修改数据
class HomeNav extends StatelessWidget {
  HomeNav({Key? key}) : super(key: key);

  // 导航数据
  // 程序员 必须有一个能力 抽象出对象的能力  万物皆对象
  final List navList = [
    {
      'title': '我的房屋',
      'icon': 'assets/images/house_nav_icon@2x.png',
    },
    {
      'title': '我的报修',
      'icon': 'assets/images/repair_nav_icon@2x.png',
    },
    {
      'title': '访客登记',
      'icon': 'assets/images/visitor_nav_icon@2x.png',
    }
  ];

  List<Widget> _getChildren() {
    List<Widget> children = [];
    for (int i = 0; i < navList.length; i++) {
      children.add(GestureDetector(
          onTap: () {
            // 跳转页面  命名路由跳转  需要配合路由表
            // Navigator.pushNamed(context, '/home');
          },
          child: Column(children: [
            Image.asset(
              navList[i]['icon'],
              width: 35,
            ),
            Text(navList[i]['title'])
          ])));
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
          children: _getChildren(),
          mainAxisAlignment: MainAxisAlignment.spaceAround),
    );
  }
}
