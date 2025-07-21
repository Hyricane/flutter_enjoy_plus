import 'package:flutter/material.dart';

class HomeNotifyList extends StatefulWidget {
  const HomeNotifyList({Key? key, required this.notifyList}) : super(key: key);

  final List notifyList;

  @override
  _HomeNotifyListState createState() => _HomeNotifyListState();
}

class _HomeNotifyListState extends State<HomeNotifyList> {
  // 现在是假数据 一会请求后端获取真实数据即可
  // List notifyList = [
  //   {
  //     'title': '中秋、国庆温馨提示中秋、国庆温馨提示',
  //     'content': '中秋、国庆温馨提示中秋、国庆温馨提示中秋、国庆温馨提示中秋、国庆温馨提示中秋、国庆温馨提示中秋、国庆温馨提示',
  //     'createdAt': '2024-09-22 15:00:00',
  //   },
  //   {
  //     'title': '中秋、国庆温馨提示中秋、国庆温馨提示',
  //     'content': '中秋、国庆温馨提示中秋、国庆温馨提示中秋、国庆温馨提示中秋、国庆温馨提示中秋、国庆温馨提示中秋、国庆温馨提示',
  //     'createdAt': '2024-09-22 15:00:00',
  //   },
  //   {
  //     'title': '中秋、国庆温馨提示中秋、国庆温馨提示',
  //     'content': '中秋、国庆温馨提示中秋、国庆温馨提示中秋、国庆温馨提示中秋、国庆温馨提示中秋、国庆温馨提示中秋、国庆温馨提示',
  //     'createdAt': '2024-09-22 15:00:00',
  //   },
  // ];

  List<Widget> _getRowChildren() {
    return [
      // 图片
      Image.asset(
        'assets/images/notice@2x.png',
        width: 25,
      ),
      // 文字
      const Text(
        '社区',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const Text(
        '公告',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange),
      ),
    ];
  }

  List<Widget> _getListViewChildren() {
    return widget.notifyList.map((item) {
      return GestureDetector(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['title'],
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(item['content']),
              const SizedBox(
                height: 10,
              ),
              Text(
                item['createdAt'],
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        onTap: () {
          // 跳转传参 => flutter中怎么接
          //
          Navigator.pushNamed(context, '/notice_detail',
              arguments: {'id': item['id']});
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(children: [
        Row(
          children: _getRowChildren(),
        ),
        // Expanded(child: child),
        ListView(
          shrinkWrap: true, // 根据内容确定ListView的高度
          physics: const NeverScrollableScrollPhysics(), // 禁止内层滚动  外层有滚动
          children: _getListViewChildren(),
        ),
      ]),
    );
  }
}
