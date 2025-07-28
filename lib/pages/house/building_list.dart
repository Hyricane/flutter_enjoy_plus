import 'dart:math';

import 'package:flutter/material.dart';

class BuildingList extends StatefulWidget {
  const BuildingList({super.key, required this.point});

  final String point;

  @override
  State<BuildingList> createState() => _RoomListState();
}

class _RoomListState extends State<BuildingList> {
  Map data = {
    "point": "", // 记录小区信息
    "size": 0, // 随机产生楼栋的数量
    "type": "", // 小区的楼栋名称(size>4 单元, size<=4 号楼)
  };

  @override
  void initState() {
    super.initState();
    _getBuildingList();
  }

  _getBuildingList() async {
    data['point'] = widget.point;
    // 请求数据 var res = await xxxx();

    // 5-10
    // mock模拟数据  小区到底有几栋楼 8 随机数
    Random r = Random(); // 随机数实例
    data['size'] = r.nextInt(6) + 5; // 这个数就是表示0-n(不包含)  nextInt表示只要整数
    // print(res); // 0 1
    // Math.floor(Math.random() * 9)  012345678 随机整数

    // 一个小区有超过7栋楼 就用单元命名  小于等于7栋 就用xx号楼
    // print(data['size']);
    data['type'] = data['size'] > 7 ? '单元' : '号楼';
    print(data);

    setState(() {}); // 更新页面
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择楼栋-' + widget.point),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: const Row(
              children: [
                Expanded(child: Text('新龙城4单元')),
                Row(
                  children: [
                    Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.black),
                  ],
                )
              ],
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
