import 'package:enjoy_plus_flutter_7/pages/mine/mine_page.dart';
import 'package:flutter/material.dart';

import 'home/home_page.dart';

class TabbarPage extends StatefulWidget {
  const TabbarPage({Key? key}) : super(key: key);

  @override
  _TabbarPageState createState() => _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage> {
  List tabsList = [
    {
      'label': '首页',
      // 必须要加回来  其他平台识别不了
      // 路径从assets开始写
      'icon': 'assets/tabs/home_default.png',
      'activeIcon': 'assets/tabs/home_active.png'
    },
    {
      'label': '我的',
      'icon': 'assets/tabs/my_default.png',
      'activeIcon': 'assets/tabs/my_active.png'
    }
  ]; // 底部导航栏数据

  int activeIndex = 0; // 默认选中的索引

  List<BottomNavigationBarItem> getTabsBar() {
    List<BottomNavigationBarItem> list = [];
    for (var i = 0; i < tabsList.length; i++) {
      list.add(
        BottomNavigationBarItem(
            label: tabsList[i]["label"],
            icon: Image.asset(
              tabsList[i]["icon"],
              width: 30,
              height: 30,
            ),
            activeIcon: Image.asset(
              tabsList[i]["activeIcon"],
              width: 30,
              height: 30,
            )),
      );
    }
    return list;
  } // 创建底部导航栏

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: activeIndex,
        children: [HomePage(), MinePage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: activeIndex,
        selectedItemColor: const Color.fromARGB(255, 85, 145, 175),
        unselectedItemColor: Colors.black,
        items: getTabsBar(),
        onTap: (int index) {
          setState(() {
            activeIndex = index;
          });
        },
      ),
    );
  }
}
