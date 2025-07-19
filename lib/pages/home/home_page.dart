import 'dart:math';

import 'package:flutter/material.dart';

import 'home_nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(40, 85, 145, 175),
      appBar: AppBar(
        elevation: 0, // 移除阴影效果
        title: Text(
          '享+社区',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(padding: EdgeInsets.all(10), children: [
        // 导航栏
        HomeNav(),
        // 单张图
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/banner@2x.jpg',
            fit: BoxFit.cover,
          ),
        )
        // 公告区
      ]),
    );
  }
}
