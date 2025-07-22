import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/PromptAction.dart';

// 无状态组件 只是显示数据  不负责修改数据
// 无状态组件 没有this.context 只能通过build传递context
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

  Widget getBottom() {
    return Container(
      width: double.infinity,
      height: 200,
      color: Colors.red,
      child: Column(
        children: [
          Text('1'),
          Text('1'),
          Text('1'),
        ],
      ),
    );
  }

  List<Widget> _getChildren(BuildContext ctx) {
    List<Widget> children = [];
    for (int i = 0; i < navList.length; i++) {
      children.add(GestureDetector(
          onTap: () async {
            // 测试首选项 持久化
            // 实例化
            // 存token   获取token(很多地方都得验证token) => 封装
            final SharedPreferences pp = await SharedPreferences.getInstance();
            if (i == 0) {
              pp.setInt('money', 1000);
            } else if (i == 1) {
              print(pp.getInt('money'));
            } else {
              pp.remove('money');
            }

            // showDialog(
            //     context: ctx,
            //     builder: (ctx) => AlertDialog(
            //           title: Text('提示'),
            //           content: Text('确定要执行此操作吗？'),
            //           actions: [
            //             TextButton(
            //               onPressed: () => Navigator.pop(ctx),
            //               child: Text('取消'),
            //             ),
            //             TextButton(
            //               onPressed: () {
            //                 // 执行操作
            //                 Navigator.pop(ctx);
            //               },
            //               child: Text('确定'),
            //             ),
            //           ],
            //         ));

            ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                // action: SnackBarAction(
                //   label: '确定',
                //   onPressed: () {
                //     print('666');
                //   },
                // ),
                content: Text('我通知你'),
                duration: Duration(seconds: 1)));
            // showDialog(
            //     context: ctx,
            //     builder: (BuildContext ctx) {
            //       return Text('12');
            //     });
            // showAboutDialog(context: ctx, children: [
            //   Text('1'),
            //   Text('2'),
            //   Text('3'),
            // ]);
            // showDatePicker(
            //     context: ctx,
            //     initialDate: DateTime.now(),
            //     firstDate: DateTime.now(),
            //     lastDate: DateTime.now());

            // showBottomSheet(context: ctx, builder: (ctx) => getBottom());
            // 跳转页面  命名路由跳转  需要配合路由表
            // Navigator.pushNamed(context, '/home');
            // PromptAction.info('成功');
            // xxxxx('哈哈')
            // Fluttertoast.showToast(
            //     msg: '测试',
            //     gravity: ToastGravity.CENTER,
            //     backgroundColor: Colors.red,
            //     textColor: Colors.white,
            //     // 针对web
            //     webPosition: 'center');
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
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _getChildren(context),
      ),
    );
  }
}
