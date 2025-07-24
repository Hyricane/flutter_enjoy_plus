import 'package:flutter/material.dart';

import '../../api/user.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
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

  List<Widget> _getRowChildren() {
    return [
      ClipRRect(
        borderRadius: BorderRadius.circular(100), // 50/2=25
        child: Image.asset(
          'assets/images/avatar_1.jpg',
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
      ),
      SizedBox(width: 10),
      Text(
        '张三',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      Spacer(), // Text().layoutWeight(1)  或者 Blank()
      TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
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
      return SizedBox(
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
      );
    }).toList();
  }

  // initState中调用getUserInfoAPI请求我的信息
  @override
  void initState() {
    super.initState();
    // 获取我的信息
    getUserInfo();
  }

  getUserInfo() async {
    final res = await getUserInfoAPI();
    print(res);
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
          )
        ],
      ),
    );
  }
}
