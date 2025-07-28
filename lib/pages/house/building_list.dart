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
