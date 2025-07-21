import 'dart:math';

import 'package:enjoy_plus_flutter_7/pages/home/home_notify_list.dart';
import 'package:enjoy_plus_flutter_7/utils/RequestDio.dart';
import 'package:flutter/material.dart';

import 'home_nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    // 前端请求服务器会有跨域问题
    final res = await requestDio.get('/announcement'); // 公告列表
    // print(res.data['data']); // 后端真正返回的数据 => 直接看文档
    // print(res.data); // 后端真正返回的数据 => 直接看文档
    print(res); // 后端真正返回的数据 => 直接看文档
    // res.data 之后的数据 由于没有类型 所以需要中括号

    // 想统一处理=>响应拦截器

    // 第二个请求  res.data['data']
    // 第二个请求  res.data['data']
    // 第二个请求  res.data['data']
    // 第二个请求  res.data['data']
    // 第二个请求  res.data['data']
    // 第二个请求  res.data['data']
    // 第二个请求  res.data['data']
  }

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
        ),
        // 公告区
        HomeNotifyList()
      ]),
    );
  }
}
