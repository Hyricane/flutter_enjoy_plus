import 'dart:async';
import 'dart:math';

import 'package:enjoy_plus_flutter_7/pages/home/home_notify_list.dart';
import 'package:enjoy_plus_flutter_7/utils/RequestDio.dart';
import 'package:flutter/material.dart';

import '../../api/home.dart';
import 'home_nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _notifyList = [];

  // 倒计时变量
  int _count = 60;
  // timer变量
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    // 前端请求服务器会有跨域问题 => 封装一个api函数  直接调用方法请求
    final res = await getNotifyListAPI(); // 公告列表
    // print(res.data['data']); // 后端真正返回的数据 => 直接看文档
    // print(res.data); // 后端真正返回的数据 => 直接看文档
    // print(res); // 后端真正返回的数据 => 直接看文档
    setState(() {
      _notifyList = res;
    });
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
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  // 每隔一秒 _count--
                  // 返回定时器本身
                  _timer = Timer.periodic(Duration(seconds: 1), (timer) {
                    _count--;
                    setState(() {});
                  });
                },
                child: Text('开始')),
            Text('还剩$_count秒'),
            ElevatedButton(
                onPressed: () {
                  // 定时器
                  _timer?.cancel();
                },
                child: Text('停止')),
          ],
        ),
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
        HomeNotifyList(
          notifyList: _notifyList,
        )
      ]),
    );
  }
}
