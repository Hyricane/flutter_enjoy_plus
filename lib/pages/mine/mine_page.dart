import 'dart:io';

import 'package:enjoy_plus_flutter_7/utils/EventBus.dart';
import 'package:enjoy_plus_flutter_7/utils/TokenManager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../api/user.dart';

class MinePage extends StatefulWidget {
  const MinePage(
      {Key? key, required this.activeIndex, required this.setActiveIndex})
      : super(key: key);

  final int activeIndex;
  final Function(int) setActiveIndex;

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  // 定义一个用户信息map对象 有avatar nickName id
  Map<String, dynamic> userInfo = {
    'avatar': '',
    'nickName': '',
    'id': '',
  };

  // 菜单数据
  final List menuList = [
    {
      "title": "我的房屋",
      "icon": "assets/images/house_profile_icon@2x.png",
    },
    {
      "title": "我的报修",
      "icon": "assets/images/repair_profile_icon@2x.png",
    },
    {
      "title": "访客记录",
      "icon": "assets/images/visitor_profile_icon@2x.png",
    }
  ];

  Widget getImageWidget() {
    // kIsWeb 标识运行平台是否在web
    // 脏数据 开发过程中 产生一些测试数据 不合理的数据
    // {avatar: null, id: 7181970497892352, nickName: null}
    if (userInfo['avatar'] != '' && userInfo['avatar'] != null) {
      // 鸿蒙图片
      return Image.network(
        userInfo['avatar'],
        width: 50,
        height: 50,
      );
    }
    // 默认本地图
    return Image.asset(
      'assets/images/avatar_1.jpg',
      width: 50,
      height: 50,
    );
  }

  List<Widget> _getRowChildren() {
    return [
      ClipRRect(
        borderRadius: BorderRadius.circular(100), // 50/2=25
        // 头像分为以下几种情况:
        // 1. 本地图片     Image.asset
        // 2. 鸿蒙系统中的图片 /data开头    Image.file
        // 3. 网络图片 http开头     Image.network
        child: getImageWidget(),
      ),
      SizedBox(width: 10),
      Text(
        userInfo['nickName'] != '' && userInfo['nickName'] != null
            ? userInfo['nickName']
            : "游客",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      Spacer(), // Text().layoutWeight(1)  或者 Blank()
      TextButton(
          onPressed: () {
            // 带参数  didChangeDependencies ModalRoute.of(context).settings.arguments
            Navigator.pushNamed(context, '/profile', arguments: userInfo);
          },
          child: Text(
            '去完善信息',
            style: TextStyle(color: Colors.white),
          )),
      Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: Colors.white,
      )
      // flutter class 好好学 => 后端也是class  => 面相对象
      // class { static const int age = 18 }
    ];
  }

  List<Widget> _getColumnChildren() {
    return menuList.map((item) {
      return GestureDetector(
        onTap: () {
          eventBus.fire(EatEvent());
        },
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              Image.asset(
                item['icon'],
                width: 20,
              ),
              SizedBox(width: 10),
              Text(
                item['title'],
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
              )
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    // 订阅登录成功事件  一旦登录成功 重新获取用户信息
    eventBus.on<LogSuccessEvent>().listen((event) {
      // event就是当初fire发射的事件实例
      // print(event.info);
      // print('我监听到了登录成功事件');
      getUserInfo();
    });
  }

  // initState中调用getUserInfoAPI请求我的信息
  // @override
  // void initState() {
  //   super.initState();
  //   // 获取我的信息  widget.activeIndex == 1
  //   if (widget.activeIndex == 1) {
  //     print('该我上请求了...');
  //     // getUserInfo();
  //   }
  // }

  // 接受路由参数 didChangeDependencies
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // 获取我的信息  widget.activeIndex == 1
  //   if (widget.activeIndex == 1) {
  //     print('该我上请求了...');
  //     // getUserInfo();
  //   }
  // }

  // 父组件activeIndex改变时  请求我的信息
  @override
  void didUpdateWidget(covariant MinePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 获取我的信息  widget.activeIndex == 1
    if (widget.activeIndex == 1) {
      // print('该我上请求了...');
      getUserInfo();
    }
  }

  getUserInfo() async {
    userInfo = await getUserInfoAPI(); // 这个请求401 所以你的数据没了 所以你的UI炸了
    // => 这次请求后的结果 你想扭转回来 让它成为一个成功的promise/Future
    print(userInfo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(200, 85, 145, 175),
      appBar: AppBar(
          elevation: 0, // 移除阴影
          title: Text(
            '我的',
          ),
          backgroundColor: Colors.transparent),
      body: ListView(
        children: [
          // 个人信息
          Container(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                children: _getRowChildren(),
              ),
            ),
          ),
          // 功能区
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: _getColumnChildren(),
            ),
          ),
          TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext ctx) {
                      return AlertDialog(
                        title: Text("提示"),
                        content: Text("确定退出登录吗？"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                // flutter 中弹窗 也是属于"页面"组件
                                Navigator.pop(context);
                                // Navigator.of(context).pop();
                              },
                              child: Text("取消")),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                tokenManager.removeToken();
                                // 去首页
                                widget.setActiveIndex(0);
                              },
                              child: Text("确认")),
                        ],
                      );
                    });
              },
              child: Text(
                "退出",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
